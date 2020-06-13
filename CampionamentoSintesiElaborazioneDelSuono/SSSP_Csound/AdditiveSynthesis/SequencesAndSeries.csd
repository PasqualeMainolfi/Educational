<CsoundSynthesizer>
<CsOptions>
-o dac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1



#include "SequencesAndSeries.udo"



  instr Seq

istart = 1 //termine di partenza
kd = 1 //ragione
ilen = 10 //numero di elementi

ksequenzaAritmetica[] = seqAritmetica(istart, kd, ilen)
ksequenzaGeometrica[] = seqGeometrica(istart, kd, ilen)
ksequenzaArmonica[] = seqArmonica(ksequenzaAritmetica)
ksequenzaTelescopica[] = seqTelescopica(istart, ilen)

  endin


  instr Series

istart = 1.21
kd = 1.2
ilen = 10
kf0 = 440
kmaxAmp = 1

kserieFreq[] = seqGeometrica(istart, kd, ilen) //frequenze ---> serie geometrica
kserieAmp[] = seqArmonica(seqAritmetica(istart, kd, ilen)) //ampiezze ---> serie armonica

asig = linseg:k(0, .5, 1, p3 - .5, 0) * series(kf0, kmaxAmp, kserieFreq, kserieAmp)

  outs(asig, asig)

  endin



</CsInstruments>
<CsScore>

;i "Seq" 0 1
i "Series" 0 10

</CsScore>
</CsoundSynthesizer>
