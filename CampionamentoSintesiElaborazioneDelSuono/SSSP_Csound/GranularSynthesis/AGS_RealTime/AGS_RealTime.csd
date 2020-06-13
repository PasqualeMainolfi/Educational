09<CsoundSynthesizer>
<CsOptions>
-odac -iadc
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1


#include "GrainLib.udo"



seed(0)
giDelSample init 0 ;indice di overlapp

  instr Costruttore

giSource = LiveIn(32768) ;live input
;giSource = SoundGranulation("TestGrain_3.wav") ;sound granulation
iL = ftlen(giSource)

giW_Finestra = 4096/sr
giW_Overlapp = 1024/sr

iF_Min = .5
iF_Max = 10
iA_Min = .9
iA_Max = .9
iP_Min = 0
iP_Max = 0
iT_Min = .001
iT_Max = .05
iR_Min = .025
iR_Max = .05
iS_Min = .5
iS_Max = .5
iMode = 1

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
  aGrano = (giA * aInv) * table3:a((kIndx + kOverlapp), giSource)
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

i "Costruttore" 0 100

</CsScore>
</CsoundSynthesizer>
