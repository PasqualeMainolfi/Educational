<CsoundSynthesizer>
<CsOptions>
-o dac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1

/* TRIGGERING INSTRUMENTS EVENTS ---> WITH SPRINTF + SCORELINE_I */

seed(0)

	instr 1

ip2 = 0 // attack time p2 in score
icount = 0 // contatore 
itot_events = 10 // numero totale eventi da generare
StringScore = "" // init stringa per scoreline

//genera:

while (icount < itot_events) do // con ciclo while
	idur = random(.1, 3)
	ipitch = int(random(48, 72))
	Sline = sprintf("i 2 %d %.3f %d\n", ip2, idur, cpsmidinn(ipitch)) // stringa per scoreline
	StringScore = strcat(StringScore, Sline) // appendiamo la stringa generata alla precedente... per itot_events volte
	ip2 += idur // all'attacco sommiamo la durata ---> p2
	icount += 1
od

	//loop_lt(icount, 1, itot_events, genera) // con loop_lt (identico al ciclo while)
	

puts(StringScore, 1)
scoreline_i StringScore // generiamo score

/*
...questo è un esempio di stampa
i 2 0 1.275 330
i 2 1 0.904 233
i 2 2 1.070 139
i 2 3 2.396 392
i 2 6 2.621 165
i 2 8 2.495 440
i 2 11 0.251 247
i 2 11 0.887 294
i 2 12 1.463 156
i 2 13 1.343 415
*/


itot_dur = ip2 + idur
p3 = itot_dur
print(p3)

	endin

	instr 2
a1 = pluck(.3, p4, p4, 0, 1)
	outs(a1, a1)
	endin
	



</CsInstruments>
<CsScore>

i 1 0 1


</CsScore>
</CsoundSynthesizer>
