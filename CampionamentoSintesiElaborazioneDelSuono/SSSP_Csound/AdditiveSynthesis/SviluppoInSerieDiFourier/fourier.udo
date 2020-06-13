    opcode func2coeff, kk[]k[], k[]i
kfunc[], inumForm xin

/*
cacolo dei coefficienti di Fourier
kfunc[] = funzione
inumForm = numero totale dei coefficienti da calcolare
*/

i2pi = 2 * $M_PI
iT = lenarray(kfunc)
ifac = 1/(iT * 0.5)

ka0 init 0
kak[] init inumForm
kbk[] init inumForm

ki init 0
if(ki < inumForm) then
    kca0 = 0
    kcak = 0
    kcbk = 0
    kj = 0
    while (kj < iT) do
        kphi = (ki * i2pi * kj/(iT - 1))
        kca0 += kfunc[kj] //calcolo componente continua
        kcak += kfunc[kj] * cos(kphi) //calcolo ak
        kcbk += kfunc[kj] * sin(kphi) //calcolo bk

        kj += 1
    od

    ka0 = kca0 * ifac
    kak[ki] = kcak * ifac
    kbk[ki] = kcbk * ifac

    printf("[a0 %d = %f]\t[ak %d = %f]\t[bk %d = %f]\n", ki + 1, ki, ka0, ki, kak[ki], ki, kbk[ki])

    ki += 1
endif

xout(ka0, kak, kbk)
    endop

    opcode coeff2sig, a, kk[]k[]ko
ka0, kak[], kbk[], kfond, ii xin

/*
banco di oscillatori su base Fourier accetta in entrata coefficienti e frequenza fondamentale
ka0 = valore medio
kak[] = coefficienti coseno
kbk[] = coefficienti seno
kfond = frequenza fondamentale
*/

iN = lenarray(kak) - 1
i2pi = 2 * $M_PI
kphi = phasor:k(kfond * ii) * i2pi
asig = ((kak[ii] * cos(kphi)) + (kbk[ii] * sin(kphi))) * (1/sqrt(2))

if(ii < iN) then
    aa = coeff2sig(ka0, kak, kbk, kfond, ii + 1)
endif

aout = (ka0/2) + (asig + aa)
xout(aout)
    endop
