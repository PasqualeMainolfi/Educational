<CsoundSynthesizer>
<CsOptions>
-o dac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1


/* TRIGGERING INSTRUMENTS EVENTS ---> WITH SCORELINE_I */


	instr master
	
scoreline_i {{

	i 2 0   1
	i 2 1.5 3
	i 2 5   1.5

}}
	
	endin

	
	instr 2
a1 = pluck(.3, 220, 220, 0, 1)
	outs(a1, a1)
	endin


</CsInstruments>
<CsScore>

i "master" 0 7


</CsScore>
</CsoundSynthesizer>
