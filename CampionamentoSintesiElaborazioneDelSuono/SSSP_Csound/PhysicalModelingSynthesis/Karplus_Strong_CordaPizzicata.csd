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
CORDA PIZZICATA

ALGORITMO KARPLUS-STRONG
y[n] ---> | M sample delay | ---> y[n - M]
    ^                          |
    |                          |
    <------| + | <-|g| <--------
             ^                |
             |                |
             <---|g|-|z^-1|<---

KARPLUS-STRONG E SOLUZIONE DI D'ALAMBERT
d^2u / dx^2 = [(1 / c^2) * d^2 / dt^2] = 0
u[x, t] = f[k(x +- ct) + phi]

y(+)[n]                    y(+)[n - M]
...---> | M sample delay | ---> ...
    |                      |
    + ---> y(nT, 0)        + ---> y(nT, MX)
    |                      |
...<--- | M sample delay | <---...
y(-)[n]                    y(-)[n + M]

y[n] = y(+)[n - M] + y(-)[n + M]

CONDIZIONI AL CONTORNO, CORDA FISSATA AGLI ESTREMI
y(+)[n] ---> | M sample delay | --->  y(+)[n - M / 2]
        ^                          |
        |                          |
       * -1                       * -1 (IDEAL REFLECTION)
        |                          |
y(-)[n] <--- | M sample delay | <--- y(-)[n + M /  2]

EXTENDED KARPLUS-STRONG ALGORITHM (CCRMA)
--->|Hp(z)|--->|Hb(z)|---> + --->|          z^-M            |--->--->|Hl(z)|--->
                           ^                                    |
                           |                                    |
                           <---|Hn(z)|<---|Hs(z)|<---|Hd(z)|<---

Hp(z) = 1 - p / 1 - pz^-1 ---> pick-direction lowpass filter
Hb(z) = 1 - z^[bN + 1/2] = pick-position comb filter, b € (0, 1)
Hd(z) = string-damping filter
Hs(z) = string-stiffness allpass filter
Hn(z) = -n(M) - z^-1 / 1-n(M)z^-1 = first order string-tuning allpass filter
Hl(z) = 1 - Rl / 1 - Rlz^-1 = dynamic-level lowpass filter

M = pitch period (2L (due volte la lunghezza della corda)) in campioni
b = normalized pick position (0, 1)
p = 0 for one pick direction, 0 < d < 1 for opposite direction
Rl = e^-πlT
T = sampling interval (Hz)
n = [-1/11, 2/3] for tuning-delays in the range [0.2, 1.2] samples
Hd <= 1 required for stability
*/

  opcode G, i, i
iDel xin
iGuadagno = 10^((-3 * iDel) / (p3 - (p3 / 5)))
xout iGuadagno
  endop

  opcode KS, a, ki
kAmp, iFreq xin

iDel = 1 / iFreq
aNoise = linseg(0, iDel * .05, 1, iDel * (1 - 0.05), 0)
aDelay delayr iDel
aX = ((aDelay + delay1(aDelay))) * .5
  delayw((aX * G(iDel)) + aNoise)

xout aX * kAmp
  endop

  opcode DAlam_KS, a, kiii
kAmp, iFreq, iPos, iPick xin

/*
y[n] = y(+)[n - M] + y(-)[n + M]

kAmp = ampiezza
iFreq = frequenza fondamentale
iPos = punto di pizzico
iPick = posizione pick up (norm 0 - 1)
*/

iDel = 1 / iFreq

aX_sx = linseg:a(0, iPos * iDel, 1, (1 - iPos) * iDel, 0)
aX_dx = linseg:a(0, iDel * (1 - iPos), -1, iDel * iPos, 0)

aIn_1 init 0
aIn_2 init 0

aDel_sx delayr iDel
aTap_sx = deltapi(iDel * (1 - iPick))
  delayw((aIn_1 * G(iDel)) + aX_sx)

aDel_dx delayr iDel
aTap_dx = deltapi(iDel * iPick)
  delayw((aIn_2 * G(iDel)) + aX_dx)

aIn_1 = (-aDel_dx + delay1(-aDel_dx)) / 2
aIn_2 = -aIn_1


xout ((aTap_sx + aTap_dx) / 2) * kAmp
  endop


  opcode AP, a, ai
aIn, iCoeff xin
aAp init 0
aAp = iCoeff * ((aIn - aAp) + delay1(aIn))
xout aAp
  endop

  opcode ExKS, a, kiii
kAmp, iFreq, iPos, iPick xin

/*
Per risolvere il problema dell'intonazione a frequenze relativamente alte:

aggiunta di un filtro passa-tutto
Hap(z) = a + z^-1 / 1 + az^-1
a = 1 - d / 1 + d
d = parte frazionale dell'intera linea di ritardo in campioni

Ntot = floor((sr/f0) - 0.5) ---> parte intera della linea di ritardo totale in campioni
d = sr/f0 - (Ntot + 0.5) ---> delta (frac)
*/

iDel = 1 / iFreq
iDelayIntPart = floor((sr / iFreq) - .5)
iDelta = (sr / iFreq) - (iDelayIntPart + .5)
iApCoeff = (1 - iDelta) / (1 + iDelta)

aX = linseg:a(0, (iDel / 2) * iPos, -1, iDel * (1 - iPos), 1, (iDel/2) * iPos, 0)

aDelay delayr iDelayIntPart * (1 / sr)
aTap_1 = deltapi(iDel * (1 - iPick))
aTap_2 = deltapi(iDel * iPick)
aFeedBack = AP((aDelay + delay1(aDelay)) / 2, iApCoeff)
  delayw(aX + (aFeedBack * G(iDel)))

aOut = ((aTap_1 + aTap_2) / 2) * kAmp
xout aOut
  endop



  instr KS_Test

iFreq = 120
iAmp = .9
iPickPosition = .05
iPluckPosition = 1/3

aY[] init 3
aY[0] = KS(iAmp, iFreq)
aY[1] = DAlam_KS(iAmp, iFreq, iPluckPosition, iPickPosition)
aY[2] = ExKS(iAmp, iFreq, iPluckPosition, iPickPosition)

aOut = aY[p4]

  outs(aOut, aOut)


  endin


</CsInstruments>
<CsScore>
i "KS_Test" 0 5  0
i "KS_Test" 6 5  1
i "KS_Test" 12 5 2
</CsScore>
</CsoundSynthesizer>
