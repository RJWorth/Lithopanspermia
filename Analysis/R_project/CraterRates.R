


# Impactor diameters
#L=1:50			# km
L=c(1:12,14,16,18,20,30,100)

# Transient crater diameters, Mars
Dt.m=13*L^(.78)	# km
Dt.e=14*L^(.78)	# km

# Final crater diameter 
#Mars
D.m=Dt.m
# Earth
D.e=Dt.e
	D.e[Dt.e>3 & Dt.e<=60]=1.3*Dt.e[Dt.e>3 & Dt.e<=60]
	D.e[Dt.e>120]=1.6*Dt.e[Dt.e>120]

# Mass ejected at < 100C
Mej.m=8.3e8*L^3		# kg
Mej.e=3.6e8*L^3		# ???

# Mean fragment size
l.m=3e-4*L*1000		# m
l.e=7e-5*L*1000

# Number of fragments (not all ejected?)
n.m=2e7
n.e=6e8

mw=9.5 				# Earth basalt
lmax.m=l.m*(mw+3)/2
lmax.e=l.e*(mw+3)/2

llm=2./(mw+3)		# =l/lmax (l=lbar)

# Fraction of fragments >l
source('lFraction.R')	#read in fraction function
Fl=lFraction(l.m,lmax.m,mw)[1]		#same for e and m, for entire vector
F2l=lFraction(2*l.e,lmax.e,mw)[1]	#same for e and m, for entire vector

# Explore distribution of fraction, change with lbar
dummyl=(1:1000)/10
lbar=1
dummyF=lFraction(dummyl,lbar*(mw+3)/2,mw);plot(dummyl,dummyF,pch=20,log='x'); abline(v=3)

nl.m=n.m*Fl
nl.e=n.e*Fl

n2l.m=n.m*F2l
n2l.e=n.e*F2l

# Impacts of size L per planet per 4 Ga (=1/3 of normal)
SA.e=510072000
	SA.e.land=148940000
SA.m=144798500 

RM.m=c(4740, 1724, 468, 216, 120, 30, 25.2, 20.8, 13.6, 9.6, 9.2, 7.2, 11.2, 7.12, 5.28, 4.32,12.4,11.6)
RM.e=c(NA,1590, 628, 108, 68, 36, NA, 12.8, 9.2, 5.6, 6.0, 4.4, 6.8, 4.4, rep(NA,4))
# Fragments >l ejected by this size in 4 Ga
fe.m=nl.m*RM.m
fe.e=nl.e*RM.e

fe2.m=n2l.m*RM.m
fe2.e=n2l.e*RM.e





