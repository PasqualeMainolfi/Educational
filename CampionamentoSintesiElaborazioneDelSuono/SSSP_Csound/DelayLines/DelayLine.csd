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
DELAY LINE

y[n] = x[n] + g * y[n - d] ---> ad anello aperto
y[n] = x[n] + x[n - d] ---> ad anello chiuso

d / sample rate = ritardo in secon
*/


  instr Echo

/*
v = s / t = 2 * distanza / t
DistanzaMin = v * t / 2 = 340 * (1 / 10) = 17 m
*/

aSig = poscil(expseg:k(.001, .01, .9, p3 - .01, .001), 120)

iSample = 25000
iRit = iSample / sr ;da campioni a secondi (per echo > 1/10 di secondo)
aEcho = delay(aSig, iRit)
aOut = (aSig + aEcho) / 2

  outs(aOut, aOut)

  endin


  instr Multitap_Delay

aSig = poscil(linseg:k(0, .01, .9, .05, 0, p3 - .051, 0), 190)
aDelay delayr 3

  aTap_0 = deltapi(.3)
  aTap_1 = deltapi(.5)
  aTap_2 = deltapi(2.1)
  aTap_3 = deltapi(2.7)

      delayw(((aTap_3 * .9) + aSig))

aLeft = ((aTap_0 + aTap_1) + aSig) / 2
aRight = ((aTap_2 + aTap_3) + aSig) / 2

  outs(aLeft, aRight)

  endin



  instr PingPong_Delay

aSig = poscil(linseg:k(0, .01, .9, .05, 0, p3 - .051, 0), 190)

aTap_2 init 0

iDel_1 = .3
iDel_2 = .21

aBuf_1 delayr 1
  aTap_1 = deltapi(iDel_1)
    delayw(aSig + (aTap_2 * .7))

aBuf_2 delayr 1
  aTap_2 = deltapi(iDel_2)
    delayw(aTap_1 * .7)

aLeft = aTap_1 * .81
aRight = aTap_2 * .81

  outs(aLeft, aRight + (aSig * .5))

  endin


</CsInstruments>
<CsScore>

i "Echo" 0 5
i "Multitap_Delay" 5 15
i "PingPong_Delay" 20 10

</CsScore>
</CsoundSynthesizer>
