/*
Granular Oscillator
-gCtOsc Grains Clouds Texture Oscillator-
by Pasquale Mainolfi

gCtOsc -> synthetic grains
gCtsOsc -> sound granulation
*/

    opcode gCtOsc, a, iiiiiiiii

seed(0)
setksmps(1)
/*
iF_Min = frequenza limite inferiore
iF_Max = frequenza limite superiore
iA_Min = ampiezza limite inferiore
iA_Max = ampiezza limite superiore
iT_Min = durata limite inferiore
iT_Max = durata limite superiore
iR_Min = ritardo d'innesco limite inferiore (in percentuale dell'intera durata singolo grano)
iR_Max = ritardo d'innesco limite superiore (in percentuale dell'intera durata singolo grano)
iFun = funzione d'inviluppo
*/

iF_Min, iF_Max, iA_Min, iA_Max, iT_Min, iT_Max, iR_Min, iR_Max, iFun xin

iStep = 1/sr
i2_Pi = 2 * $M_PI
iL = ftlen(iFun)

reini:
iF = random(iF_Min, iF_Max)
iA = random(iA_Min, iA_Max)
iT = random(iT_Min, iT_Max)
iR = random(iR_Min, iR_Max)

iTtoSample = floor(sr * iT)
iTtoTime = iTtoSample/sr

iRtoSample = floor(sr * iR)
iRtoTime = iRtoSample/sr

ia = iTtoTime/4
ib = ia
ic = iTtoTime - (ia + ib)

kC = linseg(0, ia, 1, ic, 1, ib, 0)

    timout(0, iTtoTime + iRtoTime, go)
    reinit reini


go:
aPh init 0

ki init 0
if(ki < iTtoSample) then
    aW = i2_Pi * aPh * iF
    aY = iA * sin(aW)
    aY = (aY * tablei:a(phasor(1/iTtoTime) * iL, iFun)) * kC
    aPh += a(iStep)
    ki += 1
endif

aOut = aY
rireturn

xout(aOut)
    endop


;------------------------------
;------------------------------
;------------------------------


/*
AGS su suoni campionati
*/

    opcode PhaseMap, i, iiiii ;per il controllo della fase (mappatura)
iIn, iOutMin, iOutMax, iInMin, iInMax xin
iY = (((iIn - iInMin) * (iOutMax - iOutMin)) / (iInMax - iInMin)) + iOutMin
xout(iY)
    endop


    opcode gCtsOsc, a, iiiiiiiiiiii

seed(0)
setksmps(1)
/*
iF_Min = frequenza limite inferiore (in questo caso, funge da moltiplicatore frequenza propria di lettura sr/LenTab)
iF_Max = frequenza limite superiore (in questo caso, funge da moltiplicatore frequenza propria di lettura sr/LenTab)
iA_Min = ampiezza limite inferiore
iA_Max = ampiezza limite superiore
iP_Min = controllo del limite superiore fase (0) ;nota bene se uguale a 0 min e max lettura in avanti, se uguale a 1 min e max lettura retrograda
iP_Max = controllo del limite superiore fase (1)
iT_Min = durata limite inferiore
iT_Max = durata limite superiore
iR_Min = ritardo d'innesco limite inferiore (in percentuale dell'intera durata singolo grano)
iR_Max = ritardo d'innesco limite superiore (in percentuale dell'intera durata singolo grano)
iFunInv = funzione d'inviluppo
iFunSample = tabella file audio da granulare
*/

iF_Min, iF_Max, iA_Min, iA_Max, iP_Min, iP_Max, iT_Min, iT_Max, iR_Min, iR_Max, iFunInv, iFunSample xin

iL = ftlen(iFunSample)

reini:
iF = random(iF_Min, iF_Max)
iA = random(iA_Min, iA_Max)
iP = random(iP_Min, iP_Max)
iT = random(iT_Min, iT_Max)
iR = random(iR_Min, iR_Max)

iPhase = PhaseMap(iP, 0, ftlen(iFunSample), 0, 1)

iTtoSample = floor(sr * iT)
iTtoTime = iTtoSample/sr

iRtoSample = floor(sr * iR)
iRtoTime = iRtoSample/sr

ia = iTtoTime/16
ib = ia
ic = iTtoTime - (ia + ib)

kC = linseg(0, ia, 1, ic, 1, ib, 0)

    timout(0, iRtoTime + iTtoTime, go)
    reinit reini
    rireturn


go:
ki init 0
if(ki < iL) then
    kIndx = abs(iPhase - ki)
    aTab = tablei(kIndx * iF, iFunSample)
    aY = (iA * (aTab * tablei:a(phasor(1/iTtoTime), iFunInv, 1))) * kC
    ki += 1
    ki = ki%iL
endif

aOut = aY

xout(aOut)
    endop
