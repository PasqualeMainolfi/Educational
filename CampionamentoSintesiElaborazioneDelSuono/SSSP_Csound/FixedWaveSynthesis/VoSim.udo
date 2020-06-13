/*

VoSim Oscillator (by Werner Kaegi and Stan Tempelaars)

T DT M DM D A DA b N S NM NP

f(t) = ut - b^N-1 * u(t - NT) + (b - 1) * (∑b^n-1 * u(t - nT))

u(t) = 1, x > 0; 0, x < 0

p(t) = 1/2(1 - cos(wt))
w = 2π/T

f_0 = 1 / (NT + M)

Vosim = f(t) * p(t)

*/

  opcode VoSim, a, ikkiii
iT, kF, kA, iM, ib, iN xin

/*
iT = pulsewidth in secondi
kF = deve essere 1/iT
kA = ampiezza
iM = delay tra un treno di impulsi e il successivo in secondi
ib = percentuale di attenuazione impulsi in percentuale
iN = numero di impulsi
*/

i2Pi = 2 * $M_PI
it = 1 / sr

iSecToSample = iT * sr
iM_SampleDelay = floor(iM * sr)
iFloor = floor(iSecToSample)
iSampleTab = ((iFloor * iN) + iM_SampleDelay) ;numero totale di campioni compresa pausa
iSample = iFloor ;pulsewidth -> numero di campioni per un solo impulso

kFt[] init iN
kFunctionT[] init iSampleTab
kU = 1

loop:
aP init 0
kPer init 0

ki init 0
until (ki == iN) do
  kj = 0
  until (kj == iSample) do
    kx = 0
    until (kx == iM_SampleDelay) do
      k1 = kU - ib^(iN - 1) * (kU - (iN * iT)) + (ib - 1)
      k2 = (ib^(ki - 1) * (kU - (ki * iT)))
      kFt[ki] = k1 * k2
      kFunctionT[kj + kPer] = kFt[ki]
      kFunctionT[kx + (iSample * iN)] = 0
      kx += 1
    od
    kj += 1
  od
  ki += 1
	kPer += iSample
od

kn init 0
if(kn < iSampleTab) then
  aW = (i2Pi * aP * kF)
  aY = (1/2) * (1 - cos(aW))
  aY = aY * kFunctionT[kn]
  aP += a(it)
  kn += 1

  if(kn >= iSampleTab) then
    kn = 0
    kPer = 0
    ki = 0
    reinit loop
  endif
endif
rireturn

xout(aY * kA)
  endop


/*

VoSim Oscillator (pseudo) -> PseudoVoSim

Implementazione di un oscillatore Vosim con funzione di inviluppo esponenziale decrescente

T M N

T = pulsewidth
M = delay
N = number of pulses

y = y * e^-t

*/

  opcode PseudoVoSim, a, ikkii
iT, kF, kAmp, iM, iN xin

/*
iT = larghezza dell'impulso in secondi
kF = deve essere uguale a 1/iT
kAmp = ampiezza
iM = delay tra un treno di impulsi ed il successivo
iN = numero di impulsi
*/

iPi = $M_PI
iE = $M_E
iStep = 1 / sr

iFromSecToSample = floor(iT * sr)
iDurExpDec = 1 / (iFromSecToSample * 4)

time:
timout(0, (iT * iN) + iM, repeat)
reinit time

repeat:
aPhasePulse init 0
kTime init 0

ki init 0
if(ki < (iFromSecToSample * iN)) then
  aW = (iPi * aPhasePulse * kF)
  aY = kAmp * sin(aW)
  aY = aY^2
  aPhasePulse += a(iStep)
  ki += 1
endif

aJ = aY * iE^-kTime
kTime += iDurExpDec
rireturn

xout(aJ)
  endop
