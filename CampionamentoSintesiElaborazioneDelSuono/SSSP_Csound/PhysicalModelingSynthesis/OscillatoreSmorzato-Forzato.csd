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
MOTO ARMONICO SMORZATO

y = Ae^(-t/r) sin(sqrt(1 - z^2) wn + phi)

r = 2m / b
wn = sqrt(k/m)
b = z2mwn ;costante di smorzamento
E = 1/2 kA^2 e^(-2t/r)
z = b / (2m)wn = b / 2 sqrt(km) ;coefficiente di smorzamento
2 sqrt(km) = smorzamento critico
k = F / x1 - x0

MOTO ARMONICO FORZATO-SMORZATO

y = Ae^(-t/r) sin(sqrt(1 - z^2) wn + phi) + B sin(wf + phi_f)

B = a0 / sqrt(w0^2 - wf^2) + wf^2 * ws^2
a0 = F / sqrt(m^2 * (w0^2 - wf^2)^2 + (bw)^2) = F/m * 1 / sqrt((w0^2 - wf^2)^2 + 4z^2 w^2)
a0 = -A(w0^2 - wf^2)
phi_f = -wz / (w0^2 - wf^2)
phi:f = taninv(ws wf / w0^2 - wf^2)

ricapitolando:

forzante = [-A(w0^2 - wf^2) / sqrt(w0^2 - wf^2) + wf^2 * ws^2] cos(wf - taninv[ws wf / w0^2 - wf^2])

wf << w0 ---> risonanza distruttiva, decrescente con rapporto
wf = w0 ---> risonanza smorzata
wf >> w0 ---> risonanza in fase, costruttiva, crescente con rapporto

MOTO FORZATO

y = A sin(w0t + phi) + [a / (w0^2 - wf^2)] cos(wft)
[a / (w0^2 - wf^2)] = ampiezza della forzante

nel caso in cui w0 = wf:
y(t) = A cos(wt + phi) + (a / 2w0)t sin(wt)
*/

  opcode OscSmorzato, akk, kkki
setksmps(1)
kT init 0
kT += (1 / kr)
kMassa, kForza, kAllungamento, iBeta xin

/*
kMassa = massa in kg
kForza = forza applicata in Newton
kAllungamento = allungamento registrato in metri
iBeta = costante di smorzamento
*/

i2_Pi = 2 * $M_PI
iE = $M_E

kKappa = kForza / kAllungamento
kW0 = sqrt(kKappa / kMassa)
kZeta = iBeta / (2 * kMassa) * kW0
kFs = (kW0 / i2_Pi) * sqrt(1 - kZeta^2)
kWs = phasor:k(kFs)
kWt = i2_Pi * kWs

printf("\n", 1)
printf("k = %f \tZ = %f \tf_nat = %f \tf_smorz = %f\n", 1, kKappa, kZeta, kW0/i2_Pi, kFs)
printf("\n", 1)

kSmorzamento = iE^(-(kT * kZeta))

aY = kSmorzamento * sin(kWt)

xout aY, kW0, (i2_Pi * kFs)
  endop


  opcode OscillatoreForzante, a, kkkk
kOmegaForzante, kOmegaNaturale, kOmegaSottoSmorzamento, kAmp xin

/*
kOmegaForzante = pulsazione dell'oscillatore forzante
kOmegaNaturale = pulsazione naturale del sistema
kOmegaSottoSmorzamento = pulsazione del sistema sotto smorzamento
kAmp = ampiezza
*/

i2_Pi = 2 * $M_PI

kWn = kOmegaNaturale
kWs = kOmegaSottoSmorzamento
kW_Forzante = kOmegaForzante
kW_F = i2_Pi * phasor(kW_Forzante/i2_Pi)

kPhi = taninv((kWs * kW_Forzante) / (kWs^2 - kW_Forzante^2))
kA0 = -kAmp * (kWn^2 - kW_Forzante^2)
kDenominatore_B = sqrt(((kWn^2 - kW_Forzante^2)^2) + (4 * kWs * kW_Forzante^2))
kB = kA0 / kDenominatore_B

aY = kB * cos(kW_F - kPhi)

xout aY
  endop


  instr OscillatoreSmorzato

kMassa = .05
kAll = 3 * 10^-3
kAmp = .5
kNewt = 1800
iBeta = 1.8 * 10^-5

aSigSmorz, kWn, kWs OscSmorzato kMassa, kNewt, kAll, iBeta
aY = kAmp * aSigSmorz

  outs(aY, aY)

    display(aY, .01)

  endin

  instr OscillatoreForzatoSmorzato

kMassa = .05
kAll = 3 * 10^-3
kAmp = .5
kNewt = 1800
iBeta = 1.8 * 10^-5

aSigSmorz, kWn, kWs OscSmorzato kMassa, kNewt, kAll, iBeta

kW_Forzante = kWn * 2 ;!=w0
aSigForz = OscillatoreForzante(kW_Forzante, kWn, kWs, kAmp)

aY = kAmp * (aSigSmorz + aSigForz)

  outs(aY, aY)

    display(aY, .01)

  endin


  instr OscillatoreForzante

i2_Pi = 2 * $M_PI
kWn = 150 * i2_Pi
kWf = kWn * 0.9 ;!= kWn

kAmp = .5
kA0 = -kAmp * (kWn^2 - kWf^2)
kAmpForzante = kA0 / (kWn^2 - kWf^2)

aY = kAmp * sin(i2_Pi * phasor:k(kWn / i2_Pi)) + kAmpForzante * cos(i2_Pi * phasor:k(kWf / i2_Pi))


;---aY_Catastrofico... non accendere gli altoparlanti!!!---
kT init 0
kT += (1 / kr)
aY_Catastrofico = kAmp * cos(i2_Pi * phasor:k(kWn / i2_Pi)) + ((kA0 / 2 * kWn) * kT) * sin(i2_Pi * phasor:k(kWn / i2_Pi))
;----------------------------------------------------------

  outs(aY, aY)

    display(aY_Catastrofico, .01)

  endin


</CsInstruments>
<CsScore>
i "OscillatoreSmorzato" 0 10
i "OscillatoreForzatoSmorzato" 11 10
i "OscillatoreForzante" 22 10
</CsScore>
</CsoundSynthesizer>
