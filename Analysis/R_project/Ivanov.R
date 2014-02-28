# Ivanov rates

# Crater diameters (km)
D.m=c(1e-3*c(3.9,5.52,7.81,11.0,15.6,22.1,31.2,44.2,
	62.5,88.3,125,176,250,353,500,707),
	1,1.41,2,2.83,4,5.66,8,11.3,16,22.6,32,45.3,64,
	90.5,128,181,256,362,512,723)	#1024 (upper bound)

# Impactor diameters (km)
L=(D.m/13)^(1/.78)

# Mass ejected at < 100C
Mej.m=8.3e8*L^3		# kg
Mej.e=3.6e8*L^3		# ???

# Mean fragment size
l.m=3e-4*L*1000		# m
l.e=7e-5*L*1000

# Number of fragments (not all ejected?)
n.m=2e7
n.e=6e8

# Setup for calculating fraction
mw=9.5 				# Earth basalt
lmax.m=l.m*(mw+3)/2
lmax.e=l.e*(mw+3)/2

llm.m=3/lmax.m		# =(l=3m)/lmax
llm.e=3/lmax.e

# Fraction of fragments > 3m
F.m=(1-llm.m)^mw*(1+
	mw*llm.m+(mw*(mw+1)/2)*llm.m^2+
	(mw*(mw+1)*(mw+2)/6)*llm.m^3)
F.e=(1-llm.e)^mw*(1+
	mw*llm.e+(mw*(mw+1)/2)*(llm.e)^2+
	(mw*(mw+1)*(mw+2)/6)*(llm.e)^3)

F.m[is.na(F.m)]=0
F.e[is.na(F.e)]=0

# Number of fragments per impact > 3m
nl.m=n.m*F.m
nl.e=n.e*F.e

# Surface area of Earth (and just land) and Mars
SA.e=510072000
	SA.e.land=148940000
SA.m=144798500 

# NH=Hartmann production function from Ivanov chapter
# Impacts of size L per km^2 per 4 Ga (with high impact velocity => 1/3 of normal)
# typos in original eighth and twelfth lines? lowered exponent by one
NH.m=c(1.24e4,7.14e3,3.5e3,1.41e3,5.85e2,2.04e2,7.35e1,2.90e1,1.01e1,3.73e0,
	1.34e0,4.51e-1,1.44e-1,4.24e-2,1.23e-2,3.54e-3,9.44e-4,3.93e-4,2.10e-4,
	1.13e-4,6.06e-5,3.25e-5,1.74e-5,9.33e-6,4.98e-6,2.67e-6,1.43e-6,7.35e-7,
	3.42e-7,1.60e-7,7.46e-8,3.48e-8,1.62e-8,7.56e-9,3.53e-9,1.65e-9)
NH.e=(1.68/4.93)*NH.m

# Whole-planet rate
RM.m=SA.m*NH.m
RM.e=SA.e.land*NH.e

#Rate of high-velocity land impacts
RateV.m=SA.m*NH.m/3
RateV.e=SA.e.land*NH.e/3

# Fragments >l ejected by this size in 4 Ga
fe.m=nl.m*RateV.m
fe.e=nl.e*RateV.e

# Plot
plot(L,fe.m, type='l', col='red', log='x')
	lines(L,fe.e, col='blue')


final=cbind(L,RateV.e,round(fe.e),RateV.m,round(fe.m))
colnames(final)=c('Impactor','Impact rate','Viable ejected fragments',
	'Impact rate','Viable ejected fragments')
rownames(final) <- rep("", nrow(final))
final=rbind(final,c(NA,NA,sum(fe.e[RateV.e>=1]),NA,sum(fe.m[RateV.m>=1])))

# Print to file
sink(file='Output/IvanovRates.txt')
options(width=200,scipen=999)
print(final, quotes=F, rownames=F)
sink()
options(width=80,scipen=0)

