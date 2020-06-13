    opcode AllPass, a, aik
aIn, iRit, kG xin

aAllPass delayr iRit
    aAP = aAllPass + (aIn * -kG)
        delayw(aIn + (aAP * kG))

xout aAP
    endop



    opcode Dot_Plate, aa, aiikk
aIn, iT60, iG_Decay, kLowPre, kLowRev xin

/*
aIn = sig in
kT60 = tempo di riverbero
kLowPre = frequenza di taglio filtro passa-basso posto a monte
kLowRev = frequenza di taglio filtro passa-basso posto a valle
*/

iT[] = fillarray(142, 107, 379, 277, 908, 4217, 2656, 3163, 672, 4453, 1800, 3720)

;---DECORRELAZIONE---
iDecSampleLeft[] = fillarray(266, 2974, 1913, 1996, 1990, 187, 1066)
iDecSampleRight[] = fillarray(353, 3627, 1228, 2673, 2111, 335, 121)

iDecLeft[] = iDecSampleLeft / sr
iDecRight[] = iDecSampleRight / sr
;--------------------

kLowPass[] = fillarray(kLowPre, kLowRev)

iRit[] = iT / sr
kNdxPrintRit init 0

iPow_Esponente = -3 / iT60

kGuadagno[] init lenarray(iRit)
kNdxGuadagno init 0
until (kNdxGuadagno == lenarray:i(iRit)) do
    kGuadagno[kNdxGuadagno] = 10^(iPow_Esponente * iRit[kNdxGuadagno])
    kNdxGuadagno += 1
od

aLowPass_In = tone(aIn * .21, kLowPass[0])

a1 = AllPass(aLowPass_In, iRit[0], kGuadagno[0])
a2 = AllPass(a1, iRit[1], kGuadagno[1])
a3 = AllPass(a2, iRit[2], kGuadagno[2])
a4 = AllPass(a3, iRit[3], kGuadagno[3])

    aDel_2 init 0
    aDel_4 init 0

aSplit_1 = a4 + (aDel_4 * iG_Decay)
aSplit_2 = a4 + (aDel_2 * iG_Decay)

    aLowPass_1 init 0
    aLowPass_2 init 0

;---LINEA 1---
a5 = AllPass(aSplit_1, iRit[4], kGuadagno[4])

    aDel_1 = delay(a5, iRit[5])
    aLowPass_1 = tone(aDel_1, kLowPass[1])

a6 = AllPass(aLowPass_1, iRit[6], kGuadagno[6])

    aDel_2 = delay(a6, iRit[7])

;---LINEA 2---
a7 = AllPass(aSplit_2, iRit[8], kGuadagno[8])

    aDel_3 = delay(a7, iRit[9])
    aLowPass_2 = tone(aDel_3, kLowPass[1])

a8 = AllPass(aLowPass_2, iRit[10], kGuadagno[10])

    aDel_4 = delay(a8, iRit[11])


;---DECORRELAZIONE PER OUTS---
;---PRELIEVO A---
aDecOut_1 delayr iT60

    aY1_Left = deltapi(iDecLeft[0])
    aY2_Left = deltapi(iDecLeft[1])
    aY5_Right = deltapi(iDecRight[4])

        delayw(a5)

;---PRELIEVO B---
aDecOut_2 delayr iT60

    aY3_Left = deltapi(iDecLeft[2])
    aY6_Right = deltapi(iDecRight[5])

        delayw(aLowPass_1)

;---PRELIEVO C---
aDecOut_3 delayr iT60

    aY4_Left = deltapi(iDecLeft[3])
    aY7_Right = deltapi(iDecRight[6])

        delayw(aDel_2)

;---PRELIEVO D---
aDecOut_4 delayr iT60

    aY5_Left = deltapi(iDecLeft[4])
    aY1_Right = deltapi(iDecRight[0])
    aY2_Right = deltapi(iDecRight[1])

        delayw(a7)

;---PRELIEVO E---
aDecOut_5 delayr iT60

    aY6_Left = deltapi(iDecLeft[5])
    aY3_Right = deltapi(iDecRight[2])

        delayw(aLowPass_2)

;---PRELIEVO F---
aDecOut_6 delayr iT60

    aY7_Left = deltapi(iDecLeft[6])
    aY4_Right = deltapi(iDecRight[3])

        delayw(aDel_4)
;----------------

a1_L = aY1_Left
a2_L = aY2_Left
a3_L = -aY3_Left
a4_L = aY4_Left
a5_L = -aY5_Left
a6_L = -aY6_Left
a7_L = -aY7_Left

a1_R = aY1_Right
a2_R = aY2_Right
a3_R = -aY3_Right
a4_R = aY4_Right
a5_R = -aY5_Right
a6_R = -aY6_Right
a7_R = -aY7_Right

aOut_Left = (a1_L + a2_L + a3_L + a4_L + a5_L + a6_L + a7_L)
aOut_Right = (a1_R + a2_R + a3_R + a4_R + a5_R + a6_R + a7_R)

xout aOut_Left, aOut_Right
    endop
