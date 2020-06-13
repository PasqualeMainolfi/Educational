<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1


  instr Butterworth_BandPass

/*
Example: Butterworth 2 ord. Band Pass filter designed with Scilab.

sr = 44100
f1_cut = 1500 Hz
f2_cut = 2500 Hz
BW = 1000 Hz

  y[n] = b0 + b1z^-2 + b2z^-4 - a1z^-1 - a2z^-2 - a3z^-3 - a4z^-4

Coefficients:

b0 = 0.004604
b1 = -0.009208
b2 = 0.004604

a1 = -3.6551695
a2 = 5.146869
a3 = -3.3040212
a4 = 0.8175124
*/

aX = rand(.5)

aX_2 = delay(aX, 2/sr)
aX_4 = delay(aX, 4/sr)

aY_1, aY_2, aY_3, aY_4 init 0

ib0 = 0.004604
ib1 = -0.009208
ib2 = 0.004604

ia1 = -3.6551695
ia2 = 5.146869
ia3 = -3.3040212
ia4 = 0.8175124

  aY_n = ib0 * aX + ib1 * aX_2 + ib2 * aX_4 - ia1 * aY_1 - ia2 * aY_2 - ia3 * aY_3 - ia4 * aY_4

aY_4 = aY_3
aY_3 = aY_2
aY_2 = aY_1
aY_1 = aY_n


  dispfft(aY_n, .1, 2048)

outs(aY_n, aY_n)

  endin




  instr Butterworth_BandStop

/*
Example: Butterworth 2 ord. Band Stop filter designed with Scilab.

sr = 44100
f1_cut = 1500 Hz
f2_cut = 2100 Hz
BW = 600 Hz

  y[n] = b0 + b1z^-1 + b2z^-2 + b3z^-3 + b4z^-4 - a1z^-1 - a2z^-2 - a3z^-3 - a4z^-4

Coefficients:

b0 = 0.9413418
b1 = -3.6455499
b2 = 5.412229
b3 = -3.6455499
b4 = 0.9413418

a1 = -3.7557991
a2 = 5.4087852 - i*3.331*10^-16
a3 = -3.5353008 + i*3.331*10^-16
a4 = 0.8861273 - i*8.327*10^-17
*/

aX = rand(.5)

aX_1 = delay(aX, 1/sr)
aX_2 = delay(aX, 2/sr)
aX_3 = delay(aX, 3/sr)
aX_4 = delay(aX, 4/sr)

aY_1, aY_2, aY_3, aY_4 init 0

ib0 = 0.9413418
ib1 = -3.6455499
ib2 = 5.412229
ib3 = -3.6455499
ib4 = 0.9413418

ia1 = -3.7557991
ia2 = 5.4087852
ia3 = -3.5353008
ia4 = 0.8861273

  aY_n = ib0 * aX + ib1 * aX_1 + ib2 * aX_2 + ib3 * aX_3 + ib4 * aX_4 - ia1 * aY_1 - ia2 * aY_2 - ia3 * aY_3 - ia4 * aY_4

aY_4 = aY_3
aY_3 = aY_2
aY_2 = aY_1
aY_1 = aY_n


  dispfft(aY_n, .1, 2048)

outs(aY_n, aY_n)


  endin



</CsInstruments>
<CsScore>
i "Butterworth_BandPass" 0 3
i "Butterworth_BandStop" 4 3
</CsScore>
</CsoundSynthesizer>
