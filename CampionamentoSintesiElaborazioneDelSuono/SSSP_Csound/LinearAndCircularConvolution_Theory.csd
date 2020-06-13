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
DIMOSTRAZIONE DEL PROCEDIMENTO DI CONVOLUZIONE

y[n] = ∑ h[n]·x[n - k]

N.B.
y[n] = ∑ h[n]·x[n - k] e y[n] = ∑ h[n-k]·x[n] per la proprietà commutativa restituiscono lo stesso risultato


CIRCULAR CONVOLUTION "CC":
STESSA LUNGHEZZA ---> ZERO PADDING

y_lenght = x_lenght = h_lenght

x[][] = y_lenght, 1
h[][] = y_lenght, y_lenght

y[n] = h[][] · x[][] ---> ---> matrice risultante dopo CC -------> righe = y_lenght e colonne = 1


LINEAR CONVOLUTION  "LC":
LUNGHEZZA DOPO CONVOLUZIONE = (x_lenght + h_lenght) - 1 = y_lenght

IN ---> x[][] = y_lenght, 1
IR ---> h[][] = y_lenght, y_lenght

y[n] = h[][] · x[][] ---> matrice risultante -------> righe = y_lenght e colonne = 1



---------
PSEUDO CODE AUDIO CONVOLUTION

h[n] = tabella IR
x[n] = input
y[n] = output

y = 0
n = ksmps

aBuf delayr ((len(h) - 1) / sr)
until (n == (len(h))) do
  y[n] += deltapn(n) * table(n, h)
  n += 1
od
delayw(x)

out = y[n] + x * table(0, h)

procedimento implementato nell'opcode "dconv"
---------
*/



  opcode Convol, 0, k[]k[]i
kX[], kH[], iMode xin

/*
kX[] = IN array
kH[] = IR array
iMode = se 0 = convoluzione circolare, se 1 = convoluzione lineare
*/

iLx = lenarray:i(kX)
iLh = lenarray:i(kH)

if(iMode = 0) then

    if(iLx >= iLh) then
      iL = iLx
      elseif(iLx < iLh) then
        iL = iLh
      endif

  elseif(iMode = 1) then
    iL = (lenarray:i(kX) + lenarray:i(kH)) - 1
  endif


kMat_x[][] init iL, 1
kMat_h[][] init iL, iL
kConv[][] init iL, iL

ki = 0
until (ki == lenarray:k(kX)) do
  kMat_x[ki][0] = kX[ki]
  kj = 0
  until (kj == lenarray:k(kH)) do
    kMat_h[kj][0] = kH[kj]
    kj += 1
  od
  ki += 1
od

kRow_0 = 1
until (kRow_0 == iL) do
  kMat_h[0][kRow_0] = kMat_h[iL - kRow_0][0]
  kRow_0 += 1
od

kNdxRow = 1
until (kNdxRow == iL) do
  kNdxCol = 1
  until (kNdxCol == iL) do
    kMat_h[kNdxRow][kNdxCol] = kMat_h[kNdxRow - 1][kNdxCol - 1]
    kNdxCol += 1
  od
  kNdxRow += 1
od

kNdxConv_Row = 0
until (kNdxConv_Row == iL) do
  kNdxConv_Col = 0
  until (kNdxConv_Col == 1) do
    kNdxConv_ColRow = 0
    until (kNdxConv_ColRow == iL) do
      kConv[kNdxConv_Row][kNdxConv_Col] = kConv[kNdxConv_Row][kNdxConv_Col] + (kMat_h[kNdxConv_Row][kNdxConv_ColRow] * kMat_x[kNdxConv_ColRow][kNdxConv_Col])
      kNdxConv_ColRow += 1
    od
    kNdxConv_Col += 1
  od
  kNdxConv_Row += 1
od

printf("\n", 1)
kP1 init 0
until (kP1 == iL) do
  printf("SEGNALE IN USCITA ---> y[%d] = %f\n", kP1+1, kP1, kConv[kP1][0])
  kP1 += 1
od
printf("\n", 1)
  endop


  instr ConvMatrix

kX[] = fillarray(1, 2, 3, 4) ;IN
kH[] = fillarray(0, 2, 2, 2) ;IR

Convol(kX, kH, 1)

  endin



</CsInstruments>
<CsScore>

i "ConvMatrix" 0 1

</CsScore>
</CsoundSynthesizer>
