    opcode LPFBCF, a, aiik
aIn, iT60, iSampleDel, kFreqLowPass xin

iRit = iSampleDel / sr
iG = 10^((-3 * iRit) / iT60)

aBuf delayr 1
aComb = deltapi(iRit)
aLowPass = tone(aComb * iG, kFreqLowPass)
    delayw(aIn + aLowPass)

xout aLowPass
    endop

    opcode AP, a, aii
aIn, iT60, iSampleDel xin

iRit = iSampleDel / sr
iG = 10^((-3 * iRit) / iT60)

aBuf delayr 1
aAllPass = deltapi(iRit)
aAP = aAllPass + (aIn * -iG)
    delayw(aIn + (aAP * iG))

xout aAP
    endop



    opcode Schroeder_Chowning, aa, aik
aIn, iT60, kFreqLowPass xin

iDelAp[] = fillarray(347, 113, 37)
iDelCf[] = fillarray(1687, 1601, 2053, 2251)

;---SEZIONE ALLPASS---
aAllPass_1 = AP(aIn * .5, iT60, iDelAp[0])
aAllPass_2 = AP(aAllPass_1, iT60, iDelAp[1])
aAllPass_3 = AP(aAllPass_2, iT60, iDelAp[2])

;---SEZIONE COMB---
aComb_1 = LPFBCF(aAllPass_3, iT60, iDelCf[0], kFreqLowPass)
aComb_2 = LPFBCF(aAllPass_3, iT60, iDelCf[1], kFreqLowPass)
aComb_3 = LPFBCF(aAllPass_3, iT60, iDelCf[2], kFreqLowPass)
aComb_4 = LPFBCF(aAllPass_3, iT60, iDelCf[3], kFreqLowPass)
;---------------------------------

aY1 = aComb_1
aY2 = aComb_2
aY3 = aComb_3
aY4 = aComb_4


;---APPLICAZIONE MATRICE DI MISCELAZIONE---
iIn = 4

aY[] init iIn
aY[0] = aComb_1
aY[1] = aComb_2
aY[2] = aComb_3
aY[3] = aComb_4

aYOut[] init iIn

kMM[][] init iIn, iIn
kMM[][] = fillarray(1,  1,  1,  1,
                   -1, -1, -1, -1,
                   -1,  1, -1,  1,
                    1, -1,  1, -1)

ki = 0
until (ki == iIn) do
    kj = 0
    aYOut[ki] = 0
    until (kj == iIn) do
        aYOut[ki] = aYOut[ki] + (aY[kj] * kMM[ki][kj])
        kj += 1
    od
    ki += 1
od

aL = (aYOut[0] + aYOut[2]) / 2
aR = (aYOut[1] + aYOut[3]) / 2

aLeft = aL
aRight = aR

    ;dispfft(aLeft - aRight, .1, 2048) ;N.B.

xout aLeft, aRight
    endop
