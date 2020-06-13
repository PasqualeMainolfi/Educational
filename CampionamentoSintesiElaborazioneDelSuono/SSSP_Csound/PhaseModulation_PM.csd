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
PHASE MODULATION

s(t) = Ap sin(wpt + k * Am sin(wmt))

k * Am = DeltaFI (massima deviazione di fase del segnale in radianti)
DeltaFI * wm/2π = DeltaF (massima deviazione in frequenza)
*/

  opcode PM, a, kkkkkkk
kPortante, kAmpPortante, kPhasePortante, kModulante, kAmpModulante, kPhase, kCostCar xin

/*
kPortante = frequenza portante
kAmpPortante = ampiezza della portante
kPhasePortante = costante di fase della portante
kModulante = frequenza della modulante
kAmpModulante = ampiezza della modulante
kPhase = costante di fase
kCostCar = costante caratteristica del modulatore
*/

i2_Pi = 2 * $M_PI

kFIp = i2_Pi * (phasor:k(kPortante) + kPhasePortante)
kFIm = i2_Pi * phasor:k(kModulante)
kIndx = (kCostCar * kAmpModulante) / i2_Pi

aPM = kAmpPortante * sin(kFIp + (kIndx * sin(kFIm)) + kPhase)

xout aPM
  endop



  instr PhaseModulation

kPortante = 220
kAmpPor = .9
kPhasePor = 0
kModulante = 120
kAmpMod = 12
kPhase = 0
kCostCar = 2

aPM = PM(kPortante, expseg:k(.001, .01, 1, p3 - .01, .001) * kAmpPor, kPhasePor,  kModulante, expseg:k(.001, .01, 1, p3 - .01, .001) * kAmpMod, kPhase, kCostCar)


  outs(aPM, aPM)

  	dispfft(aPM, .1, 2048)

  endin


  instr PhaseModulation_ZeroPortante

kPortante = 0
kAmpPor = .9
kPhasePor = p4
kModulante = 120
kAmpMod = 36
kPhase = p5
kCostCar = 2

aZero_PM = PM(kPortante, expseg:k(.001, .01, 1, p3 - .01, .001) * kAmpPor, kPhasePor,  kModulante, expseg:k(.001, .01, 1, p3 - .01, .001) * kAmpMod, kPhase, kCostCar)

      outs(aZero_PM, aZero_PM)

  endin




</CsInstruments>
<CsScore>
#define PI #3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679#

i "PhaseModulation" 0 60
i "PhaseModulation_ZeroPortante" 5  5 0         0 ;armoniche pari nulle
i "PhaseModulation_ZeroPortante" 10 5 [$PI / 2] 0 ;tutte le armoniche
i "PhaseModulation_ZeroPortante" 15 5 0         [$PI / 2] ;armoniche dispari nulle
i "PhaseModulation_ZeroPortante" 20 5 0         $PI ;armoniche pari nulle
i "PhaseModulation_ZeroPortante" 25 5 0         [3 * $PI / 2] ;armoniche dispari nulle
</CsScore>
</CsoundSynthesizer>
