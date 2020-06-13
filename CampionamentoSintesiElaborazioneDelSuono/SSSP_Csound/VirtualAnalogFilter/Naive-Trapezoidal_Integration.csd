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
NAIVE 1-POLE LOWPASS FILTER
y[n] = x + yz^-1
H(z) = 1 / 1 - z^-1

---> H(z) = y / x = wc / 1 - (1 - wc) * z^-1

NAIVE 1-POLE HIGHPASS FILTER
HP = X - LowPass


TRAPEZOIDAL INTEGRATION
y[n] = uz^-1 + (x / 2)
u[n] = y + (x / 2)

H(z) = wcT / 2 * [(z + 1) / (z - 1)]

DIRETTA I
v = g(x + x[n - 1])
y = v + (1 - g) * y[n - 1]

DIRETTA II CANONICA
u = x + u[n - 1]
y = g(v + u[n - 1])

DIRECT II TRASPOSTA
v = g(x - y)
y = v + u[n - 1]
u = x + y
*/

  opcode NaiveOnePole, a, aki
aX, kFreq, iMode xin

i2_Pi = 2 * $M_PI
kWc = i2_Pi * kFreq / sr

kG = kWc

kZ_1 init 0

kNdx = 0
until (kNdx == ksmps) do
  kX = aX[kNdx]
  kV = kG * (kX - kZ_1)

  kLP = kV + kZ_1
  kHP = (kX - kLP) / 2
  kZ_1 = kLP

  aLP[kNdx] = kLP
  aHP[kNdx] = kHP

  kNdx += 1
od

if(iMode = 0) then
  aY = aLP
  elseif(iMode = 1) then
    aY = aHP
  endif

xout aY
  endop



  opcode TrapezoidalOnePole, a, aki
aX, kFreq, iMode xin

i2_Pi = 2 * $M_PI
kWc = i2_Pi * kFreq

iT = (1 / sr)
kG = (kWc * iT) / 2

aZ1 init 0
aLP init 0

aV = kG * (aX - aLP)
aLP = aV + aZ1
aHP = aX - aLP
aZ1 = aV + aLP

if(iMode = 0) then
  aY = aLP
  elseif(iMode = 1) then
    aY = aHP
  endif

xout aY
  endop



  instr Test_Naive
aX = rand(1)
kFreq = 1500
iMode = p4

aNaive = NaiveOnePole(aX, kFreq, iMode)

  outs(aNaive, aNaive)

    dispfft(aNaive, .1, 2048)

  endin


  instr Test_Trapezoidal
aX = rand(1)
kFreq = 5000
iMode = p4

aY = TrapezoidalOnePole(aX, kFreq, iMode)

  outs(aY, aY)

    dispfft(aY, .1, 2048)

  endin



</CsInstruments>
<CsScore>

i "Test_Naive" 0 5 0
i "Test_Naive" 6 5 1

i "Test_Trapezoidal" 12 6 0
i "Test_Trapezoidal" 19 5 1

</CsScore>
</CsoundSynthesizer>
