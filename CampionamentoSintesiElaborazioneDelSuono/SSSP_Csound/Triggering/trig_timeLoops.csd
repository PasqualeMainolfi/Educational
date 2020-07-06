<CsoundSynthesizer>
<CsOptions>
-o dac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1

/* TRIGGERING INSTRUMENTS EVENTS ---> WITH TIME LOOPS */

seed(0)

	instr master // attiva lo strumento partial

time:
idur_loop = random(.5, 1.2)

	timout(0, idur_loop, genera) // generazione asincrona... passa a genera ogni idur_loop secondi
	reinit(time)

/*
...una variante all'utilizzo di timout è metro

ktime init .5
if(metro(1/ktime) == 1) then
	kdur_instr = random:k(.5, 1.5)
	event_i("i", "partial", 0, kdur)
	ktime = random(.5, 1.2)
endif
*/

genera: // attiva lo strumento partial passando le informazioni di durata
idur_instr = random(.5, 1.5)
	event_i("i", "partial", 0, idur_instr)

	endin
	

	instr partial // attiva lo strumento additive

inum_partials = random(5, 10)
ifond_freq = random(120, 440)
icount = 0

genera: // attiva lo strumento additive passando le informazioni di cui sopra
	event_i("i", "additive", 0, p3, ifond_freq	, icount + 1, inum_partials)
	loop_lt(icount, 1, inum_partials, genera)

	endin
	
	
	instr additive // genera il suono

ifrequenza_fondamentale = p4
inum_componente = p5
itot_componenti = p6

ipartials = ifrequenza_fondamentale * inum_componente
imax_amp = 1/itot_componenti // max ampiezza
iamp = imax_amp/inum_componente // ampiezza per componente
iextra_dur_partials = random(0, p3)
p3 = p3 + iextra_dur_partials

a1 = poscil(linseg:k(0, .001, iamp, p3 - .001, 0), ipartials)

	outs(a1, a1)
	
		dispfft(a1, .1, 2048)

	endin


</CsInstruments>
<CsScore>

i 1 0 3

</CsScore>
</CsoundSynthesizer>
