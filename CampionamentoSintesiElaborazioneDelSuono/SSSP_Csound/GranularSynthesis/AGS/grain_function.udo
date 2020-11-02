opcode map, i, iiiii
    iin, iout_min, iout_max, iin_min, iin_max xin
    iy = ((iin - iin_min) * (iout_max - iout_min))/(iin_max - iin_min)
    iy += iout_min
xout(iy)
endop

opcode w_hann, k, ki
    kx, ilen xin
    i2pi = 2 * $M_PI
    kw = 0.5 * (1 - cos((i2pi * kx)/ilen - 1))
xout(kw)
endop

opcode w_coseno, k, ki
    kx, ilen xin
    ipi = $M_PI
    kw = cos(((ipi * kx)/(ilen - 1)) - (ipi/2))
xout(kw)
endop


opcode open_file, i, S
    Sfile xin
    ifile = ftgen(0, 0, 0, 1, Sfile, 0, 0, 0)
xout(ifile)
endop

opcode live_input, i, ii
    ibuffer, ichn xin
    setksmps(1)
    ilive = ftgen(0, 0, ibuffer, 2, 0)
    ain = inch(ichn)
    ki init 0
    if(ki < ibuffer) then
        tablew(ain, a(ki), ilive)
        ki += 1
        ki = ki%ibuffer
    endif
xout(ilive)
endop
