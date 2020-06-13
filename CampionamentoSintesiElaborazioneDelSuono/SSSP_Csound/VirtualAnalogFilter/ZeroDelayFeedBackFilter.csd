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
ZERO-DELAY FEEDBACK FILTER

Il codice sotto è tratto da "The Art of VA Filter Design", cap. 3
*/

  opcode ZDF_LPHP_1Pole, a, aki
aX, kFreq, iMode xin

/*
aX = sig, in
Kfreq = frequenza di taglio
iMode = se 0 = lowpass; se 1 = highpass
*/

i2_Pi = 2 * $M_PI
kWc = i2_Pi * kFreq
iTs = 1 / sr
kWa = (2 / iTs) * tan(kWc * iTs / 2) ;bilinear trasform from s ---> s'
kG = kWa * iTs / 2

kGuadagno = kG / (1.0 + kG)

aLP, aHP init 0
kZ_1 init 0

kNdx = 0
until (kNdx == ksmps) do
  kX = aX[kNdx]
  kV = (kX - kZ_1) * kGuadagno

  kLP = kV + kZ_1
  kHP = kX - kLP
  kZ_1 = kLP + kV

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

  opcode ZDF_AP_1Pole, a, ak
aX, kFreq xin

aLP = ZDF_LPHP_1Pole(aX, kFreq, 0)
aHP = ZDF_LPHP_1Pole(aX, kFreq, 1)
aAP = aLP - aHP

xout aAP
  endop


  instr TestZDF_LPHP
aX = rand(1)
kFreq = 250
iMode = p4

aY = ZDF_LPHP_1Pole(aX, kFreq, iMode)

  outs(aY, aY)

  endin

  instr TestZDF_AP

aX = rand(1)
kFreq = 500

aY = ZDF_AP_1Pole(aX, kFreq)

  outs(aY, aY)

  endin



</CsInstruments>
<CsScore>

i "TestZDF_LPHP" 0 3 0 ;lowpass
i "TestZDF_LPHP" 4 3 1 ;highpass

i "TestZDF_AP" 9 3 ;allpass

</CsScore>
</CsoundSynthesizer>
