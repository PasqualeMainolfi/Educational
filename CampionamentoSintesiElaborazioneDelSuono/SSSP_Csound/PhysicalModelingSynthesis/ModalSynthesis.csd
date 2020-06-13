<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1

/*
a partire da ---> Ae^(-t/r)sin(wt)
possiamo riprodurre la stessa con un'equazione di secondo ordine (filtro risonante II ordine):

---> Hz = 1 / Ms^2 + Bs + K = K0 * a0 / s^2 + a1 * s + a0

M = massa
B = damping factor
K = stifness
a1 = B/M
a0 = K/M
K0 = 1/K

dunque:

---> Hz = b0 / 1 + a1 * z^-1 + a2 * z^-2 ---> y[n] = b0 * x[n] - a1 * y[n - 1] - a2 * y[n - 2]

a1 = -2 * R * cos(2πfTs)
a2 = R^2
b0 = assumiamo 1

R = raggio (damping) 0 < R < 1 ---> R = 1 = sine

BandWidth_Hz = - ln(R) / πT
BandWidth_Hz = f_high - f_low
f_low = f0 * (1 - 1/2Q)
f_high = f0 * (1 + 1/2Q)
Q = fattore di merito
R = e^(-πBWT)
DecayTime = Q / w0 (circa)
Q = DecayTime * w0
*/


	opcode Mode, a, akkk ;singolo modo
setksmps(1)
aIn, kFreq, kQ, kAmp xin

/*
aIn = exiter
kFreq = frequenza di risonanza
kQ = fattore di merito, da cui ricavare larghezza di banda e raggio del polo complesso (damping).
kAmp = ampiezza
*/

i2_Pi = 2 * $M_PI
iPi = $M_PI
iE = $M_E

kFLow = kFreq * (1 - (1 /(2 * kQ)))
kFHigh = kFreq * (1 + (1 /(2 * kQ)))
kBw = kFHigh - kFLow
kR = iE^(-iPi * (kBw / sr))

kWt = i2_Pi * kFreq / sr

ka1 = -2 * kR * cos(kWt)
ka2 = kR^2
kb0 = 1
kN = kWt / (2 * kQ)

aY1, aY2 init 0

	aY = kb0 * aIn - ka1 * aY1 - ka2 * aY2

aY2 = aY1
aY1 = aY

aOut = ((kN * aY) * kAmp)

xout aOut
	endop



	opcode ModeX, a, ak[]k[]k[]io ;sommatoria di modi
setksmps(1)
aIn, kFreq[], kQ[], kAmp[], iNum, iCount xin

i2_Pi = 2 * $M_PI
iPi = $M_PI
iE = $M_E

kFLow = kFreq[iCount] * (1 - (1 /(2 * kQ[iCount])))
kFHigh = kFreq[iCount] * (1 + (1 /(2 * kQ[iCount])))
kBw = kFHigh - kFLow
kR = iE^(-iPi * (kBw / sr))

kWt = i2_Pi * kFreq[iCount] / sr

ka1 = -2 * kR * cos(kWt)
ka2 = kR^2
kb0 = 1
kN = kWt / (2 * kQ[iCount]) ;normalizzazione

aY1, aY2 init 0

	aY = (kb0 * aIn - ka1 * aY1 - ka2 * aY2)

aY2 = aY1
aY1 = aY

aY = (aY * kAmp[iCount])

iDigitus = iCount + 1
if(iDigitus < iNum) then
	aY_Out = ModeX(aIn, kFreq, kQ, kAmp, iNum, iDigitus)
endif

aOut = ((aY * kN)) + aY_Out

xout aOut
	endop




  instr Modal_1

iTab = ftgen(1, 0, 16385, 20, 2)
aX = cosseg:k(0, .01, .9, .03, .9, .09, 0) * rand(5)
aExc = cosseg:k(0, .01, .9, .01, 0) * tone(tone(rand(15), 90), 90)


iN = 6
iFond = 600

kRatio[] = fillarray(1, 2.572, 4.644, 6.984, 9.723, 12)
kFreqs[] = kRatio * iFond
kAmp[] = fillarray(1, 1/2, 1/3, 1/4, 1/5, 1/6)
kQ[] = fillarray(300, 136, 360, 270, 430.6, 450)

	aModeX = ModeX(aX, kFreqs, kQ, kAmp, iN)

aY = aModeX + aExc

  outs(aY, aY)

  endin


</CsInstruments>
<CsScore>

i "Modal_1" 0 10

</CsScore>
</CsoundSynthesizer>
