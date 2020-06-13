<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1


  opcode DX7, a, kkkkkkkkkkkkii
kF1, kA1, kF2, kA2, kF3, kA3, kF4, kA4, kF5, kA5, kF6, kA6, iFb, iMode xin

if(iMode = 1) then
  a2 = poscil(kA2 * kF2, kF2)
  a1 = poscil(kA1, kF1 + a2)

  a6f init 0
  a6 = poscil(kA6, kF6 + a6f)
  a6f = a6 * iFb
  a5 = poscil(kA5 * kF5, kF5 + a6)
  a4 = poscil(kA4 * kF4, kF4 + a5)
  a3 = poscil(kA3, kF3 + a4)

  aY = (a1 + a3)/2
  elseif(iMode = 2) then
    a2f init 0
    a2 = poscil(kA2, kF2 + a2f)
    a2f = a2 * iFb
    a1 = poscil(kA1, kF1 + a2)

    a6 = poscil(kA6 * kF6, kF6)
    a5 = poscil(kA5 * kF5, kF5 + a6)
    a4 = poscil(kA4 * kF4, kF4 + a5)
    a3 = poscil(kA3, kF3 + a4)

    aY  = (a1 + a3)/2
    elseif(iMode = 3) then
      a3 = poscil(kA3 * kF3, kF3)
      a2 = poscil(kA2 * kF2, kF2 + a3)
      a1 = poscil(kA1, kF1 + a2)

      a6f init 0
      a6 = poscil(kA6, kF6 + a6f)
      a6f = a6 * iFb
      a5 = poscil(kA5 * kF5, kF5 + a6)
      a4 = poscil(kA4, kF4 + a5)

      aY = (a1 + a4)/2
      elseif(iMode = 4) then
        a3 = poscil(kA3 * kF3, kF3)
        a2 = poscil(kA2 * kF2, kF2 + a3)
        a1 = poscil(kA1, kF1 + a2)

        a4f init 0
        a6 = poscil(kA6 * kF6, kF6 + (a4f * kF4))
        a5 = poscil(kA5 * kF5, kF5 + a6)
        a4 = poscil(kA4, kF4 + a5)
        a4f = a4 * iFb

        aY = (a1 + a4)/2
        elseif(iMode = 5) then
          a2 = poscil(kA2 * kF2, kF2)
          a1 = poscil(kA1, kF1 + a2)

          a4 = poscil(kA4 * kF4, kF4)
          a3 = poscil(kA3, kF3 + a4)

          a6f init 0
          a6 = poscil(kA6, kF6 + a6f)
          a6f = a6 * iFb
          a5 = poscil(kA5, kF5 + a6)

          aY = (a1 + a3 + a5)/3
          elseif(iMode = 6) then
            a2 = poscil(kA2 * kF2, kF2)
            a1 = poscil(kA1, kF1 + a2)

            a4 = poscil(kA4 * kF4, kF4)
            a3 = poscil(kA3, kF3 + a4)

            a5f init 0
            a6 = poscil(kA6 * kF6, kF6 + (a5f * kF5))
            a5 = poscil(kA5, kF5 + a6)
            a5f = a5 * iFb

            aY = (a1 + a3 + a5)/3
            elseif(iMode = 7) then
              a2 = poscil(kA2 * kF2, kF2)
              a1 = poscil(kA1, kF1 + a2)

              a6f init 0
              a6 = poscil(kA6, kF6 + a6f)
              a6f = a6 * iFb
              a5 = poscil(kA5 * kF5, kF5 + a6)
              a4 = poscil(kA4 * kF4, kF4)
              a3 = poscil(kA3, kF3 + (a4 + a5))

              aY = (a1 + a3)/2
              elseif(iMode = 8) then
                a2 = poscil(kA2 * kF2, kF2)
                a1 = poscil(kA1, kF1 + a2)

                a4f init 0
                a6 = poscil(kA6 * kF6, kF6)
                a5 = poscil(kA5 * kF5, kF5 + a6)
                a4 = poscil(kA4, kF4 + a4f)
                a4f = a4 * iFb
                a3 = poscil(kA3, kF3 + (a4 + a5))

                aY = (a1 + a3)/2
                elseif(iMode = 9) then
                  a2f init 0
                  a2 = poscil(kA2, kF2 + a2f)
                  a2f = a2 * iFb
                  a1 = poscil(kA1, kF1 + a2)

                  a6 = poscil(kA6 * kF6, kF6)
                  a5 = poscil(kA5 * kF5, kF5 + a6)
                  a4 = poscil(kA4 * kF4, kF4)
                  a3 = poscil(kA3, kF3 + (a4 + a5))

                  aY = (a1 + a3)/2
                  elseif(iMode = 10) then
                    a3f init 0
                    a3 = poscil(kA3, kF3 + a3f)
                    a3f = a3 * iFb
                    a2 = poscil(kA2 * kF2, kF2 + a3)
                    a1 = poscil(kA1, kF1 + a2)

                    a6 = poscil(kA6 * kF6, kF6)
                    a5 = poscil(kA5 * kF5, kF5)
                    a4 = poscil(kA4, kF4 + (a6 + a5))

                    aY = (a1 + a4)/2
                    elseif(iMode = 11) then
                      a3 = poscil(kA3 * kF3, kF3)
                      a2 = poscil(kA2 * kF2, kF2 + a3)
                      a1 = poscil(kA1, kF1 + a2)

                      a6f init 0
                      a6 = poscil(kA6, kF6 + a6f)
                      a6f = a6 * iFb
                      a5 = poscil(kA5 * kF5, kF5)
                      a4 = poscil(kA4, kF4 + (a6 + a5))

                      aY = (a1 + a4)/2
                      elseif(iMode = 12) then
                        a2f init 0
                        a2 = poscil(kA2, kF2 + a2f)
                        a2f = a2 * iFb
                        a1 = poscil(kA1, kF1 + a2)

                        a6 = poscil(kA6 * kF6, kF6)
                        a5 = poscil(kA5 * kF5, kF5)
                        a4 = poscil(kA4 * kF4, kF4)
                        a3 = poscil(kA3, kF3 + (a4 + a5 + a6))

                        aY = (a1 + a3)/2
                        elseif(iMode = 13) then
                          a2 = poscil(kA2 * kF2, kF2)
                          a1 = poscil(kA1, kF1 + a2)

                          a6f init 0
                          a6 = poscil(kA6, kF6 + a6f)
                          a6f = a6 * iFb
                          a5 = poscil(kA5 * kF5, kF5)
                          a4 = poscil(kA4 * kF4, kF4)
                          a3 = poscil(kA3, kF3 + (a4 + a5 + a6))

                          aY = (a1 + a3)/2
                          elseif(iMode = 14) then
                            a2 = poscil(kA2 * kF2, kF2)
                            a1 = poscil(kA1, kF1 + a2)

                            a6f init 0
                            a6 = poscil(kA6, kF6 + a6f)
                            a6f = a6 * iFb
                            a5 = poscil(kA5 * kF5, kF5)
                            a4 = poscil(kA4 * kF4, kF4 + (a6 + a5))
                            a3 = poscil(kA3, kF3 + a4)

                            aY =(a1 + a3)/2
                            elseif(iMode = 15) then
                              a2f init 0
                              a2 = poscil(kA2, kF2 + a2f)
                              a2f = a2 * iFb
                              a1 = poscil(kA1, kF1 + a2)

                              a6 = poscil(kA6 * kF6, kF6)
                              a5 = poscil(kA5 * kF5, kF5)
                              a4 = poscil(kA4 * kF4, kF4 + (a6 + a5))

                              aY = (a1 + a4)/2
                              elseif(iMode = 16) then
                                a2 = poscil(kA2 * kF2, kF2)

                                a4 = poscil(kA4 * kF4, kF4)
                                a3 = poscil(kA3 * kF3, kF3 + a4)

                                a6f init 0
                                a6 = poscil(kA6, kF6 + a6f)
                                a6f = a6 * iFb
                                a5 = poscil(kA5 * kF5, kF5 + a6)

                                a1 = poscil(kA1, kF1 + (a2 + a3 + a5))

                                aY = (a1)
                                elseif(iMode = 17) then
                                  a2f init 0
                                  a2 = poscil(kA2, kF2 + a2f)
                                  a2f = a2 * iFb

                                  a4 = poscil(kA4 * kF4, kF4)
                                  a3 = poscil(kA3 * kF3, kF3 + a4)

                                  a6 = poscil(kA6 * kF6, kF6)
                                  a5 = poscil(kA5 * kF5, kF5 + a6)

                                  a1 = poscil(kA1, kF1 + (a2 + a3 + a5))

                                  aY = (a1)
                                  elseif(iMode = 18) then
                                    a2 = poscil(kA2 * kF2, kF2)

                                    a3f init 0
                                    a3 = poscil(kA3, kF3 + a3f)
                                    a3f = a3 * iFb

                                    a6 = poscil(kA6 * kF6, kF6)
                                    a5 = poscil(kA5 * kF5, kF5 + a6)
                                    a4 = poscil(kA4 * kF4, kF4 + a5)

                                    a1 = poscil(kA1, kF1 + (a2 + a3 + a4))

                                    aY = (a1)
                                    elseif(iMode = 19) then
                                      a3 = poscil(kA3 * kF3, kF3)
                                      a2 = poscil(kA2 * kF2, kF2 + a3)
                                      a1 = poscil(kA1, kF1 + a2)

                                      a6f init 0
                                      a6 = poscil(kA6, kF6 + a6f)
                                      a6f = a6 * iFb
                                      a5 = poscil(kA5, kF5 + a6)
                                      a4 = poscil(kA4, kF4 + a6)

                                      aY = (a1 + a4 + a5)/3
                                      elseif(iMode = 20) then
                                        a3f init 0
                                        a3 = poscil(kA3, kF3 + a3f)
                                        a3f = a3 * iFb
                                        a2 = poscil(kA2, kF2 + a3)
                                        a1 = poscil(kA1, kF1 + a3)

                                        a6 = poscil(kA6 * kF6, kF6)
                                        a5 = poscil(kA5 * kF5, kF5)
                                        a4 = poscil(kA4, kF4 + (a5 + a6))

                                        aY = (a1 + a2 + a4)/3
                                        elseif(iMode = 21) then
                                          a3f init 0
                                          a3 = poscil(kA3, kF3 + a3f)
                                          a3f = a3 * iFb
                                          a2 = poscil(kA2, kF2 + a3)
                                          a1 = poscil(kA1, kF1 + a3)

                                          a6 = poscil(kA6 * kF6, kF6)
                                          a5 = poscil(kA5, kF5 + a6)
                                          a4 = poscil(kA4, kF4 + a6)

                                          aY = (a1 + a2 + a4 + a5)/4
                                          elseif(iMode = 22) then
                                            a2 = poscil(kA2 * kF2, kF2)
                                            a1 = poscil(kA1, kF1 + a2)

                                            a6f init 0
                                            a6 = poscil(kA6, kF6 + a6f)
                                            a6f = a6 * iFb
                                            a3 = poscil(kA3, kF3 + a6)
                                            a4 = poscil(kA4, kF4 + a6)
                                            a5 = poscil(kA5, kF5 + a6)

                                            aY = (a1 + a3 + a4 + a5)/4
                                            elseif(iMode = 23) then
                                              a1 = poscil(kA1, kF1)

                                              a3 = poscil(kA3 * kF3, kF3)
                                              a2 = poscil(kA2, kF2 + a3)

                                              a6f init 0
                                              a6 = poscil(kA6, kF6 + a6f)
                                              a6f = a6 * iFb
                                              a5 = poscil(kA5, kF5 + a6)
                                              a4 = poscil(kA4, kF4 + a6)

                                              aY = (a1 + a2 + a4 + a5)/4
                                              elseif(iMode = 24) then
                                                a1 = poscil(kA1, kF1)

                                                a2 = poscil(kA2, kF2)

                                                a6f init 0
                                                a6 = poscil(kA6, kF6 + a6f)
                                                a6f = a6 * iFb
                                                a5 = poscil(kA5, kF5 + a6)
                                                a4 = poscil(kA4, kF4 + a6)
                                                a3 = poscil(kA3, kF3 + a6)

                                                aY = (a1 + a2 + a3 + a4 + a5)/5
                                                elseif(iMode = 25) then
                                                  a1 = poscil(kA1, kF1)

                                                  a2 = poscil(kA2, kF2)

                                                  a3 = poscil(kA3, kF3)

                                                  a6f init 0
                                                  a6 = poscil(kA6, kF6 + a6f)
                                                  a6f = a6 * iFb
                                                  a5 = poscil(kA5, kF5 + a6)
                                                  a4 = poscil(kA4, kF4 + a6)

                                                  aY = (a1 + a2 + a3 + a4 + a5)/5
                                                  elseif(iMode = 26) then
                                                    a1 = poscil(kA1, kF1)

                                                    a3 = poscil(kA3 * kF3, kF3)
                                                    a2 = poscil(kA2, kF2 + a3)

                                                    a6f init 0
                                                    a6 = poscil(kA6, kF6 + a6f)
                                                    a6f = a6 * iFb
                                                    a5 = poscil(kA5 * kF5, kF5)
                                                    a4 = poscil(kA4, kF4 + (a5 + a6))

                                                    aY = (a1 + a2 + a4)/3
                                                    elseif(iMode = 27) then
                                                      a1 = poscil(kA1, kF1)

                                                      a3f init 0
                                                      a3 = poscil(kA3, kF3 + a3f)
                                                      a3f = a3 * iFb
                                                      a2 = poscil(kA2, kF2 + a3)

                                                      a6 = poscil(kA6 * kF6, kF6)
                                                      a5 = poscil(kA5 * kF5, kF5)
                                                      a4 = poscil(kA4, kF4 + (a5 + a6))

                                                      aY = (a1 + a2 + a4)/3
                                                      elseif(iMode = 28) then
                                                        a2 = poscil(kA2 * kF2, kF2)
                                                        a1 = poscil(kA1, kF1 + a2)

                                                        a5f init 0
                                                        a5 = poscil(kA5, kF5 + a5f)
                                                        a5f = a5 * iFb
                                                        a4 = poscil(kA4 * kF4, kF4 + a5)
                                                        a3 = poscil(kA3 * kF3, kF3 + a4)

                                                        a6 = poscil(kA6, kF6)

                                                        aY = (a1 + a3 + a6)/3
                                                        elseif(iMode = 29) then
                                                          a1 = poscil(kA1, kF1)

                                                          a2 = poscil(kA2, kF2)

                                                          a4 = poscil(kA4 * kF4, kF4)
                                                          a3 = poscil(kA3, kF3 + a4)

                                                          a6f init 0
                                                          a6 = poscil(kA6, kF6 + a6f)
                                                          a6f = a6 * iFb
                                                          a5 = poscil(kA5, kF5 + a6)


                                                          aY = (a1 + a2 + a3 + a5)/4
                                                          elseif(iMode = 30) then
                                                            a1 = poscil(kA1, kF1)

                                                            a2 = poscil(kA2, kF2)

                                                            a5f init 0
                                                            a5 = poscil(kA5, kF5 + a5f)
                                                            a5f = a5 * iFb
                                                            a4 = poscil(kA4 * kF4, kF4 + a5)
                                                            a3 = poscil(kA3, kF3 + a4)

                                                            a6 = poscil(kA6, kF6)

                                                            aY = (a1 + a2 + a3 + a6)/4
                                                            elseif(iMode = 31) then
                                                              a1 = poscil(kA1, kF1)

                                                              a2 = poscil(kA2, kF2)

                                                              a6f init 0
                                                              a6 = poscil(kA6, kF6 + a6f)
                                                              a6f = a6 * iFb
                                                              a5 = poscil(kA5, kF5 + a6)
                                                              a4 = poscil(kA4, kF4)
                                                              a3 = poscil(kA3, kF3)

                                                              aY = (a1 + a2 + a3 + a4 + a5)/5
                                                              elseif(iMode = 32) then
                                                                a1 = poscil(kA1, kF1)

                                                                a2 = poscil(kA2, kF2)

                                                                a3 = poscil(kA3, kF3)

                                                                a4 = poscil(kA4, kF4)

                                                                a5 = poscil(kA5, kF5)

                                                                a6f init 0
                                                                a6 = poscil(kA6, kF6 + a6f)
                                                                a6f = a6 * iFb

                                                                aY = (a1 + a2 + a3 + a4 + a5 + a6)/6
                                                              endif

xout(aY)
  endop



  instr DX7

kInv = linseg(0, p3/2, 1, .5, 0)

a1 = DX7(220, .9 * kInv, 221, .5 * kInv, 110, .3 * kInv, 224, .9 * kInv, 50, .7 * kInv, 227, .7 * kInv, 1, 4)

  outs(a1, a1)

  endin



</CsInstruments>
<CsScore>

;i "DX7" 0 10

</CsScore>
</CsoundSynthesizer>
