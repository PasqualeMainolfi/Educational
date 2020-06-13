    opcode PhaseMap, i, iiiii ;funzione per il controllo della fase (mappatura)
iIn, iOutMin, iOutMax, iInMin, iInMax xin
iY = (((iIn - iInMin) * (iOutMax - iOutMin)) / (iInMax - iInMin)) + iOutMin
xout(iY)
    endop

    opcode GaborGauss, a, iii ;funzione gaussiana
iDur, iSigma, iMi xin

iPi = $M_PI
kExp = $M_E
kSegmento = phasor(1/iDur) * (2 * iPi)
aGauss = (1/(iSigma * sqrt(2 * iPi))) * kExp^(-((kSegmento - iMi)^2)/(2 * iSigma^2)) ;inviluppo gaussiano (Gabor way)

xout(aGauss)
    endop

    opcode LiveIn, i, i
iN xin
giFunction = ftgen(1, 0, iN, 2, 0)
iTime = iN/sr
aIn = inch(1)

    tablew(aIn, phasor:a(1/iTime), giFunction, 1)

xout(giFunction)
    endop

    opcode SoundGranulation, i, S
SName xin
giSoundGranulation = ftgen(2, 0, 0, 1, SName, 0, 0, 0)

xout(giSoundGranulation)
endop
