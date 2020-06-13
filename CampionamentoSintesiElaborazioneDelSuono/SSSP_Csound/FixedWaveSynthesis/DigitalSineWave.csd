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

SINTESI A FORMA D'ONDA FISSA
CON FUNZIONE D'INVILUPPO ESPONENZIALE DECRESCENTE

y[n] = Ae^(-t) sin(wt)

*/


  opcode ExpDec, k, k ;funzione d'inviluppo esponenziale decrescente
setksmps(1)
kStep xin

kt init 0
iE = $M_E
kExpDec = iE^-kt
kt += (kStep / kr)

xout(kExpDec)
  endop


  opcode SineWave, a, kk ;digital sine wave
kFreq, kAmp xin

iT = 1/sr
i2_Pi = 2 * $M_PI
aStep init 0
aY = kAmp * sin(i2_Pi * aStep * kFreq)
aStep += a(iT)
xout(aY)
  endop


  instr Wave
kFreq = 220
kAmp = .9

aSine = SineWave(kFreq, kAmp * ExpDec(1))

outs(aSine, aSine)
  endin



</CsInstruments>
<CsScore>

i "Wave" 0 10

</CsScore>
</CsoundSynthesizer>
