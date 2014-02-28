
### Make cumulative probability plots for Earth and Mars

tmax=round(max(rocks$Time))	# length of sim in yrs

# cprob_e, Earth to Mars
e2m=earthrocks[earthrocks$Destination=='Mars',]
e2mv=unnormv.e[earthrocks$Destination=='Mars']
vfactor.e=factor(replicate(length(e2mv),0),levels=c(0,1,2,3))
br.e=min(unnormv.e)+0:3*(max(unnormv.e)-min(unnormv.e))/3
LegLab.e=c(
bquote(v[infinity] %~~% .(signif(mean(br.e[1:2]),2)) ~ km/s),
bquote(v[infinity] %~~% .(signif(mean(br.e[2:3]),2)) ~ km/s),
bquote(v[infinity] %~~% .(signif(mean(br.e[3:4]),2)) ~ km/s),
expression(v[infinity] %~~% signif(mean(br.e[3:4]),2) ~ km/s))


	for (j in 1:length(e2mv)) {
		if(e2mv[j] < br.e[2]) vfactor.e[j]=1
		if(e2mv[j] >= br.e[2] & e2mv[j] < br.e[3]) vfactor.e[j]=2
		if(e2mv[j] >= br.e[3]) vfactor.e[j]=3	}

lowtime.e=c(0,sort(e2m$Time[vfactor.e=='1']),tmax)
low.e=c(0:(length(lowtime.e)-2),(length(lowtime.e)-2))*100/length(unnormv.e[unnormv.e<br.e[2]])

medtime.e=c(0,sort(e2m$Time[vfactor.e=='2']),tmax)
med.e=c(0:(length(medtime.e)-2),(length(medtime.e)-2))*100/length(unnormv.e[unnormv.e>=br.e[2] & unnormv.e<br.e[3]])

hightime.e=c(0,sort(e2m$Time[vfactor.e=='3']),tmax)
high.e=c(0:(length(hightime.e)-2),(length(hightime.e)-2))*100/length(unnormv.e[unnormv.e>=br.e[3]])

for (i in 1:2)	{
if (i==1) pdf(paste('Output/Worth-Fig3a',prefix,'.pdf',sep=''),width=c,height=c)
if (i==2) postscript(paste('Output/Worth-Fig3a',prefix,'.eps',sep=''),
	onefile=FALSE,horizontal=FALSE, width=c, height=c)
par(mar=c(3.3,3.3,1,1))
plot(0,0, type='n', main='', xlab='',ylab='', 
	xlim=c(0,tmax/1e6), ylim=c(0,max(low.e ,med.e, high.e)))
mtext('Time (Myrs)',side=1, line=2.1)
mtext('Cumulative Percent',side=2, line=2.1)
#mtext('Earth -> Mars',side=3, line=0.5)
points(lowtime.e/1e6,low.e,type='s')
points(medtime.e/1e6,med.e,type='s',lty=2)
points(hightime.e/1e6,high.e,type='s',lty=3)
legend('topleft',bty='n',lty=1:3,legend=LegLab.e[1:3], cex=.8333)
dev.off()	}

# cprob_m, Mars to Earth
m2e=marsrocks[marsrocks$Destination=='Earth',]
m2ev=unnormv.m[marsrocks$Destination=='Earth']
vfactor.m=factor(replicate(length(m2ev),0),levels=c(0,1,2,3))
br.m=min(unnormv.m)+0:3*(max(unnormv.m)-min(unnormv.m))/3
LegLab.m=c(
bquote(v[infinity] %~~% .(signif(mean(br.m[1:2]),2)) ~ km/s),
bquote(v[infinity] %~~% .(signif(mean(br.m[2:3]),2)) ~ km/s),
bquote(v[infinity] %~~% .(signif(mean(br.m[3:4]),2)) ~ km/s),
expression(v[infinity] %~~% signif(mean(br.m[3:4]),2) ~ km/s))
	for (j in 1:length(m2ev)) {
		if(m2ev[j] < br.m[2]) vfactor.m[j]=1
		if(m2ev[j] >= br.m[2] & m2ev[j] < br.m[3]) vfactor.m[j]=2
		if(m2ev[j] >= br.m[3]) vfactor.m[j]=3	}

lowtime.m=c(0,sort(m2e$Time[vfactor.m=='1']),tmax)
low.m=c(0:(length(lowtime.m)-2),(length(lowtime.m)-2))*100/length(unnormv.m[unnormv.m<br.m[2]])

medtime.m=c(0,sort(m2e$Time[vfactor.m=='2']),tmax)
med.m=c(0:(length(medtime.m)-2),(length(medtime.m)-2))*100/length(unnormv.m[unnormv.m>=br.m[2] & unnormv.m<br.m[3]])

hightime.m=c(0,sort(m2e$Time[vfactor.m=='3']),tmax)
high.m=c(0:(length(hightime.m)-2),(length(hightime.m)-2))*100/length(unnormv.m[unnormv.m>=br.m[3]])

for (i in 1:2)	{
if (i==1) pdf(paste('Output/Worth-Fig3b',prefix,'.pdf',sep=''),width=c,height=c)
if (i==2) postscript(paste('Output/Worth-Fig3b',prefix,'.eps',sep=''),
	onefile=FALSE,horizontal=FALSE, width=c, height=c)
par(mar=c(3.3,3.3,1,1))
plot(0,0, type='n', main='', xlab='',ylab='', 
	xlim=c(0,tmax/1e6), ylim=c(0, max(low.m, med.m, high.m)))
mtext('Time (Myrs)',side=1, line=2.1)
mtext('Cumulative Percent',side=2, line=2.1)
#mtext('Mars -> Earth',side=3, line=0.5)
points(lowtime.m/1e6,low.m,type='s')
points(medtime.m/1e6,med.m,type='s',lty=2)
points(hightime.m/1e6,high.m,type='s',lty=3)
legend('topleft',bty='n',lty=1:3,legend=LegLab.m[1:3], cex=.8333)
dev.off()	}

