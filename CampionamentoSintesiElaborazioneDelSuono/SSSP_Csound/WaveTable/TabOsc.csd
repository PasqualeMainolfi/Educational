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
WAVETABLE OSCILLATOR
...esempio di wavetable format (simple sine)
*/

	opcode InterpLineare, k, ikkkk
iSI, kXa, kYa, kXb, kYb xin

iDecimale_Inf = iSI - int(iSI)
iDecimale_Sup = int(iSI + 1) - iSI

kValue = ((iDecimale_Sup/(kXb - kXa)) * kYa) + ((iDecimale_Inf/(kXb - kXa)) * kYb)
xout(kValue)
	endop


	opcode Tab, k[], ii
iN, iA xin

i2Pi = 2 * $M_PI
kTab[] init iN
ki init 0
until (ki == iN) do
	kTab[ki] = iA * sin((i2Pi/iN) * ki)
	;printf("[%d] = %f\n", ki + 1, ki, kTab[ki])
	ki += 1
od

xout(kTab)
	endop

	opcode OscTable, a, iii
iN, iF, iA xin

iN_1 = iN - 1
iSI = (iN * iF)/sr

kTab[] = Tab(iN, iA)
aPhase init 0

kj init 0
if(kj < iN) then
	aSine = aPhase * linseg(0, iStep * (1/iF), 0, 1/sr, 1)
	aPhase = a(InterpLineare(iSI, kj, kTab[kj], kj + 1, kTab[kj + 1]))
	kj += int:k(iSI)
	kj = kj%iN_1
endif


xout(aSine)
	endop



	instr Oscillatore

iF = 400
iA = .5
iN = 4096

aSine = OscTable(iN, iF, iA)

	outs(aSine, aSine)

		display(aSine, 1/iF)

	endin




</CsInstruments>
<CsScore>


i "Oscillatore" 0 5

</CsScore>
</CsoundSynthesizer>
