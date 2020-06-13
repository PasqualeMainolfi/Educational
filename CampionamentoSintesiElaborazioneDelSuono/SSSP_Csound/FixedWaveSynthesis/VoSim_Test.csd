<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1

#include "VoSim.udo"

  instr VoSim

iT = 0.00096
kF = (1 / iT)
kAmp = 1
iM = 0.00141
ib = 85/100
iN = 7


if(p4 = 0) then
  aVosim = VoSim(iT, kF, kAmp, iM, ib, iN)
  elseif(p4 = 1) then
    aVosim = PseudoVoSim(iT, kF, kAmp, iM, iN)
  endif

aOut = aVosim

outs(aOut, aOut)

  dispfft(aOut, .1, 2048)


  endin




</CsInstruments>
<CsScore>

i "VoSim" 0 5 0
i "VoSim" 7 5 1

</CsScore>
</CsoundSynthesizer>
