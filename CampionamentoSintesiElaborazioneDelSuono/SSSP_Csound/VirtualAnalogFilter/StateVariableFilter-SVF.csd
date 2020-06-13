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
FILTRO UNIVERSALE O VARIABILE DI STATO

          |-----|
          |     |---> HP
x[n] ---> |     |---> LP
          |     |---> BP
          |     |---> BR
          |-----|


HP = (x[n] - 2Rs_1 - gs_1 - s_2) / (1 + 2Rg + g^2)
BP = HP + s1
LP = BP + s_2
BR = x - 2RBP

R = w1 + w2 / 2wc
g = wa * T / 2
wa = 2 / T * tan(wcT/2) ;prewarp
wc = sqrt(w1 * w2)
wc = 2πf/sr
*/


  opcode SVF, aaaa, aii
aX, iFreq1, iFreq2 xin

i2_Pi = 2 * $M_PI
iT = 1 / sr
kFreq[] = fillarray(iFreq1, iFreq2)
kW[] = i2_Pi * kFreq
kWc = sqrt(kW[0] * kW[1])
kR = ((kW[0] + kW[1]) / 2) / kWc
kWa = (2 / iT) * tan(kWc * iT / 2)
kG = kWa * (iT / 2)
kG1 = 1 + (2 * kR * kG) + kG^2
k2R = 2 * kR

aLP, aHP, aBP, aBR init 0
kS1, kS2 init 0

kNdx = 0
until (kNdx == ksmps) do
  kX = aX[kNdx]
  kHP = (kX - k2R * kS1 - kG * kS1 - kS2) / kG1
  kBP = kG * kHP + kS1
  kLP = kG * kBP + kS2
  kBR = kX - k2R * kBP

  kS1 = kG * kHP + kBP
  kS2 = kG * kBP + kLP

  aHP[kNdx] = kHP
  aLP[kNdx] = kLP
  aBP[kNdx] = kBP
  aBR[kNdx] = kBR

  kNdx += 1
od

xout aHP, aLP, aBP, aBR
  endop


  instr SVF

aX = rand(1)

iFreq1 = 5000
iFreq2 = 5050

aHp, aLp, aBp, aBr SVF aX, iFreq1, iFreq2

aSVF[] init 4
aSVF[0] = aHp
aSVF[1] = aLp
aSVF[2] = aBp
aSVF[3] = aBr

aOut = aSVF[p4]

      outs(aOut, aOut)

        dispfft(aOut, .1, 2048)

  endin



</CsInstruments>
<CsScore>

i "SVF" 0  5 3
i "SVF" 6  5 1
i "SVF" 12 5 2
i "SVF" 18 5 3

</CsScore>
</CsoundSynthesizer>
