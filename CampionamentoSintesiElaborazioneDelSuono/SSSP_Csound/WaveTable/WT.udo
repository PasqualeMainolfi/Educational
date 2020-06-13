    opcode InterpLineare, a, kkkkk
kSI, kXa, kYa, kXb, kYb xin

kDecimale_Inf = kSI - int(kSI)
kDecimale_Sup = int(kSI + 1) - kSI

aValue = ((kDecimale_Sup/(kXb - kXa)) * kYa) + ((kDecimale_Inf/(kXb - kXa)) * kYb)
xout(aValue)
    endop

    opcode TableFill, k[], ik[]
iN, kA[] xin

i2Pi = 2 * $M_PI
iRow = lenarray:i(kA)
iCol = iN

kMatrix[][] init iRow, iCol
kY[] init iN

ki init 0
until (ki == iRow) do
kj = 0
    until (kj == iCol) do
        kMatrix[ki][kj] = kA[ki] * sin(((ki + 1) * i2Pi/iN) * kj)
        kY[kj] = kY[kj] + kMatrix[ki][kj]
        ;printf("[%d] = %f\n", kj + 1, kj, kY[kj])
        kj += 1
    od
    ki += 1
od

xout(kY/iRow)
    endop


/*
STATIC WAVETABLE OSCILLATOR
...ad interpolazione lineare
*/

    opcode WT_Static, a, ikk[]
iN, kF, kA[] xin

iN_1 = iN - 1
kSI = (iN * kF)/sr

kWT[] = TableFill(iN, kA)

ki init 0
if(ki < iN) then
    aWT = InterpLineare(kSI, ki, kWT[ki], ki + 1, kWT[ki + 1])
    ki += int:k(kSI)
    ki = ki%iN ;(operatore modulo)
endif

xout(aWT)
    endop

;===================================

/*
VARIABLE WAVETABLE OSCILLATOR
...ad interpolazione lineare
*/

    opcode WT_Dynamic, a, ikk[]k[]k
iN, kF, kA_1[], kA_2[], kInv xin

iN_1 = iN - 1
kSI = (iN * kF)/sr

kW[] init iN

kScale1 = (1 - kInv)
kScale2 = kInv

kW1[] = TableFill(iN, kA_1) * kScale1
kW2[] = TableFill(iN, kA_2) * kScale2

ki init 0
if(ki < iN) then
    aWT = InterpLineare(kSI, ki, kW1[ki] + kW2[ki], ki + 1, kW1[ki + 1] + kW2[ki + 1])
    ki += int:k(kSI)
    ki = ki%iN_1
endif

xout(aWT)
    endop

;===================================
