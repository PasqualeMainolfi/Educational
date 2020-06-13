    opcode FBCF, a, aii
aIn, iT60, iRit xin

iG = 10^((-3 * iRit) / iT60)

aBuf delayr 1
aComb = deltapi(iRit)
    delayw(aIn + (aComb * iG))

xout aComb
    endop


    opcode AP, a, aii
aIn, iT60, iRit xin

iG = 10^((-3 * iRit) / iT60)

aBuf delayr 1
aAllPass = deltapi(iRit)
    aAP = aAllPass + (aIn * -iG)
    delayw(aIn + (aAP * iG))

xout aAP
    endop


    opcode Schroeder_Moorer, aa, ai
aIn, iT60 xin

iTau_1 = .037
iTau_2 = .039
iTau_3 = .041
iTau_4 = .043

iTau_5 = .07
iTau_6 = .023

;---SEZIONE COMB---
aComb_1 = FBCF(aIn * .7, iT60, iTau_1)
aComb_2 = FBCF(aIn * .7, iT60, iTau_2)
aComb_3 = FBCF(aIn * .7, iT60, iTau_3)
aComb_4 = FBCF(aIn * .7, iT60, iTau_4)

aCombOut = (aComb_1 + aComb_2 + aComb_3 + aComb_4) / 2

;---SEZIONE ALLPASS---
aAllPass_1 = AP(aCombOut, iT60, iTau_5)
aAllPass_2 = AP(aAllPass_1, iT60, iTau_6)

;-------------------------------------

aLeft = aAllPass_2
aRight = aAllPass_2

xout aLeft, aRight
    endop
