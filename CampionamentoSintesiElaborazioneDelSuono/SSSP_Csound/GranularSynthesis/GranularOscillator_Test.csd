<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1 ;deve essere 1 kr = sr
nchnls = 2
0dbfs = 1


#include "GranularOscillator.udo"

  instr Test_1

iGauss = ftgen(1, 0, 16385, 20, 6)


iF_Min1 = 250
iF_Max1 = 1200
iA_Min1 = .7
iA_Max1 = .7
iT_Min1 = .0001
iT_Max1 = .055
iR_Min1 = .001
iR_Max1 = .003

iF_Min2 = 250
iF_Max2 = 500
iA_Min2 = .7
iA_Max2 = .9
iT_Min2 = .1
iT_Max2 = .3
iR_Min2 = .01
iR_Max2 = .05


aG1 = gCtOsc(iF_Min1, iF_Max1, iA_Min1, iA_Max1, iT_Min1, iT_Max1, iR_Min1, iR_Max1, iGauss) ;voce 1
aG2 = gCtOsc(iF_Min2, iF_Max2, iA_Min2, iA_Max2, iT_Min2, iT_Max2, iR_Min2, iR_Max2, iGauss) ;voce 2

  outs(aG1, aG2)

  endin


  instr Test_2

iAudio = ftgen(1, 0, 0, -1, "TestGrain_3.wav", 0, 0, 0)
iGauss = ftgen(2, 0, 16385, 20, 6)
iTrapez = ftgen(3, 0, 16385, -7, 0, (1/8) * 16384, .9, 16385 - (2 * 16384/8), .9, (1/8) * 16384, 0)

iF_Min = .5
iF_Max = 30
iA_Min = .7
iA_Max = .7
iP_Min = 0 ;per lettura retrogada min e max = 1
iP_Max = 0
iT_Min = .001
iT_Max = .05
iR_Min = .05
iR_Max = .01


aSampleGrain = gCtsOsc(iF_Min, iF_Max, iA_Min, iA_Max, iP_Min, iP_Max, iT_Min, iT_Max, iR_Min, iR_Max, iTrapez, iAudio)

outs(aSampleGrain, aSampleGrain)

  endin


</CsInstruments>
<CsScore>

;i "Test_1" 0 10
i "Test_2" 0 100

</CsScore>
</CsoundSynthesizer>
