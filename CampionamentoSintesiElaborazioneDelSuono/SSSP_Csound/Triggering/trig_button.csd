<CsoundSynthesizer>
<CsOptions>
-o dac
</CsOptions>
<CsInstruments>


sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1


/* TRIGGERING INSTRUMENTS EVENTS ---> WITH BUTTON (WIDGET) */

seed(0)

	instr 1

idur = random(.5, 3)
ifreq = random(50, 500)
p3 = idur
a1 = poscil(linseg:k(0, .001, .3, p3 - .001, 0), ifreq)
	outs(a1, a1)
	
	
if(ifreq > 360) then //quando il valore di frequenza supera la soglia, spegne l'ultima istanza dello strumento 1 ed attiva lo strumento 2
	turnoff2(1, 1, 1)
	event_i("i", 2, 0, idur)
endif

	endin


	instr 2
a1 = rand(.3) * linseg:k(0, .001, .3, p3 - .001, 0)
	outs(a1, a1)
	endin



</CsInstruments>
<CsScore>

f 0 3600


</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>0</x>
 <y>0</y>
 <width>170</width>
 <height>102</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
 <bsbObject type="BSBButton" version="2">
  <objectName>on</objectName>
  <x>69</x>
  <y>40</y>
  <width>100</width>
  <height>30</height>
  <uuid>{c67114cc-b199-4ee4-9580-40237eb7de92}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <description/>
  <type>event</type>
  <pressedValue>1.00000000</pressedValue>
  <stringvalue/>
  <text>trig</text>
  <image>/</image>
  <eventLine>i 1 0 10</eventLine>
  <latch>false</latch>
  <latched>false</latched>
  <fontsize>10</fontsize>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>69</x>
  <y>70</y>
  <width>101</width>
  <height>32</height>
  <uuid>{899e30fd-feeb-41ec-8236-e4be45711221}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <description/>
  <label>trig instr 1</label>
  <alignment>center</alignment>
  <valignment>top</valignment>
  <font>Arial</font>
  <fontsize>18</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>false</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>0</borderwidth>
 </bsbObject>
</bsbPanel>
<bsbPresets>
</bsbPresets>
