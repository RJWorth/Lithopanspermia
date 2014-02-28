### Get min and max of an array for limits of plotting
GetLimits <- function(x){
	return(c(min(x, na.rm=T), max(x[x<Inf], na.rm=T)))
}
###############################################################################
### function to automate some of plot
DoPlot <- function(x,y, xlabel='Collision Rate',ylabel='test', l='')	{	
	if (x[1]!=coll[1] | is.na(x[1])) {
		vers=2
		xl=GetLimits(x)
		yl=c(min(0.5*lim),max(y,na.rm=T))
	} else {
		vers=1
		xl=c(min(0.5*lim),max(x,na.rm=T)) 
		yl=GetLimits(y)	}
	plot( xlim=xl,ylim=yl, xlab=xlabel,ylab=ylabel, log=l, type='n', 1)
for (i in 1:2) {points(col=cols[i,],pch=sym[i,], x[i,],y[i,])
	if (vers==1)	{
	arrows(rep(    lim[i],sum(x[i,]==0.)), y[i,x[i,]==0],
		   rep(0.5*lim[i],sum(x[i,]==0.)), y[i,x[i,]==0],
		col=cols[i,],length=0.025)
	} else {
	arrows(x[i,y[i,]==0], rep(    lim[i],sum(y[i,]==0.)), 
		   x[i,y[i,]==0], rep(0.5*lim[i],sum(y[i,]==0.)), 
		col=cols[i,],length=0.025)
	}	}	}	# if, for, f'n

###############################################################################
### Compare cross sections, etc, to collision rates for planets

### constants
G=6.67398e-8	#cgs
### Read in physical stats on planets
planets=read.table('planets.txt',header=T)
colnames(planets)=c('mass','a','mcen','acen','r')
rnames=rownames(planets)
attach(planets)
ind=c(2:5,7:8)
ind2=c(2:5,7:8,10)

# Collision rates
coll=rbind(c(earth.per[2:8],0.,0.,earth.per[9]),c( mars.per[2:8],0.,0., mars.per[9]))/100
	colnames(coll)=rnames
	rownames(coll)=c('Earth','Mars')
collimits=c(min(0.5*lim),max(y,na.rm=T))

# Various physical parameters
RH=a*(mass/(3*mcen))^(1/3)			#Hill radius of object (cm)
da=abs(rbind(a-a[4], a-a[5]))
	da[1,4]=RH[4]
	da[2,5]=RH[5]
dist=rbind(abs(a-a[4]),abs(a-a[5]))						# dist of dest from ejection location
	dist[1,4]=RH[4]				# distance from origin planet
	dist[2,5]=RH[5]
	colnames(dist)=rnames
	rownames(dist)=c('Earth','Mars')
##RHcent=c(1, rep(RH[1],4), 1, rep(RH[6],2),1, RH[9])	# RH of central obj
##RHratio=a/RHcent					#a in units of planet's RH
vorb=sqrt(G*mcen/a)/1e5				#orbital velocity (km/s)
vesc=sqrt(2*G*mass/r)/1e5			#escape velocity (km/s)
vesccen=sqrt(2*G*mcen/a)/1e5			# esc vel of central object

SA=4*pi*r^2						# Planet's surface area
##SAratio=c(1, SA[2:5]/SA[1], 1, SA[7:8]/SA[6],1, SA[10]/SA[9])

venc=vorb							#encounter velocity?
Fg=1+(vesc/venc)^2					#Gravitational focusing factor
##Fgratio=c(1,Fg[2:5]/Fg[1],Fg[6], Fg[7:8]/Fg[6], Fg[9], Fg[10]/Fg[9] )

### Area of sky sphere at dest's distance from ejection location
sky=rbind(4*pi*dist[1,]^2, 4*pi*dist[2,]^2)
	colnames(sky)=rnames
	rownames(sky)=c('Earth','Mars')
### SA and Hill radius cross section area as fraction of sky at ejection
SASkyFrac=rbind(SA,SA)/sky
	SASkyFrac[,10]=c(1.,1.)
	colnames(SASkyFrac)=rnames
	rownames(SASkyFrac)=c('Earth','Mars')
RHSkyFrac=pi*rbind(RH,RH)^2/sky
	RHSkyFrac[,10]=c(1.,1.)
	colnames(RHSkyFrac)=rnames
	rownames(RHSkyFrac)=c('Earth','Mars')

### Sun's grav. potential at each planet's orbit
V=G*mcen/a
### Grav. potential relative to at origin
Vrel=rbind(V/V[4],V/V[5])

### Object's grav potential at its surface
U=G*mass/r

planets=rbind(cbind(mass,a,r,RH,Fg,SASkyFrac[1,],RHSkyFrac[1,],Vrel[1,],coll[1,]),
	cbind(mass,a,r,RH,Fg,SASkyFrac[2,],RHSkyFrac[2,],Vrel[2,],coll[2,]))
rownames(planets)=c(rnames,rnames)
colnames(planets)=c('mass','a','r','RH','Fg','SASkyFrac','RHSkyFrac','Vrel','coll')
print(planets)

###############################################################################

##### Plotting aids
lim=rbind(1/earth.num[length(earth.num)], 1/ mars.num[length( mars.num)])
coll2=coll
	coll2[1,coll2[1,]==0]=lim[1]
	coll2[2,coll2[2,]==0]=lim[2]
#cols=rep('black',6)
sym=rbind(c('s','m','V','E','M','J','S','U','N','j'),c('s','m','V','E','M','J','S','U','N','j'))
cols=rbind(rep('blue',10),rep('red',10))

###############################################################################
pdf('Output/PlanetRatioComponents.pdf')	#,height=1.5*p,width=p)
par(mfrow=c(3,2))

### 
y=1/da
ylabel='1/da'
xlabel='Collision Rate'
DoPlot(coll,y, xlabel,ylabel, 'xy')

### 
y=rbind(1/a,1/a)
ylabel='1/a'
DoPlot(coll,y, xlabel,ylabel, 'xy')

### 
y=rbind(1/Fg,1/Fg)
ylabel='Fg'
DoPlot(coll,y, xlabel,ylabel, 'xy')

### 
y=Vrel
ylabel='V'
DoPlot(coll,y, xlabel,ylabel, 'xy')

### 
y=SASkyFrac
ylabel='SA'
DoPlot(coll,y, xlabel,ylabel, 'xy')

### 
y=RHSkyFrac
ylabel='RH'
DoPlot(coll,y, xlabel,ylabel, 'xy')


dev.off()

###############################################################################
### Combine components into possible correlations
pdf('Output/PlanetRatioCorrelations.pdf',height=p,width=p)
par(mfrow=c(2,2))

n=1
m=1
o=1
q=1
x=SASkyFrac^n*Vrel^m/(a^o*da^p)
ylabel='Collision Rate'
xlabel='SA*V^2'
DoPlot(x,coll, xlabel,ylabel, 'xy')

###
n=1
m=2
o=1
q=1
x=SASkyFrac^n*Vrel^m/(a^o*da^p)
xlabel='SA/(a*da^2)'
DoPlot(x,coll, xlabel,ylabel, 'xy')

###
n=1
m=1
o=2
q=1
x=SASkyFrac^n*Vrel^m/(a^o*da^p)
xlabel='SA*Vrel/(a*da^2)'
DoPlot(x,coll, xlabel,ylabel, 'xy')

###
n=1
m=1
o=1
q=2
x=SASkyFrac^n*Vrel^m/(a^o*da^p)
xlabel='SA*Vrel^2/(a*da^2)'
DoPlot(x,coll, xlabel,ylabel, 'xy')

dev.off()
###############################################################################
### Ideas
# function to fit line to x for array of V exponents, find best fit
# then fit to best SASkyFrac exponent, then repeat
# use lower limits instead of 0s?
# Fit with lm and various exponents using weights,
# "Non-NULL weights can be used to indicate that different observations have different variances (with the values in weights being inversely proportional to the variances); or equivalently, when the elements of weights are positive integers w_i, that each response y_i is the mean of w_i unit-weight observations (including the case that there are w_i observations equal to y_i and the data have been summarized)."

### Function to get goodness of fit for input array of exponents
DoFit <- function(n,m,o,q){
	x = SASkyFrac^ind[i,1] * Vrel^ind[i,2] * a^ind[i,3] * da^ind[i,4]
	DoPlot(log(x),log(coll2), 'fit','coll','')
	fit=lm(as.vector(log(coll2))~as.vector(log(x)))
	abline(fit)
	return((abs(fit$residuals)))
	}
par(mfrow=c(3,4))
ind=expand.grid(1,1,1,0:-10)
residuals = mat.or.vec(dim(ind)[1], 20)
for (i in 1:dim(ind)[1])	{
	residuals[i,]=DoFit(ind[i,])
		}


### fitting coll~Vrel
#x=Vrel
#y=coll
#in.e=1:4
#in.m=1:5
#out.e=4:10
#out.m=5:10
#x.in=Vrel[1,in.e]
#y.in=coll[1,in.e]
#x.out=Vrel[2,in.m]
#y.out=coll[2,in.m]

#lm(y.in~x.in)
#DoPlot(x,y, xlabel='relative V',ylabel='Collision Rate', l='xy')




###############################################################################

#x=Fgratio[ind]*RH[ind]/a[ind]^2
#fitx=lm((collratio[ind]/1e-5)~x)

###############################################################################
### Plot correlation
#for (i in 1:2)	{
#if (i==1) pdf(paste('Output/Worth-Fig2b',prefix,'.pdf',sep=''),width=c,height=c)
#if (i==2) postscript(paste('Output/Worth-Fig2b',prefix,'.eps',sep=''),
#	onefile=FALSE,horizontal=FALSE, width=c, height=c)
#par(mar=c(5,3.3,1,1))
#options(scipen=-1)
#plot(x, collratio[ind]/1e-5, col='white',
#	xlab='', ylab='', main='',
#	xlim=c(.5e-14,3e-14),ylim=c(1,15)
#	)
#abline(fitx)
##abline(v=Fgratio[10]*RH[10]/a[10]^2, col='forestgreen')
#points(x, collratio[ind]/1e-5, col=cols, pch=19, cex=1.5, cex.lab=.7)
#points(x, collratio[ind]/1e-5, col='white', pch=sym,cex=.7)
#mtext(1,text=expression(frac(F[gm],F[gp])%*%frac(R[H],a^2)), line=4)
#mtext(2,text=expression(paste("Collision Ratio (x",10^{-5} ,")")), line=2)
#dev.off()	}
###############################################################################
### Plot non-correlation
#for (i in 1:2)	{
#if (i==1) pdf(paste('Output/Worth-Fig2a',prefix,'.pdf',sep=''),width=c,height=c)
#if (i==2) postscript(paste('Output/Worth-Fig2a',prefix,'.eps',sep=''),
#	onefile=FALSE,horizontal=FALSE, width=c, height=c)
#par(mar=c(5,3.3,1,1))
#options(scipen=-1)
#plot(SAratio[ind]*Fgratio[ind]/1e-5, collratio[ind]/1e-5, col='white',
#	xlab='', ylab='', main='',
#	xlim=c(0,15),ylim=c(1,14)
#	)
#abline(0,1)
##abline(v=SAratio[10]*Fgratio[10]/1e-5, col='forestgreen')
#points(SAratio[ind]*Fgratio[ind]/1e-5, collratio[ind]/1e-5, 
#	col=cols, pch=19, cex=1.5, cex.lab=.7)
#points(SAratio[ind]*Fgratio[ind]/1e-5, collratio[ind]/1e-5, 
#	col='white', pch=sym,cex=.7)
#mtext(1,text=expression(
#	paste(frac(A[m],A[p])%*%frac(F[gm],F[gp])," (x",10^{-5} ,")") ), line=4)
#mtext(2,text=expression(paste("Collision Ratio (x",10^{-5} ,")")), line=2)
#dev.off()	}
##################################################################
detach(planets)
par(mfrow=c(1,1))
options(scipen=0)

