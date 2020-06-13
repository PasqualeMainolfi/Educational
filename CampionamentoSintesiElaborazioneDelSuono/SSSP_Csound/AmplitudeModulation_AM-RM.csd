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
AMPLITUDE MODULATION

  s(t) = Ap sin(wpt) + [(Ap m sin(wmt)) sin(wpt)]

  = Ap sin(wpt) + [(Apm/2) sin(wp + wm)t] + [(Apm/2) sin(wp - wm)t]

m = k Am / Ap
fp + fm < [sr/2]
*/

  opcode AmplitudeModulation, a, kkkko
kCarFreq, kModFreq, kCarAmp, kModAmp, iMode xin

/*
kCarFreq = frequenza della portante
kModFreq = frequenza della modulante
kCarAmp = ampiezza della portante
kModAmp = ampiezza della modulante, indice di modulazione 0 < x < 1
iMode = opzionale. Default 0 = AM, se = 1 allora RM
*/

i2_Pi = 2 * $M_PI

aWp = i2_Pi * (phasor:k(kCarFreq))
aWm = i2_Pi * (phasor:k(kModFreq))

kM = kModAmp

if(iMode = 0) then
  aSigMod = (1/2) * (kCarAmp * sin(aWp) + ((1/2) * ((kCarAmp * (kM * sin(aWm))) * sin(aWp))))
  else
    aSigMod = (1/2) * ((kCarAmp * (kM * sin(aWm))) * sin(aWp))
  endif

xout aSigMod
  endop


  instr AM

kFreqPortante = 200 ;* randomh:k(.5, 10, 15)
kFreqModulante = 700
kAmpPortante = .91
kIndex = .9

aMod = AmplitudeModulation(kFreqPortante, kFreqModulante, expseg:k(.001, .01, 1, p3 - .01, .0001) * kAmpPortante, expseg:k(.001, .01, 1, p3 - .01, .0001) * kIndex, p4)

  outs(aMod, aMod)

  endin




</CsInstruments>
<CsScore>
i "AM" 0 5 0 ;AM
i "AM" 5 5 1 ;RM
</CsScore>
</CsoundSynthesizer>
