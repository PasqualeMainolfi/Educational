<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1


  opcode AP_FDN, a, aii

/*
Il modello classico di ALLPASS può essere emulato con il
rispettivo FDN:

y[n] = G(y[n - N] * M)
y(out) = y[n] * (1 - G)

G = g * 1/√2
M = matrice di trasferimento

*/


aX, iT60, iDelSample xin

iDel = iDelSample / sr
iG = (10^(-3 * iDel / iT60))

iRow = 2
iCol = 1

kMatrix[][] init iRow, iCol
kMatrix[][] = fillarray(1,
                       -1)

aAP init 0

ki = 0
until (ki == iRow) do
  kj = 0
  aY = aX
  until (kj == iCol) do
    aY = aY + (aAP * kMatrix[ki][kj] * iG)
    kj += 1
  od
  ki += 1
od

aAP = delay(aY, iDel)

xout aY * (1 - iG)
  endop


/*
FDN EXAMPLE WITH HADAMARD MATRIX

a[n] = x[n] + d[n]
d[n] = g(c[n] * M)
c[n] = b[n] + a1c[n - 1]
b[n] = a[n - N]

y[n] = x[n] + (c[n] * S)


M = FDN Matrix
S = Spread out Matrix
g = guadagno feedback
*/

  opcode FDN, aa, aki
aIn, kFreqFilt, iG xin

iIn = 4
iOut = 2

iRowM = 4
iColM = 4

iG = iG * ($M_SQRT1_2)

kMM[][] init iRowM, iColM ;Stautner-Puckette matrix (lossless se g = 1)
kSpread[][] init iOut, iIn
kG[][] init iRowM, iColM
aA[] init iIn
aB[] init iIn
aC[] init iIn
aY[] init iOut

iDel[] = fillarray(0.023, 0.031, 0.041, 0.047)

kSpread[][] = fillarray(.75, .5, .5, .25,
                        .25, .5, .5, .75)

kMM[][] = fillarray(0, 1,  1,  0,
                   -1, 0,  0, -1,
                    1, 0,  0, -1,
                    0, 1, -1,  0)

ki = 0
until (ki == iRowM) do
  kj = 0
  aA[ki] = aIn
  until (kj = iColM) do
    aA[ki] = aA[ki] + (aC[kj] * (kMM[ki][kj] * iG))
    kj += 1
  od
  ki += 1
od

aB[0] = delay(aA[0], iDel[0])
aB[1] = delay(aA[1], iDel[1])
aB[2] = delay(aA[2], iDel[2])
aB[3] = delay(aA[3], iDel[3])

aC[0] = tone(aB[0], kFreqFilt)
aC[1] = tone(aB[1], kFreqFilt)
aC[2] = tone(aB[2], kFreqFilt)
aC[3] = tone(aB[3], kFreqFilt)

ki = 0
until (ki == iOut) do
  aY[ki] = 0
  kj = 0
  until (kj == iIn) do
    aY[ki] = aY[ki] + (aC[kj] * kSpread[ki][kj])
    kj += 1
  od
  ki += 1
od

aL = aY[0]
aR = aY[1]

xout aL, aR
  endop


  instr AP_FDN

aIn = rand(1)
iDelSample = 32
iT60 = 5 ;calcoliamo G dal tempo di decadimento totale

aAP = AP_FDN(aIn, iT60, iDelSample)

  outs(aAP, aAP)

    dispfft(aAP, .1, 2048)

  endin



  instr FDN

aIn = linseg:k(0, .01, 1, .03, 0) * tone(rand(1), 500)
kFreqFilt = 5000
iG = .95 ;lossless con g = 1

aL, aR FDN aIn, kFreqFilt, iG

  outs(aL, aR)

  endin

</CsInstruments>
<CsScore>

i "AP_FDN" 0 5

i "FDN" 6 10

</CsScore>
</CsoundSynthesizer>
