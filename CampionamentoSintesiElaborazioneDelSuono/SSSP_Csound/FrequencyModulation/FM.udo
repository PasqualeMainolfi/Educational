/*
FREQUENCY MODULATION

  s(t) = Ap sin[wpt + (k * Am/wm) sin(wmt)]

  k * Am/wm = m (indice di modulazione)
  m * fm = DeltaF (massima deviazione di frequenza)

  ---> s(t) = Ap sin[wpt + m sin(wmt)]
*/

  opcode Simple_FM, a, kkkkk
kFreqCar, kRatio, kAmpCar, kAmpMod, kCost xin

/*
kFreqCar = frequenza portante
kRatio = C:M ratio
kAmpCar = ampiezza della portante
kAmpMod = ampiezza della modulante
kCost = costante caratteristica del modulatore
*/

i2_Pi = 2 * $M_PI
kFreqMod = (kFreqCar / kRatio)
kWp = i2_Pi * phasor(kFreqCar)
kWm = i2_Pi * phasor(kFreqMod)
kM = ((kCost * kAmpMod) / (i2_Pi * kFreqMod))

aSigMod = kAmpCar * sin(kWp + (kM * (sin(kWm))))

xout aSigMod
  endop


  opcode CompCar_FM, a, kkkkkk[]k[]io
kFreqCar, kRatio, kAmpCar, kAmpMod, kCostCar, kCoeff[], kForm[], iNum, iCount xin

/*
FM A PORTANTE COMPOSTA
kFreqCar = frequenza portante
kRatio = C:M ratio
kAmpCar = ampiezza della portante
kAmpMod = ampiezza della modulante
kCost = costante caratteristica del modulatore
kCoeff[] = array ampiezze formanti della portante
kForm[] = array valori che moltiplicano la frequenza portante (Formanti)
iNum = numero totale delle formanti della portante
*/

i2_Pi = 2 * $M_PI

kWp = i2_Pi * phasor:k(kFreqCar * kForm[iCount])

kFreqMod = kFreqCar / kRatio
kWm = i2_Pi * phasor:k(kFreqMod)
kM = (kCostCar * kAmpMod) / (i2_Pi * kFreqMod)

aSig = (kAmpCar * kCoeff[iCount]) * sin(kWp + (kM * sin(kWm))) / iNum

iDigi = iCount + 1
if(iDigi < iNum) then
  aCompCar = CompCar_FM(kFreqCar, kRatio, kAmpCar, kAmpMod, kCostCar, kCoeff, kForm, iNum, iDigi)
endif

xout aSig + aCompCar
  endop


  opcode CompMod_FM, a, kkkkkk[]k[]io
kFreqCar, kRatio, kAmpCar, kAmpMod, kCostCar, kCoeff[], kForm[], iNum, iCount xin

/*
FM A MODULANTE COMPOSTA
kFreqCar = frequenza portante
kRatio = C:M ratio
kAmpCar = ampiezza della portante
kAmpMod = ampiezza della modulante
kCost = costante caratteristica del modulatore
kCoeff[] = array ampiezze formanti della modulante
kForm[] = array valori che moltiplicano la frequenza modulante (Formanti)
iNum = numero totale delle formanti della modulante
*/

i2_Pi = 2 * $M_PI

kWp = i2_Pi * phasor:k(kFreqCar)

kFreqMod = kFreqCar / kRatio
kWm = i2_Pi * phasor:k(kFreqMod * kForm[iCount])
kM = (kCostCar * (kAmpMod * kCoeff[iCount])) / (i2_Pi * kFreqMod)

aSig = (kAmpCar * sin(kWp + (kM * sin(kWm)))) / iNum

iDigi = iCount + 1
if(iDigi < iNum) then
  aCompMod = CompMod_FM(kFreqCar, kRatio, kAmpCar, kAmpMod, kCostCar, kCoeff, kForm, iNum, iDigi)
endif

xout aSig + aCompMod
  endop


  opcode FeedBack_FM, a, kkk
kFreq, kAmp, kBeta xin

/*
FEEDBACK FM A SINGOLO OSCILLATORE
kFreq = frequenza portante
kAmp = ampiezza della portante
kBeta = fattore di feedback
*/

aFeedBack init 0
kWp = (2 * $M_PI) * phasor:k(kFreq)

aSig = kAmp * sin(kWp + kBeta * aFeedBack)
aFeedBack = aSig

xout aSig
    endop
