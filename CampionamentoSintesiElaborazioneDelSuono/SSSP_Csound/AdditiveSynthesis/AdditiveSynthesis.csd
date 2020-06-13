<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1

  opcode OscBank, a, kkk[]k[]io
kAmp, kFund, kCoeff[], gkForm[], iNum, iCount xin

/*
kAmp = ampiezza frequenza fondamentale
kFund = frequenza fondamentale
kCoeff[] = array coefficienti di ampiezza
gkForm[] = array valori moltiplicativi frequenza fondamentale per generazione formanti
iNum = numero totale di formanti
*/

i2_Pi = 2 * $M_PI
aSig = ((kAmp * kCoeff[iCount]) * sin(i2_Pi * (phasor:k(kFund * gkForm[iCount])))) / iNum

iDigi = iCount + 1
if(iDigi < iNum) then
aSigSum = OscBank(kAmp, kFund, kCoeff, gkForm, iNum, iDigi)
endif

xout aSig + aSigSum
  endop


  instr StaticAdditive

kCoefficientiAmpiezze[] = fillarray(1, 1/6, 1/3, 1/5, 1/4, 1/2)
kFormanti[] = fillarray(1, 1.8, 2.5, 3.6, 4.3, 5.2)
kAmpFondamentale = .9
kFreqFondamentale = 120
iNumFormanti = lenarray:i(kFormanti)

aSig = OscBank(linseg:k(0, p3/3, 1, p3 - (p3/3), 0) * kAmpFondamentale, kFreqFondamentale, kCoefficientiAmpiezze, kFormanti, iNumFormanti)

outs(aSig, aSig)

  endin


  instr DynamicAdditive

iFond = 220
iAmpFond = .9

aF1 = poscil(expseg:k(.001, .01, 1, p3 - .01, .0001) * iAmpFond, linseg:k(iFond, .01, 1.21, p3/2 - .01, 1.15, p3/2, 1.18) * iFond)
aF2 = poscil(expseg:k(.001, .01, 1, p3 - .01, .0001) * iAmpFond/1.8, linseg:k(iFond, .01, 1.15, p3/3, 1.02, p3 - (p3/3 - .01), 1.09) * (2 * iFond))
aF3 = poscil(expseg:k(.001, .07, 1, p3 - .07, .0001) * iAmpFond/2.5, linseg:k(iFond, .01, .97, p3/2, 1, p3 - (p3/2 - .01), 1) * (3.3 * iFond))
aF4 = poscil(expseg:k(.001, .081, 1, p3 - .081, .0001) * iAmpFond/2.8, linseg:k(iFond, .01, .95, p3 - (p3/2 - .01), .99, p3/2, .97) * (4 * iFond))
aF5 = poscil(expseg:k(.001, .09, 1, p3 - .09, .0001) * iAmpFond/3.6, linseg:k(iFond, .01, 1, p3/2, 1.07, p3/2, 1.02) * (5.5 * iFond))

aOut = (aF1 + aF2 + aF3 + aF4 + aF5) / 5

  outs(aOut, aOut)

  endin

</CsInstruments>
<CsScore>
i "StaticAdditive" 0 10
i "DynamicAdditive" 11 21
</CsScore>
</CsoundSynthesizer>
