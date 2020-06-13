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
CIRCUL BUFFER DELAY
*/


  opcode Del_FF, a, ai
setksmps(1)

aIn, iDel xin

kPos init 0

if(iDel > (1 / sr)) then
  iL = round(iDel * sr)
  else
    iL = 1
  endif

aDelay[] init iL
aY = aDelay[kPos]

xout aY

aDelay[kPos] = aIn

if(kPos == (iL - 1)) then
  kPos = 0
  else
    kPos = kPos + 1
  endif

  endop


  opcode Del_FB, a, aik
setksmps(1)

aIn, iDel, kG xin

kPos init 0

if(iDel > (1 / sr)) then
  iL = round(iDel * sr)
  else
    iL = 1
  endif

kGuadagno = abs(kG) < 1 ? kG : 1

aDelay[] init iL
aY = (aDelay[kPos] * kGuadagno) + aIn

xout aY

aDelay[kPos] = aY

if(kPos == (iL - 1)) then
  kPos = 0
  else
    kPos = kPos + 1
  endif

  endop



  instr CirculaBufferDelay

aX = mpulse(1, 0)
iDel = .5
kG = .7

aY[] init 2
aY[0] = Del_FF(aX, iDel)
aY[1] = Del_FB(aX, iDel, kG)

  outs(aY[p4], aY[p4])

  endin



</CsInstruments>
<CsScore>

i "CirculaBufferDelay" 0 2 0
i "CirculaBufferDelay" 3 6 1


</CsScore>
</CsoundSynthesizer>
