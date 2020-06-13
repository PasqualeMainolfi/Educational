<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1


instr Massa_Molla

/*
t[n + 2] = t[n + 1] + (t[n + 1] - t[n])
Senza considerare alcuno smorzatore, la massa continuerà a muoversi a velocità costante.
*/

k_T0 init 0
k_T1 init .5

kIter init 0
iMaxIter = 10

if((metro(2) == 1) && (kIter < iMaxIter)) then
k_T2 = k_T1 + (k_T1 - k_T0)

printf("\tt%d = %f \tt%d = %f \tt%d = %f\n", kIter+1, kIter, k_T0, kIter + 1, k_T1, kIter + 2, k_T2)

k_T0 = k_T1
k_T1 = k_T2
kIter += 1
endif

endin


instr Massa_Molla_Smorzatore

/*
Una molla reagisce con una forza pari a:
-k * (l - l0) ---> F = -kx

ricaviamo quindi:

t[n + 2] = [t[n + 1] + (t[n + 1] - t[n]) - (c * t[n + 1])]
*/

iC = .0003
aT0 init 0
aT1 init .01

aT2 = (aT1 + (aT1 - aT0)) - (iC * aT1)
aT0 = aT1
aT1 = aT2

printk2(downsamp(aT2))

outs(aT2, aT2)

endin

instr Damping

/*
VELOCITA':
v = s / t ---> x / T
v[t] = (x[t] - x[t - 1]) / T

ACCELERAZIONE:
a = v / t ---> v / T
a[t] = (v[t] - v[t - 1]) / T

Ponendo T = 1, abbiamo:
v[t] = x[t] - x[t - 1]
a[t] = v[t] - v[t - 1]

e... dato che lo smorzamento è proporzionale alla velocità, riduciamo quest'ultima di un
valore d, in modo che risulti:
v = v * (1 - d)

Dunque:

a = -c * x
v = v + a
v = v * (1 - d)
x = x + v

con c che può essere calcolato a partire dalla frequenza:
c = 2 - sqrt((4 - d^2) * cos(2πf / sr))
*/

setksmps(1)

aX init 0
aV init .01
kD = .00002 ;damping factor
kFreq = 270
kC = 2 - sqrt((4 - kD^2) * cos((2 * $M_PI * kFreq) / sr))

aA = -kC * aX
aV = aV + aA
aV = aV * (1 - kD)

aX = aX + aV

outs(aX, aX)

  display(aX, .01)


endin

instr Excitation

/*
MOTO ECCITATO (A t0 ---> v = 0)
a = -c * v
v = v + a
v = v + ec
v = v * (1 - d)

x = x + v
*/

aX init 0
aV init 0
aEc = rand(.0001)
kD = .0001
kFreq = 550
kC = 2 - sqrt((4 - kD^2) * cos((2 * $M_PI * kFreq) / sr))

aA = -kC * aX
aV = aV + aA + aEc
aV = aV * (1 - kD)

aX = aX + aV

outs(aX, aX)

  display(aX, .01)

endin

  instr VanDerPol ;esempio di Martin Neukom, adattato da Joachim Heintz

/*
OSCILLATORE NON LINEARE
d^2 x / dt^2 = -w^2x + mu(1 - x^2) d^2 x / dt^2
0 < mu < 0.7
w^2 ---> 2 - 2 * cos(2πf / sr)
*/

aV init 0
aX init 0
aIn = rand(.001) ;poscil(.001, 220)
kFreq = 220
kC = 2 - 2 * cos(2 * $M_PI * kFreq / sr)
kMu = .7
aA = -kC * aX + kMu * (1 - aX * aX) * aV
aV = aV + aA
aX = aX + aV + aIn

kAmp = linseg(0, p3/2, .12, p372, 0)

  outs(aX * kAmp, aX * kAmp)

    display(aX, .01)

  endin

</CsInstruments>
<CsScore>
i "Massa_Molla" 0 10
i "Massa_Molla_Smorzatore" 12 10
i "Damping" 23 5
i "Excitation" 29 5
i "VanDerPol" 36 6
</CsScore>
</CsoundSynthesizer>
