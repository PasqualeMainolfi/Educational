<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1


#include "FM.udo"

/*
N.B.
- Per calcolare la frequenza portante di un rapporto membro, affinche la risultante spettrale abbia
la stessa fondamentale, bisogna prima di tutto ridurre in Normal Form e, poi:

P_f = P_ratio * (P_f / P_ratio in normal form)

- Conoscendo la frequenza portante, possiamo calcolare la frequenza fondamentale nei rapporti in Non in Normal Form
nel modo in cui segue:

f_0 = P_f * (P_ratio in normal form / P_ratio)

- Conoscendo la fondamentale f_0 possiamo conoscere la portante, nel modo in cui segue:

P = [(f_0 / P_ratio) / P_ratio in normal form]
*/


  instr Simple_FM

kPortante = 120
iRapporto = 5 / 7
kAmpPortante = .9
kAmpModulante = 2500
kCost = 1

aFM = Simple_FM(kPortante, iRapporto, expseg:k(.001, .01, 1, p3 - .01, .001) * kAmpPortante, expseg:k(.001, .01, 1, p3 - .01, .001) * kAmpModulante, kCost)

  outs(aFM, aFM)

  endin


  instr FM_PortanteComposta

kPortante = 120
iRapporto = 5 / 7
kAmpPortante = .9
kAmpModulante = 2500
kCost = 1

kAmpFormanti[] = fillarray(1, 1/2, 1/3, 1/4, 1/5, 1/6, 1/7)
kFormanti[] = fillarray(1, 2, 3, 4, 5, 6, 7)
iNumFormanti = 7

aFM_PortanteComplessa = CompCar_FM(kPortante, iRapporto, expseg:k(.001, .01, 1, p3 - .01, .001) * kAmpPortante, expseg:k(.001, .01, 1, p3 - .01, .001) * kAmpModulante, kCost, kAmpFormanti, kFormanti, iNumFormanti)

  outs(aFM_PortanteComplessa, aFM_PortanteComplessa)

  endin

  instr FM_ModulanteComposta

kPortante = 120
iRapporto = 2 / 5
kAmpPortante = .9
kAmpModulante = 2500
kCost = 1

kAmpFormanti[] = fillarray(1, 1/2, 1/3, 1/4, 1/5, 1/6, 1/7)
kFormanti[] = fillarray(1, 2, 3, 4, 5, 6, 7)
iNumFormanti = 7

aFM_ModulanteComplessa = CompMod_FM(kPortante, iRapporto, expseg:k(.001, .01, 1, p3 - .01, .001) * kAmpPortante, expseg:k(.001, .01, 1, p3 - .01, .001) * kAmpModulante, kCost, kAmpFormanti, kFormanti, iNumFormanti)

  outs(aFM_ModulanteComplessa, aFM_ModulanteComplessa)

  endin


  instr FM_FeedBack

kPortante = 120
kAmp = .77
kBeta = 1.5

aFM_FeedBack = FeedBack_FM(kPortante, expseg:k(.001, p3 / 2, 1, p3 / 2, .001) * kAmp, kBeta)

  outs(aFM_FeedBack, aFM_FeedBack)

  endin


</CsInstruments>
<CsScore>
i "Simple_FM" 0 5
i "FM_PortanteComposta" 5 5
i "FM_ModulanteComposta" 10 5
i "FM_FeedBack" 15 5
</CsScore>
</CsoundSynthesizer>
