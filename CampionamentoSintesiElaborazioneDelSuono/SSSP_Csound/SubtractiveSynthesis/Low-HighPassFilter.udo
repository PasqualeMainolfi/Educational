  opcode LowPass, a, ak

      /*
      LOW PASS FILTER (IIR)

      y[n] = b0 x[n] + a1 y[n - 1] ---> Hz = b0 / 1 - a1 z^-1 ---> |H(w)| = 1 / sqrt(1 + (w / wTaglio)^2)

      b = 2 - cos[2π (fTaglio / sr)]
      a1 = b - sqrt(b^2 - 1)
      b0 = 1 - a1
      */

aX, kFreqCut xin

/*
aX = sig in
kFreqCut = cut-off frequency in Hz
*/

aY_1 init 0

i2_Pi = 2 * $M_PI

kb = 2 - cos(i2_Pi * (kFreqCut / sr))
ka1 = kb - (sqrt((kb^2) - 1.0))
kb0 = 1 - ka1

aY_n = kb0 * aX + ka1 * aY_1
aY_1 = aY_n

xout aY_n
  endop



  opcode HighPass, a, ak

      /*
      HIGH PASS FILTER (IIR)
      y[n] = (1 - a) / 2 * [x[n] - x[n - 1] + y[n - 1]] ---> H(z) = (1 - a) / 2 * [(1 - z^-1) / (1 + az^-1)] ---> |H(w)| = 1 / sqrt(1 + (wTaglio / w)^2)

      b = 2 - cos(2π * (fTaglio / sr))
      a1 = b - (sqrt((b^2) - 1))
      b0 = 1 - a1
      */

aX, kFreqCut xin

/*
aX = sig in
kFreqCut = cut-off frequency in Hz
*/

aX_1 = delay1(aX)
aY_1 init 0

i2_Pi = 2 * $M_PI

kb = 2 - cos(i2_Pi * (kFreqCut/sr))
ka1 = kb - (sqrt((kb^2) - 1.0))
kb0 = 1 - ka1

aY_n = (kb0 / 2) * (aX - aX_1 + (ka1 * aY_1))
aY_1 = aY_n

xout aY_n
    endop


    opcode DC_Block, a, a

        /*
        DC BLOCK
        y[n] = x[n] - x[n - 1] + (1 - a)y[n - 1]

        a = .905 ca.
        */

aX xin

/*
aX = sig in
*/

aX_1 = delay1(aX)
aY_1 init 0

ia = .905
aY_n = ((1 - ia) / 2) * (aX - aX_1 + ((1 - ia) * aY_1))
aY_1 = aY_n

xout aY_n
      endop
