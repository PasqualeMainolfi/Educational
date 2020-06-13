/*
SUCCESSIONI E SERIE

SERIE: ...la somma degli elementi di una successione.
SUCCESSIONE O PROGRESSIONE: ...una sequenza infinita di numeri reali.

- SERIE E SUCCESSIONE ARITMETICA
- SERIE E SUCCESSIONE GEOMETRICA
- SERIE E SUCCESSIONE ARMONICA
- SERIE E SUCCESSIONE TELESCOPICA

- SERIE TRIGONOMETRICHE
- SERIE DI FOURIER
*/

    opcode seqAritmetica, k[], iki //sequenza aritmetica
istart, kd, ilen xin
kseq[] init ilen
ki init 0
until (ki == ilen) do
    kseq[ki] = istart + ((ki + 1) - 1) * kd
    printf("\ntermine[%d] = %f\n\n", ki + 1, ki, kseq[ki])
    ki += 1
od
xout(kseq)
    endop

    opcode seqGeometrica, k[], iki //sequenza geometrica
istart, kd, ilen xin
kseq[] init ilen
ki init 0
until (ki == ilen) do
    kseq[ki] = istart * kd^(ki - 1)
    printf("\ntermine[%d] = %f\n\n", ki + 1, ki, kseq[ki])
    ki += 1
od
xout(kseq)
    endop

    opcode seqArmonica, k[], k[] //sequenza armonica
kseqArit[] xin
ilen = lenarray:i(kseqArit)
kseq[] init ilen
ki init 0
until (ki == ilen) do
    kseq[ki] = 1/kseqArit[ki]
    printf("\ntermine[%d] = %f\n\n", ki + 1, ki, kseq[ki])
    ki += 1
od
xout(kseq)
    endop

    opcode seqTelescopica, k[], ii //sequenza telescopica (nell'esempio sequenza di Mengoli)
istart, ilen xin
kseq[] init ilen
ki init 1
until (ki == ilen) do
    kseq[ki] = istart/(ki * (ki + 1))
    printf("\ntermine[%d] = %f\n\n", ki + 1, ki, kseq[ki])
    ki += 1
od
xout(kseq)
    endop


    opcode series, a, kkk[]k[]o
kf0, kmaxAmp, kserieFreq[], kserieAmp[], icount xin

iN = lenarray:i(kserieAmp) - 1
asig = ((kmaxAmp * kserieAmp[icount]) * sin(phasor:k(kf0 * kserieFreq[icount]) * 2 * $M_PI))/iN

if(icount < iN) then
    asign = series(kf0, kmaxAmp, kserieFreq, kserieAmp, icount + 1)
endif

aout = (asig + asign)
xout(aout)
    endop


  opcode trigSeries, a, ikkk[]k[]io
iSerie, kAmp, kFund, kCoeff[], gkForm[], iNum, iCount xin

/*
iSerie = 0 for sine series, 1 for cosine series
kAmp = amp of fundamental frequency
kFund = Fundamental Frequency
kCoeff[] = array of amplitude coefficients
gkForm[] = array of values that multiply the fundamental frequency (Formants)
iNum = total number of formants
iCount = counter
*/

i2_Pi = 2 * $M_PI

if(iSerie == 0) then
  aSig = (kAmp*kCoeff[iCount]) * sin(i2_Pi * (phasor:k(kFund * gkForm[iCount])))/iNum
  elseif(iSerie == 1) then
    aSig = (kAmp*kCoeff[iCount]) * cos(i2_Pi * (phasor:k(kFund * gkForm[iCount])))/iNum
  endif

iDigi = iCount + 1

if(iDigi < iNum) then
  aSigSum = trigSeries(iSerie, kAmp, kFund, kCoeff, gkForm, iNum, iDigi)
endif

xout(aSig + aSigSum)
  endop


  opcode squareWave, k[], i
iLen xin

iPi = $M_PI
kCoefficienti[] init iLen

kIndx = 0
until (kIndx == iLen) do
  kNd = kIndx + 1
  kPot = (-1)^(kNd)
  kNumeratore = 2 - (2 * kPot)
  kDenominatore = kNd * iPi
  kCoefficienti[kIndx] = kNumeratore / kDenominatore
  kIndx += 1
od

xout(kCoefficienti)
  endop

  opcode triangleWave, k[], i
iLen xin

iPi = $M_PI
kCoefficienti[] init iLen

kIndx = 0
until (kIndx == iLen) do
  kNd = kIndx + 1
  kPot = (-1)^(kNd)
  kNumeratore = 4 - (4 * kPot)
  kDenominatore = (kNd * iPi)^2
  kCoefficienti[kIndx] = kNumeratore / kDenominatore
  kIndx += 1
od

xout(kCoefficienti)
  endop

  opcode sawTooth_1, k[], i
iLen xin

iPi = $M_PI
kCoefficienti[] init iLen

kIndx = 0
until (kIndx == iLen) do
  kNd = kIndx + 1
  kPot = (-1)^(kNd)
  kNumeratore = iPi * -2 * (kNd * iPi * kPot)
  kDenominatore = (kNd * iPi)^2
  kCoefficienti[kIndx] = kNumeratore / kDenominatore
  kIndx += 1
od

xout(kCoefficienti)
  endop

  opcode sawTooth_2, k[], i
iLen xin

iPi = $M_PI
kCoefficienti[] init iLen

kIndx = 0
until (kIndx == iLen) do
  kNd = kIndx + 1
  kPot = (-1)^(kNd)
  kNumeratore = 2 * (kNd * iPi * kPot)
  kDenominatore = (kNd^2) * iPi
  kCoefficienti[kIndx] = kNumeratore / kDenominatore
  kIndx += 1
od

xout(kCoefficienti)
  endop
