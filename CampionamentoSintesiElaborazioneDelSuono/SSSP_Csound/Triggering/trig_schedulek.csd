<CsoundSynthesizer>
<CsOptions>
-o dac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1

/* TRIGGERING INSTRUMENTS EVENTS ---> WITH SCHEDULEK */

seed(0)

	instr master

isoglia = 0.5
kperc = random:k(0, 1)
iper = 0.1

if(kperc < iper && metro(10) == 1) then
	kfreq = random:k(220, 900)
	kdev = random:k(0, 15)
	krnd = random:k(0, 1)
	kfreq_dev = (krnd < isoglia ? kfreq + (kfreq * kdev/100):kfreq - (kfreq * kdev/100))
	kdur = kperc + 1
	schedulek("sotto", 0, kdur, kfreq, kfreq_dev)
endif


	endin


	instr sotto

a1 = poscil(linseg:k(0, .001, .3, p3 - .001, 0), p4)
a2 = poscil(linseg:k(0, .001, .3, p3 - .001, 0), p5)

aout = (a1 + a2)/2

	outs(aout, aout)

	endin


</CsInstruments>
<CsScore>

i 1 0 30

</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>0</x>
 <y>0</y>
 <width>0</width>
 <height>0</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
