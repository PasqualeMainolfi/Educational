<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1


#include "Low-HighPassFilter.udo"

  instr Subtractive_ParallelMode

/*
                                   -------
                  Filter 1 ------> |     |
                  Filter 2 ------> |     |
  INPUTS ------>  Filter 3 ------> |  +  | ------> OUT
                  Filter 4 ------> |     |
                  Filter 5 ------> |     |
                                   -------
*/

aFilt1 = butbp(rand(1), 1500, 70)
aFilt2 = butbp(rand(1), 1900, 50)
aFilt3 = butbp(rand(1), 2500, 15)
aFilt4 = butbp(rand(1), 3600, 10)
aFilt5 = butbp(rand(1), 6000, 25)

aOut = linseg:k(0, p3/4, 1, p3 - (p3/4), 0) * tone(aFilt1 + aFilt2 + aFilt3 + aFilt4 + aFilt5, 7000)



	outs(aOut, aOut)

		dispfft(aOut, .1, 2048)

  endin


  instr Subtractive_SeriesMode

/*

INPUTS ------> Filter 1 ------> Filter 2 ------> Filter 3 ------> Filter 4 ------> Filter 5 ------> OUT

*/

aNoise = rand(1)

aFilt1 = butbp(aNoise, 6000, 50)
aFilt2 = butbp(aFilt1, 6000, 50)
aFilt3 = butbp(aFilt2, 6000, 50)
aFilt4 = butbp(aFilt3, 6000, 50)
aFilt5 = butbp(aFilt4, 6000, 50)

aFiltLP = LowPass:a(LowPass:a(LowPass:a(aNoise, 250), 250), 250)
aFiltHP = HighPass:a(HighPass:a(HighPass:a(HighPass(linseg:k(0, 3/4 * p3, 1, p3 - (3/4 * p3), 0) * aNoise, 10000), 10000), 10000), 10000)

aOut = linseg:k(0, p3/4, 1, p3 - (p3/4), 0) * (aFilt5 + aFiltLP) + aFiltHP


	outs(aOut, aOut)

		dispfft(aOut, .1, 2048)

  endin



</CsInstruments>
<CsScore>
;i "Subtractive_ParallelMode" 0 7
i "Subtractive_SeriesMode" 0 7
</CsScore>
</CsoundSynthesizer>
