<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1 ;deve essere 1 kr = sr
nchnls = 2
0dbfs = 1

/*
AGS -Asynchronous Granular Synthesis-
-gCt (Grains Clouds Texture) Sound Granulation and Synthetic Grains-
by Pasquale Mainolfi

f = sr * I/L = frequenza naturale
I = passo di campionamento
sr = sample rate
L = lunghezza in campioni della tabella

Formula sintesi granulare
s[n] = ∑ak·gk[n - nk]

ad inviluppo gaussiano
f(x) = (1/(sigma * √2π)) * exp^(-((x - mi)^2)/(2 * sigma^2))
*/

  opcode PhaseMap, i, iiiii ;funzione per il controllo della fase (mappatura)
iIn, iOutMin, iOutMax, iInMin, iInMax xin
iY = (((iIn - iInMin) * (iOutMax - iOutMin)) / (iInMax - iInMin)) + iOutMin
xout(iY)
  endop

  opcode GaborGauss, a, iii ;funzione gaussiana
iDur, iSigma, iMi xin

iPi = $M_PI
kExp = $M_E
kSegmento = phasor(1/iDur) * (2 * iPi)
aGauss = (1/(iSigma * sqrt(2 * iPi))) * kExp^(-((kSegmento - iMi)^2)/(2 * iSigma^2)) ;inviluppo gaussiano (Gabor way)

xout(aGauss)
  endop

seed(0)

giAudio = ftgen(2, 0, 0, -1, "TestGrain_3.wav", 0, 0, 0) ;sound granulation
giSine = ftgen(3, 0, 16385, 10, 1) ;synthetic grains

giDelSample init 0 ;indice di overlapp

  instr Costruttore

/*
iF_Min = frequenza limite inferiore (con sine devono essere valori di frequenza reali, con suoni campionati, invece, moltiplicatori della frequenza naturale)
iF_Max = frequenza limite superiore
iA_Min = ampiezza limite inferiore
iA_Max = ampiezza limite superiore
iP_Min = fase limite inferiore (valori mappati tra 0 e 1)
iP_Max = fase limite superiore
iT_Min = durata limite inferiore
iT_Max = durata limite superiore
iR_Min = ritardo d'innesco limite inferiore (in percentuale dell'intera durata singolo grano)
iR_Max = ritardo d'innesco limite superiore (in percentuale dell'intera durata singolo grano)
iS_Min = limite superiore collocazione spaziale (fronte stereo = 0)
iS_Max = limite inferiore collocazione spaziale (fronte stereo = 1)
iMode = 0 -> mantieni la stessa durata; 1 -> downsampling/upsampling
*/

giFunc = giAudio
iL = ftlen(giFunc)

/*
ricostruzione del suono di partenza mediante granulazione
*/

giW_Finestra = 4096
giW_Overlapp = 1024

iF_Min = 1
iF_Max = 1
iA_Min = .7
iA_Max = .7
iP_Min = 0 ;1 lettura retrograda
iP_Max = 0
iT_Min = giW_Finestra/sr
iT_Max = giW_Finestra/sr
iR_Min = giW_Overlapp/sr
iR_Max = giW_Overlapp/sr
iS_Min = .5
iS_Max = .5
iMode = 0 ;0 -> mantieni la stessa durata; 1 -> downsampling/upsampling

; iF_Min = .3
; iF_Max = 12
; iA_Min = .7
; iA_Max = .7
; iP_Min = 0
; iP_Max = 1
; iT_Min = .001
; iT_Max = .025
; iR_Min = .025
; iR_Max = .1
; iS_Min = 0
; iS_Max = 1
; iMode = 0

;---parametri grano---
reini:
giF = random(iF_Min, iF_Max) ;generazione dei valori randomici di frequenza, ampiezza e fase
giA = random(iA_Min, iA_Max)
giP = random(iP_Min, iP_Max)

giT = random(iT_Min, iT_Max) ;generazione randomica del valore di durata del singolo grano
giTtoSample = ceil(sr * giT) ;conversione in campioni (valore intero)
giTtoTime = giTtoSample/sr ;riconversione valore intero di campioni in tempo

giR = random(iR_Min, iR_Max) ;generazione randomica del valore di ritardo tra una generazione e l'altra (distanza temporale tra un grano e l'altro)
giRtoSample = ceil(sr * giR)
giRtoTime = giRtoSample/sr

giS = random(iS_Min, iS_Max) ;generazione randomica del valore di controllo dei grani nel panorama stereo

giPhaseW = PhaseMap(giP, 0, giTtoSample, 0, 1) ;mappatura fase finestra w

if(iMode = 0) then
  gij = giF
  gik = 1
  gil = 1
  elseif(iMode = 1) then
    gij = 1
    gik = 1/giF
    gil = giF
  endif

iDurTotale = iL/sr ;inverso della frequenza di lettura, durata complessiva in secondi
giTotalDurTime = iDurTotale * gik
giTotalDurSample = ceil(sr * giTotalDurTime);per adattare la lunghezza della tabella
giPhaseFunction = PhaseMap(giP, 0, giTotalDurSample, 0, 1) ;mappatura fase

  timout(0, giRtoTime, go)
  reinit reini

go:
schedule("CloudsTexture", 0, giTtoTime)

  endin


  instr CloudsTexture
;---------------------------------------------------
;costruzione del segmento d'inviluppo
;---gaussiano---
iSigma = 1
iMi = $M_PI
aInv = GaborGauss(giTtoTime, iSigma, iMi);inviluppo gaussiano (Gabor way)
;---------------------------------------------------

ix = giDelSample ;overlapp -> scorre lungo l'intera tabella ogni giDelSample campioni (sposta la finestratura)

giDelSample += giRtoSample

if(giDelSample > giTotalDurSample) then ;quando raggiunge l'intera lunghezza della tabella si azzera e riparte (lettura continua)
    giDelSample = 0
endif

;---finestratura---
ki init 0
if(ki < (giTtoSample + 1)) then
  kIndx = abs(giPhaseW - ki) * gij
  kOverlapp = abs(giPhaseFunction - ix) * gil
  aGrano = (giA * aInv) * tablei:a((kIndx + kOverlapp), giFunc)
  ki += 1
endif
;------------------

aY = (aGrano * (1 - rms:k(aGrano))^2) / (abs(log10(giR)) + 1) ;controllo dell'ampiezza

aLeft = aY * sqrt(giS) ;controllo dello spazio
aRight = aY * (1 - sqrt(giS))

  outs(aLeft, aRight)

  endin


</CsInstruments>
<CsScore>

i "Costruttore" 0 60

</CsScore>
</CsoundSynthesizer>
