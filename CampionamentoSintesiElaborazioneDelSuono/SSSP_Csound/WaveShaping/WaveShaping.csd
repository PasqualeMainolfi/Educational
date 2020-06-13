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
WAVESHAPING

x(t) ---> f(x) ---> f(x)t

f(x) = funzione di trasferimento
*/

  opcode WavePoly, a, akk[]iop
aIn, kNdx, kCoeff[], iN, iNorm, iCount xin

/*
aIn = segnale in entrata
kNdx = indice di Waveshaping
kCoeff[] = array coefficienti polinomio
iN = grado del polinomio
iNorm = opzionale: 0 = segnale non normalizzato; 1 = segnale normalizzato
*/

aPoly = kCoeff[iCount - 1] * (kNdx^(iCount) * aIn^(iCount))
if(iCount < iN) then
  aY = WavePoly(aIn, kNdx, kCoeff, iN, iNorm, iCount + 1)
endif

if(iNorm = 0) then
  aOut = aPoly + aY
  elseif(iNorm = 1) then
    aOut = (aPoly / iN) + aY
  endif

xout aOut
  endop

  opcode WaveShaping_Function, a, ai
aIn, iN xin

aOut = aIn / (1 + abs(iN + aIn))

xout aOut
	endop


  opcode WaveShaping_Esponential, a, ak
aIn, kNdx xin

aE = $M_E
kSig = downsamp(aIn)
kX = kSig - 1
aY = (aE^(kNdx * kX))

xout aY
  endop

  instr WaveShaping_Table

    iTable[] init 5
    iTable[0] = ftgen(1, 0, 16835, -7, -.5, 16384, .5) ;BOX ATTENUATORE
    iTable[1] = ftgen(2, 0, 16835, -7, 1, 16384, -1) ;BOX INVERSORE
    iTable[2] = ftgen(3, 0, 16385, -7, -.3, (16384 / 4), -.3, (16384 / 2), .3, (16384 / 4 ), .3) ;CLIPPING FUNCTION
    iTable[3] = ftgen(4, 0, 16385, "tanh", -1, 1) ;FUNZIONE TANH

iAmp = .9
kFreq = 220
aX = linseg:k(0, .1, iAmp, p3 - .2, iAmp, .1, 0) * sin((2 * $M_PI) * phasor:k(kFreq))
aIndx = (aX + 1) / 2

aWaveShape = table(aIndx, iTable[p4], 1)

  outs(aWaveShape, aWaveShape)

  endin


  instr WaveShaping_PascalTriangle

/*
f(x) = d0 + d1 * a * x + d2 * a^2 * x^2 + d3 * a^3 * x^3 ... + dn * a^n * x^n

---> y in uscita, normalizzato = y / 1 + |x|

RISULTANTE SPETTRALE ---> PASCAL TRIANGLE

            1 ---> 1                n = 0
          1   1 ---> 2              n = 1
        1   2   1 ---> 4            n = 2
      1   3   3   1 ---> 8          n = 3
    1   4   6   4   1 ---> 16       n = 4
  1   5  10  10   5   1 ---> 32     n = 5
1   6  15  20  15   6   1 ---> 64   n = 6
...

C[n, k] = n! / k!·(n-k)! =  ---> 1 per k = 0 e k = n
                            ---> C[n - 1] + C[n - 1] per tutti gli altri casi

n DIV.     ARMONICHE
0 0.5 ---> 1
1 1   --->   1
2 2   ---> 2   1
3 4   --->   3   1
4 8   ---> 6   4   1
5 16  --->  10   5   1
...

ordine pari ---> solo armoniche pari
ordine dispari ---> solo armoniche dispari
*/

iNdx = 10 ;indice di waveshaping
kA = linseg:k(0, p3/2, iNdx, p3/2, 0)
iFreq = 120
aX = sin((2 * $M_PI) * phasor:k(iFreq))
iN = 6 ;grado del polinomio

iD_0 = 1
iD_1 = 1/2
iD_2 = 1/3
iD_3 = 1/4
iD_4 = 1/5
iD_5 = 1/6

aY = 1 + (iD_0 * (kA * aX)) + (iD_1 * (kA^2 * aX^2)) + (iD_2 * (kA^3 * aX^3)) + (iD_3 * (kA^4 * aX^4)) + (iD_4 * (kA^5 * aX^5)) + (iD_5 * (kA^6 * aX^6))
aY = aY / (1 + abs(iN + aY))

  outs(aY, aY)

  	dispfft(aY, .1, 2048)

  endin


  instr Wave_PolyOpcode

iNdx = p4
kAmp = linseg:k(0, p3/2, iNdx, p3/2, 0)
kCoeff[] = fillarray(1, 1/2, 1/3, 1/4, 1/5, 1/6)
iN = lenarray:i(kCoeff)
iNorm = p5
print(iN)

iFreq = 120
aX = sin((2 * $M_PI) * phasor:k(iFreq))

aY = WavePoly(aX, kAmp, kCoeff, iN, iNorm)
aY = WaveShaping_Function(aY, iN)

  outs(aY, aY)

    dispfft(aY, .1, 2048)

  endin


  instr WaveShaping_Cebysev

/*
POLINOMI DI CEBYSEV

T0(x) := 1
T1(x) := x
T2(x)  = 2x^2 - 1
T3(x)  = 4x^3 - 3x
T4(x)  = 8x^4 - 8x^2 + 1
T5(x)  = 16x^5 - 20x^3 + 5x
T[k + 1](x) = 2xT[k](x) - T[k - 1](x)
*/

iNdx = 10 ;indice di waveshaping
kAmp = expseg:k(.001, .01, iNdx, p3 - .01, .00001)
iFreq = 120
aX = sin((2 * $M_PI) * phasor:k(iFreq))
iN = 5

aT_0 = 1
aT_1 = aX
aT_2 = 2 * (aX^2) - 1
aT_3 = 4 * (aX^3) - (3 * aX)
aT_4 = 8 * (aX^4) - (8 * (aX^2)) + 1
aT_5 = 16 * (aX^5) - (20 * (aX^3)) + (5 * aX)

kA_1 = 1 * kAmp
kA_2 = 1/2 * kAmp
kA_3 = 1/3 * kAmp
kA_4 = 1/4 * kAmp
kA_5 = 1/5 * kAmp



aY = (kA_1 * aT_1) + (kA_2 * aT_2) + (kA_3 * aT_3) + (kA_4 * aT_4) + (kA_5 * aT_5)
aY = tanh(aY)

	outs(aY, aY)

		dispfft(aY, .1, 2048)


  endin

  instr WaveShaping_Esponential

;f(a * cos(wn)) = e^(a * cos(wn) - 1)

iNdx = 1000 ;indice di waveshaping
kIndice = expseg:k(.001, .01, iNdx, p3 - .01, .0001)
kFreq = 120
aSig = cos((2 * $M_PI) * phasor:k(kFreq))

aY = expseg:k(.001, .01, 1, p3 - .01, .001) * WaveShaping_Esponential(aSig, kIndice)

  outs(aY, aY)

    dispfft(aY, .1, 2048)

  endin


</CsInstruments>
<CsScore>
i "WaveShaping_Table" 0 3 0
i "WaveShaping_Table" 4 3 1
i "WaveShaping_Table" 8 3 2
i "WaveShaping_Table" 12 3 3

i "WaveShaping_PascalTriangle" 16 3

i "Wave_PolyOpcode" 20 3 .9 1
i "Wave_PolyOpcode" 24 3 10 0

i "WaveShaping_Cebysev" 28 3
i "WaveShaping_Esponential" 32 3
</CsScore>
</CsoundSynthesizer>
