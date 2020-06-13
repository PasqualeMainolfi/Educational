<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1

#include "SequencesAndSeries.udo"

gkFormanti[] = fillarray(1, 2, 3, 4, 5, 6, 7, 8, 9)
giNumForm = lenarray(gkFormanti)

  instr FourierApproximation

iFond = 220
iAmp = .9
iSinSeries = 0
iCosSeries = 1

aSig[] init 4

;---SQUARE WAVE---
kCoeff_Square[] = squareWave(giNumForm)
aSig[0] = trigSeries(iSinSeries, iAmp, iFond, kCoeff_Square, gkFormanti, giNumForm)
;-----------------

;---TRIANGLE WAVE---
kCoeff_Triangle[] = triangleWave(giNumForm)
aSig[1] = trigSeries(iCosSeries, iAmp, iFond, kCoeff_Triangle, gkFormanti, giNumForm)
;-------------------

;---SAWTOOTH WAVE 1---
kCoeff_SawTooth_1[] = sawTooth_1(giNumForm)
aSig[2] = trigSeries(iSinSeries, iAmp, iFond, kCoeff_SawTooth_1, gkFormanti, giNumForm)
;---------------------

;---SAWTOOTH WAVE 2---
kCoeff_SawTooth_2[] = sawTooth_2(giNumForm)
aSig[3] = trigSeries(iSinSeries, iAmp, iFond, kCoeff_SawTooth_2, gkFormanti, giNumForm)
;---------------------

aOut = expseg:k(.001, p3/2, 1, p3/2, .001) * aSig[p4]

  dispfft(aOut, .1, 2048)


	outs(aOut, aOut)

  endin

</CsInstruments>
<CsScore>
i "FourierApproximation" 0  5 0
i "FourierApproximation" 5  5 1
i "FourierApproximation" 10 5 2
i "FourierApproximation" 15 5 3
</CsScore>
</CsoundSynthesizer>
