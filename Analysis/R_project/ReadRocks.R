

# Read in data and adjust for analysis
here=getwd()
rocks=read.table(file,header=T)

otherdest=rocks[which(rocks$Destination==9 | rocks$Destination==8),]
print(levels(as.factor(rocks$Destination)))
print(levels(as.factor(rocks$Origin)))
if (vers==2) rocks=rocks[-which(rocks$Destination==9),]

# Make Destination and Origin into factors:
rocks$Destination=factor(rocks$Destination,labels=c('Orbit','Sun','Mercury',
	'Venus','Earth','Mars','Jupiter','Saturn','Ejected')) 
rocks$Origin=factor(rocks$Origin, labels=c('Earth','Mars'))

# Earth and Mars escape velocity
vesc2.e=vesc.e*AU/day/10^5	#km/s
vesc2.m=vesc.m*AU/day/10^5	#km/s

# Define initial velocity in terms of escape velocity:
unnormv=rocks$v0*AU/day/10^5
unnormv.e=unnormv[rocks$Origin=='Earth']
unnormv.m=unnormv[rocks$Origin=='Mars']
vinf.e=sqrt(unnormv.e^2-vesc2.e^2)
vinf.m=sqrt(unnormv.m^2-vesc2.m^2)
rocks$v0[rocks$Origin=='Earth']=rocks$v0[rocks$Origin=='Earth']/vesc.e
rocks$v0[rocks$Origin=='Mars']=rocks$v0[rocks$Origin=='Mars']/vesc.m
#normalize theta, phi
Phi1=abs(rocks$Phi)
Theta1=rocks$Theta	#centered on towards Sun
Theta2=rocks$Theta	#Centered on along planet's orbit
Theta1[Theta1>180]=360-Theta1[Theta1>180]
Theta2=abs(Theta2-90)
Theta2[Theta2>180]=360-Theta2[Theta2>180]


AllDest=c('Orbit','Sun','Mercury','Venus','Earth','Mars','Jupiter','Saturn',
	'Uranus','Neptune','Ejected')

destlevels=c('Orbit','Sun','Mercury','Venus','Earth','Mars','Jupiter','Saturn','Ejected')
ndest=nlevels(as.factor(rocks$Destination))	#number of destinations
palette(c('black',rainbow(ndest-2),'gray'))	#set colors

originplanet=function(x) {
	if (x==1) return(c('earth','Earth',1))
	if (x==2) return(c('mars','Mars',2))	}


earthrocks=rocks[rocks$Origin=='Earth',]
marsrocks=rocks[rocks$Origin=='Mars',]

