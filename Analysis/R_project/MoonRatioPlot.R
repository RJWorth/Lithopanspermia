#source('ReadMoons.R')

Jnum=c( sum(Jcollisions['Ju']), sum(Jcollisions['Io']),sum(Jcollisions['Eu']),sum(Jcollisions['Ga']),sum(Jcollisions['Ca']) )
#colnames(Jnum)=c('Jupiter','Io','Europa','Ganymede','Callisto')
Snum=colSums(Stally)


### Looking at collision rate trends
G=6.67398e-8	#cgs

moons=read.table('moons.txt',header=T)
attach(moons)
ind=c(2:5,7:8)
ind2=c(2:5,7:8,10)

coll=c( Jnum, Snum )
collratio=c(1, coll[2:5]/coll[1], 1, coll[7:8]/coll[6], 1,1 )
RH=a*(mass/(3*mcen))^(1/3)			#Hill radius of object (cm)
RHcent=c(1, rep(RH[1],4), 1, rep(RH[6],2),1, RH[9])	# RH of central obj
RHratio=a/RHcent					#a in units of planet's RH
vorb=sqrt(G*mcen/a)/1e5				#orbital velocity (km/s)
vesc=sqrt(2*G*mass/r)/1e5			#escape velocity (km/s)
vesccen=sqrt(2*G*mcen/a)/1e5		# esc vel of central object

SA=4*pi*r^2
SAratio=c(1, SA[2:5]/SA[1], 1, SA[7:8]/SA[6],1, SA[10]/SA[9])

venc=c(vorb[1],vorb[1],vorb[1],vorb[1],vorb[1],vorb[6],vorb[6],vorb[6],
	vorb[9],vorb[9])	#encounter velocity?
Fg=1+(vesc/venc)^2					#Gravitational focusing factor
Fgratio=c(1,Fg[2:5]/Fg[1],Fg[6], Fg[7:8]/Fg[6], Fg[9], Fg[10]/Fg[9] )

#moons=cbind(collratio,mass,a,r,RH,RHratio,Fg,Fgratio)
#print(moons)

##### Plotting aids
#cols=c(rep('red',4),rep('steelblue',2))
cols=rep('black',6)
sym=c('I','E','G','C','N','T','T')

x=Fgratio[ind]*RH[ind]/a[ind]^2
fitx=lm((collratio[ind]/1e-5)~x)

##################################################################
# Plot correlation
for (i in 1:2)	{
if (i==1) pdf(paste('Output/Worth-Fig2b',prefix,'.pdf',sep=''),width=c,height=c)
if (i==2) postscript(paste('Output/Worth-Fig2b',prefix,'.eps',sep=''),
	onefile=FALSE,horizontal=FALSE, width=c, height=c)
par(mar=c(5,3.3,1,1))
options(scipen=-1)
plot(x, collratio[ind]/1e-5, col='white',
	xlab='', ylab='', main='',
	xlim=c(.5e-14,3e-14),ylim=c(1,15)
	)
abline(fitx)
#abline(v=Fgratio[10]*RH[10]/a[10]^2, col='forestgreen')
points(x, collratio[ind]/1e-5, col=cols, pch=19, cex=1.5, cex.lab=.7)
points(x, collratio[ind]/1e-5, col='white', pch=sym,cex=.7)
mtext(1,text=expression(frac(F[gm],F[gp])%*%frac(R[H],a^2)), line=4)
mtext(2,text=expression(paste("Collision Ratio (x",10^{-5} ,")")), line=2)
dev.off()	}
##################################################################
# Plot non-correlation
for (i in 1:2)	{
if (i==1) pdf(paste('Output/Worth-Fig2a',prefix,'.pdf',sep=''),width=c,height=c)
if (i==2) postscript(paste('Output/Worth-Fig2a',prefix,'.eps',sep=''),
	onefile=FALSE,horizontal=FALSE, width=c, height=c)
par(mar=c(5,3.3,1,1))
options(scipen=-1)
plot(SAratio[ind]*Fgratio[ind]/1e-5, collratio[ind]/1e-5, col='white',
	xlab='', ylab='', main='',
	xlim=c(0,15),ylim=c(1,14)
	)
abline(0,1)
#abline(v=SAratio[10]*Fgratio[10]/1e-5, col='forestgreen')
points(SAratio[ind]*Fgratio[ind]/1e-5, collratio[ind]/1e-5, 
	col=cols, pch=19, cex=1.5, cex.lab=.7)
points(SAratio[ind]*Fgratio[ind]/1e-5, collratio[ind]/1e-5, 
	col='white', pch=sym,cex=.7)
mtext(1,text=expression(
	paste(frac(A[m],A[p])%*%frac(F[gm],F[gp])," (x",10^{-5} ,")") ), line=4)
mtext(2,text=expression(paste("Collision Ratio (x",10^{-5} ,")")), line=2)
dev.off()	}
##################################################################
detach(moons)
par(mfrow=c(1,1))
options(scipen=0)

