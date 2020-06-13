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
TWO-ZERO FILTER
NOTCH FILTER

y[n] = b0 * x[n] + b1 * x[n - 1] + b2 * x[n - 2]

Hz = b0(1 - 2Rcos(wt)z^-1 + R^2z^-2)

b1/b0 = -2Rcos(wt)
b2/b0 = R^2

w = antiresonance frequency


TWO-POLE FILTER
BAND PASS

y[n] = b0 * x[n] - a1 * y[n - 1] - a2 * y[n - 2]

Hz = b0 / 1 + a1 * z^-1 + a2 * z^-2

a1 = -2 * R * cos(2πfTs)
a2 = R^2

BandWidth_Hz = - ln(R) / πT
BandWidth_Hz = f_high - f_low
f_low = f0 * (1 - 1/2Q)
f_high = f0 * (1 + 1/2Q)
Q = fattore di merito
R = e^(-πBWT)
DecayTime = Q / w0 (circa)
Q = DecayTime * w0


FILTRO PASSA-BASSO RISONANTE DI II ORDINE

y[n] = b0 * x[n] + b1 * x[n - 1] + b2 * x[n - 2] - a1 * y[n - 1] - a2 * y[n - 2]

a1 = -2 * R_poli * cos(w_poli)
a2 = R_poli^2
b1 = -2 * R_zeri * cos(w_zeri)
b2 = R_zeri^2
b0 = 1 + a1 + a2 / 4

R = 1 - Bw / 2 con Bw in rad/s
w_zeri = ((1 + R^2) / 2R) * cos(w0)
*/

  opcode TwoZero, a, akk
aX, kFreq, kQ xin

i2_Pi = 2 * $M_PI
iPi = $M_PI
iE = $M_E

kFLow = kFreq * (1 - (1 /(2 * kQ)))
kFHigh = kFreq * (1 + (1 /(2 * kQ)))
kBw = kFHigh - kFLow
kR = iE^(-iPi * (kBw / sr))

kWt = i2_Pi * kFreq / sr

kb0 = 1
kb1 = -2 * kR * cos(kWt)
kb2 = kR^2
;kN = 1 / i2_Pi
kN = kWt / (2 * kR)

  aY = kb0 * aX + kb1 * delay(aX, 1/sr) + kb2 * delay(aX, 2/sr)

xout (aY * kN)
  endop


  opcode TwoPole, a, akk
aX, kFreq, kQ xin

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

	aY = kb0 * aX - ka1 * aY1 - ka2 * aY2

aY2 = aY1
aY1 = aY

xout aY * kN
  endop


  opcode LowPassRes, a, akk
aX, kFreq, kBw xin

i2_Pi = 2 * $M_PI
kW0 = i2_Pi * kFreq
kWp = kW0 / sr
kBw = i2_Pi * kBw / sr
kR = (1 - kBw / 2)
kWz = ((1 + kR^2) / (2 * kR)) * cos(kWp)

kb1 = -2 * kR^2 * cos(kWz)
kb2 = kR^2
ka1 = -2 * kR^2 * cos(kWp)
ka2 = kR^2
kb0 = (1 + ka1 + ka2) / 4

aY1 init 0
aY2 init 0

aY = aX + kb1 * delay(aX, 1/sr) + kb2 * delay(aX, 2/sr) - ka1 * aY1 - ka2 * aY2

aY2 = aY1
aY1 = aY

aYOut = (aY * kb0) / 2
xout aYOut
  endop


  instr TestTwoZero

;aX = mpulse(1, 0) ;all'impulso
aX = rand(1)
kFreq = 1000
kQ = 300

aY = TwoZero(aX, kFreq, kQ)

  outs(aY, aY)

  	;dispfft(aY, .1, 2048)

  endin

  instr TestTwoPole

;aX = mpulse(1, 0) ;all'impulso
aX = rand(1)
kFreq = 3000
kQ = 360

aY = TwoPole(aX, kFreq, kQ)

  outs(aY, aY)

  	dispfft(aY, .1, 2048)

  endin


  instr TestLPRes

;aX = mpulse(1, 0) ;all'impulso
aX = rand(1)
kFreq = 250
kBw = 10 ;in Hz

aY = LowPassRes(aX, kFreq, kBw)

  outs(aY, aY)

  	dispfft(aY, .1, 2048)

  endin

</CsInstruments>
<CsScore>

i "TestTwoZero" 0 5
i "TestTwoPole" 7 5
i "TestLPRes" 13 5

</CsScore>
</CsoundSynthesizer>
