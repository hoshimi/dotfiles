hist(x, width) = floor(x/width)*width + width/2
Re = 1.60217662e-19
Rme = 9.1093835e-31
Rkb = 1.38064852e-23
velo_to_ev(v) = Rme * (v**2)/(2*Re)
ev_to_velo(ev) = sqrt(2*ev*Re/Rme)
maxwellian_abs(v, ev) = 4 * pi * (v**2) * ((Rme/(2*pi*ev*Re))**(3/2)) * exp(-Rme*v*v/(2*ev*Re))
drift_maxwellian(v, ev, vd) = ((Rme/(2*pi*ev*Re))**(1/2)) * exp(-Rme*((v-ev_to_velo(vd))**2)/(2*ev*Re))
drift_maxwellian_abs(v, ev, vd) = 4 * pi * ((v - ev_to_velo(vd))**2) * ((Rme/(2*pi*ev*Re))**(3/2)) * exp(-Rme*((v - ev_to_velo(vd))**2)/(2*ev*Re))
set grid
set terminal aqua font "Arial, 18"
