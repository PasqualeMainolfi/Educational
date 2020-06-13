<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1


#include "Dattorro_Reverb.udo"
#include "Schroeder-Moorer_Reverb.udo"
#include "Schroeder-Chowning_Reverb.udo"



gaRev init 0

  instr SoundFile

SAudioFile = "TestAudioFile.wav"
iDur = filelen(SAudioFile)
p3 = iDur

aL, aR diskin SAudioFile

  outs(aL / 2, aR / 2)

      gaRev = gaRev + (((aL + aR) / 2) * .3)

  endin

  instr Reverb_Test

aIn = gaRev
iT60 = 3
kFreqLowPass_1 = 10000
kFreqLowPass_2 = 7000
iDecay = .9


if(p4 = 1) then
  aLeft, aRight Schroeder_Moorer aIn, iT60
  elseif(p4 = 2) then
    aLeft, aRight Schroeder_Chowning aIn, iT60, kFreqLowPass_2
    elseif(p4 = 3) then
      aLeft, aRight Dot_Plate aIn, iT60, iDecay, kFreqLowPass_1, kFreqLowPass_2
    endif

  outs(aLeft, aRight)

    clear(gaRev)

  endin



</CsInstruments>
<CsScore>

i "SoundFile" 0 1

;p4 = 1 ---> Schroeder-Moorer; p4 = 2 ---> Schroeder-Chowning; p4 = 3 ---> Dattorro_Plate
i "Reverb_Test" 0 300 2

</CsScore>
</CsoundSynthesizer>
