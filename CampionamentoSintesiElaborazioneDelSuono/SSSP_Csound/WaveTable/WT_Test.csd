<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1

#include "WT.udo"

	instr Static_WT

iN = 4096
kA[] = fillarray(1, 1/2, 1/3, 1/4, 1/5) ;array ampiezza componenti
kF = 220

aWaveTable = WT_Static(iN, kF, kA) * expseg(.001, .01, 1, p3 - .01, .001)

	outs(aWaveTable, aWaveTable)

		display(aWaveTable, 1/110)
		dispfft(aWaveTable, .1, 2048)

	endin

	instr Dynamic_WT

iN = 4096
kA1[] = fillarray(1, 1/2, 1/3, 1/4, 1/5, 1, 1, 1, 1)
kA2[] = fillarray(1, .3, 1/2, .2, 1/3, .1, 1/4, .05, 1/5)
kCross = linseg(0, p3/2, 1) ;da una forma d'onda all'altra
kF = 120

aWaveTable = WT_Dynamic(iN, kF, kA1, kA2, kCross) * expseg(.001, .01, 1, p3 - .01, .001)

	outs(aWaveTable, aWaveTable)

		; display(aWaveTable, .01)
		; dispfft(aWaveTable, .1, 1024)

	endin


</CsInstruments>
<CsScore>

;i "Static_WT" 0 4
i "Dynamic_WT" 0 3

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
