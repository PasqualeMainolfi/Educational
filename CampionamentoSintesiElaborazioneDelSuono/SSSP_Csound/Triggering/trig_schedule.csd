<CsoundSynthesizer>
<CsOptions>
-o dac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1

/* TRIGGERING INSTRUMENTS EVENTS ---> WITH SCHEDULE */

seed(0)


	instr 1

icount = 0
ip2 = 0
itimes = 7
while (icount < itimes) do
	idur = random(.3, 1)
	ifreq = random(100, 210)
	schedule("sched", ip2, idur, ifreq)
	p3 = p3 + idur //settiamo automaticamete la durata dello strumento 1
	ip2 += idur
	icount += 1
od

	endin


	instr sched

a1 = poscil:a(linseg:k(0, .005, .5, p3 - .005, 0), p4)
	outs(a1, a1)
	
	endin


</CsInstruments>
<CsScore>

i 1 0 1

</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>0</x>
 <y>0</y>
 <width>0</width>
 <height>0</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
 <bsbObject type="BSBGraph" version="2">
  <objectName/>
  <x>28</x>
  <y>27</y>
  <width>427</width>
  <height>358</height>
  <uuid>{dd5626fd-728b-42a2-a29a-0ae5d531601d}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <description/>
  <value>0</value>
  <objectName2/>
  <zoomx>1.00000000</zoomx>
  <zoomy>1.00000000</zoomy>
  <dispx>1.00000000</dispx>
  <dispy>1.00000000</dispy>
  <modex>lin</modex>
  <modey>lin</modey>
  <showSelector>true</showSelector>
  <showGrid>true</showGrid>
  <showTableInfo>true</showTableInfo>
  <showScrollbars>true</showScrollbars>
  <enableTables>true</enableTables>
  <enableDisplays>true</enableDisplays>
  <all>true</all>
 </bsbObject>
</bsbPanel>
<bsbPresets>
</bsbPresets>
