<CsoundSynthesizer>
<CsOptions>
-i adc -o dac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1

#include "grain_function.udo"

  instr costruttore

giaudio_sample = open_file("testGrain_3.wav")
gilive = live_input(44100, 1)
gifunc = giaudio_sample
iN = ftlen(gifunc)

gitype = 0 // 0 ---> sound granulation e live input 1 ---> suoni sintetici

giw, gioverlapp = 4096/sr, 1024/sr

ihop init 0
if_min, if_max = 1, 1
ia_min, ia_max = .3, .707
ip_min, ip_max = 0, 0
it_min, it_max = .01, .3
ir_min, ir_max = .1, .3
ispace_min, ispace_max = .5, .5
imode = 0 // 0 ---> mantieni la stessa durata 1 ---> down/upsampling

aggiorna:
// frequenza, ampiezza e fase
ifreq = random(if_min, if_max)
iamp = random(ia_min, ia_max)
iphase = random(ip_min, ip_max)

// durata del grano
idur_grano = random(it_min, it_max)
idur_to_sample = ceil(sr * idur_grano)
idur_to_time = idur_to_sample/sr

// distanza temporale tra un grano e l'altro
ir_grano = random(ir_min, ir_max)
ir_to_sample = ceil(sr * ir_grano)
ir_to_time = ir_to_sample/sr

// gestione dello spazio
ispace = random(ispace_min, ispace_max)

if(imode == 0) then
  ii, ij, ik = ifreq, 1, 1
elseif(imode == 1) then
  ii, ij, ik = 1, ifreq, 1/ifreq
endif

idurata_totale = iN/sr // in secondi
idur_tot_to_time = idurata_totale * ik
idur_tot_to_sample = ceil(sr * idur_tot_to_time)
idur_tot_to_time = idur_tot_to_sample/sr // aggiustata

ifase_w = map(iphase, 0, idur_to_sample, 0, 1)
ifase_tab = map(iphase, 0, idur_tot_to_sample, 0, 1)


  timout 0, ir_to_time, to_grain
  reinit aggiorna

to_grain:
schedule("granula", 0, idur_to_time, ifreq, iamp, ispace, ifase_w, ifase_tab, idur_to_sample, ii, ij, ihop)
//											p3						p4			p5		p6				p7			p8						p9				p10	p11	 p12
ihop += ir_to_sample
ihop = ihop%idur_tot_to_sample
rireturn

  endin


  instr granula
i2pi = 2 * $M_PI

ki init 0
if(ki < p9) then
  kndx = abs(p7 - ki) * p10
  koverlapp = abs(p8 - p12) * p11
  ainv1 = interp(w_coseno(ki, p9))
  if(gitype == 0) then
    agrano = p5 * ainv1 * tablei:a(kndx + koverlapp, gifunc)
  elseif(gitype == 1) then
    agrano = p5 * ainv1 * sin(i2pi * p4/sr * ki)
  endif
  ki += 1
endif

aleft = agrano * sqrt(p6)
aright = agrano * (sqrt(1 - p6))
outs(aleft, aright)

  endin



</CsInstruments>
<CsScore>
i "costruttore" 0 10
</CsScore>
</CsoundSynthesizer>
