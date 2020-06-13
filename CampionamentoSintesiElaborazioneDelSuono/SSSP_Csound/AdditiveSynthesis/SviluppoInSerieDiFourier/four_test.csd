<CsoundSynthesizer>
<CsOptions>
-o dac
</CsOptions>
<CsInstruments>

/*
patch a titolo di esempio per la esplicazione dell'intero processo di sintesi additiva
mediante lo sviluppo in serie di Fourier.
Nello specifico:
  -calcolo dei coefficienti a0, ak, bk, a partire da una funzione (udo ---> func2coeff)
  -sviluppo in serie a partire dai coefficienti calcolati (udo ---> coeff2sig)
*/


sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1

#include "fourier.udo"


gisampleRate = 2^9 //gestire in modo saggio il numero di punti! tanti punti tanto calcolo
ginumFormanti = 15 //numero totale di formanti (conta anche la zero)

gka0 init 0
gkak[] init ginumFormanti
gkbk[] init ginumFormanti


  instr 1 //calcolo dei coefficienti di Fourier

iN = gisampleRate

kfunc1[] init gisampleRate //square wave
kfunc2[] init gisampleRate //triangle wave
kfunc3[] init gisampleRate //saw

ki init 0
while (ki < gisampleRate) do
  kfunc2[ki] = 1 - (((2/iN) * ((iN/2) - abs(ki - ((iN - 1)/2)))) * 2) //triangle
  kfunc3[ki] = (1 - (2 * (ki/(iN - 1)))) //saw
  if(ki < gisampleRate/2) then
    kfunc1[ki] = 1 //square
    else
      kfunc1[ki] = -1
    endif
    ki += 1
  od

if(p4 == 0) then
  kfunc[] = kfunc1
elseif(p4 == 1) then
  kfunc[] = kfunc2
elseif(p4 == 2) then
  kfunc[] = kfunc3
endif

gka0, gkak[], gkbk[] func2coeff kfunc, ginumFormanti //da funzione a coefficienti
ay = coeff2sig(gka0, gkak, gkbk, 120) //da coefficienti a segnale
ay *= expseg(.0001, .01, 1, p3 - .01, .0001)

  outs(ay, ay)

  endin

</CsInstruments>
<CsScore>

i 1 0 5 0
i 1 3 3 1
i 1 4.5 7 2


</CsScore>
</CsoundSynthesizer>
