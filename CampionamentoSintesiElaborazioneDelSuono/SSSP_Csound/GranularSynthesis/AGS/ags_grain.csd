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


gidel init 0
seed(0)

  instr costruttore
giaudio_sample = open_file("testGrain_3.wav")
gilive = live_input(44100, 1)
gifunc = giaudio_sample
iN = ftlen(gifunc)

gitype = 0 // 0 ---> sound granulation e live input 1 ---> suoni sintetici

giw, gioverlapp = 4096, 1024

if_min, if_max = .3, 3
ia_min, ia_max = .03, .707
ip_min, ip_max = 0, 0
it_min, it_max = .001, .3
ir_min, ir_max = .01, .3
ispace_min, ispace_max = .5, .5
imode = 0 // 0 ---> mantieni la stessa durata 1 ---> down/upsampling

aggiorna:
// frequenza, ampiezza e fase
gifreq = random(if_min, if_max)
giamp = random(ia_min, ia_max)
giphase = random(ip_min, ip_max)

// durata del grano
gidur_grano = random(it_min, it_max)
gidur_to_sample = ceil(sr * gidur_grano)
gidur_to_time = gidur_to_sample/sr

// distanza temporale tra un grano e l'altro
gir_grano = random(ir_min, ir_max)
gir_to_sample = ceil(sr * gir_grano)
gir_to_time = gir_to_sample/sr

// gestione dello spazio
gispace = random(ispace_min, ispace_max)

if(imode == 0) then
  gii, gij, gik = gifreq, 1, 1
elseif(imode == 1) then
  gii, gij, gik = 1, gifreq, 1/gifreq
endif

idurata_totale = iN/sr // in secondi
gidur_tot_to_time = idurata_totale * gik
gidur_tot_to_sample = ceil(sr * gidur_tot_to_time)
gidur_tot_to_time = gidur_tot_to_sample/sr // aggiustata

gifase_w = map(giphase, 0, gidur_to_sample, 0, 1)
gifase_tab = map(giphase, 0, gidur_tot_to_sample, 0, 1)


  timout 0, gir_to_time, to_grain
  reinit aggiorna

to_grain:
schedule("granula", 0, gidur_to_time)

  endin


  instr granula
i2pi = 2 * $M_PI

ki init 0
if(ki < gidur_to_sample) then
  kndx = abs(gifase_w - ki) * gii
  koverlapp = abs(gifase_tab - gidel) * gij
  ainv1 = w_hann(ki, gidur_to_sample)
  ainv2 = w_coseno(ki, gidur_to_sample)
  if(gitype == 0) then
    agrano = giamp * ainv1 * tablei:a(kndx + koverlapp, gifunc)
  elseif(gitype == 1) then
    agrano = giamp * sin(i2pi * gifreq/sr * ki)
    agrano *= ainv2
  endif
  ki += 1
endif

gidel += gir_to_sample
gidel = gidel%(gidur_tot_to_sample)

aleft = agrano * sqrt(gispace)
aright = agrano * (1 - sqrt(gispace))
outs(aleft, aright)

  endin


</CsInstruments>
<CsScore>
i "costruttore" 0 10
</CsScore>
</CsoundSynthesizer>
