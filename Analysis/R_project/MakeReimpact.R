
### Make histograms of fall-back rates on Earth in first Myr

EarthStart=earthrocks[(earthrocks$Time <= 1e6) & (earthrocks$Time != 0.) 
	& (earthrocks$Destination == 'Earth'),]
MarsStart=marsrocks[(marsrocks$Time <= 1e6) & (marsrocks$Time != 0.) 
	& (marsrocks$Destination == 'Mars'),]

breaks=(0:1e3)*1e3
TimeCut.e = cut(EarthStart$Time, breaks, right=FALSE) 
TimeFreq.e = table(TimeCut.e) 
CumFreq.e=c(0, cumsum(TimeFreq.e))/dim(earthrocks)[1]*100

TimeCut.m = cut(MarsStart$Time, breaks, right=FALSE) 
TimeFreq.m = table(TimeCut.m) 
CumFreq.m=c(0, cumsum(TimeFreq.m))/dim(marsrocks)[1]*100


for (i in 1:2)	{
if (i==1) pdf(paste('Output/Worth-Fig4',prefix,'.pdf',sep=''),width=c,height=c)
if (i==2) postscript(paste('Output/Worth-Fig4',prefix,'.eps',sep=''),
	onefile=FALSE,horizontal=FALSE, width=c, height=c)
par(mar=c(3.3,3.3,1,1))
plot(breaks/1e6,CumFreq.e, type='l',
	xlab='',ylab='', main='')
mtext(1,text='Time (Myr)', line=2)
mtext(2,text='Cumulative Probability (%)', line=2)
#mtext(3,text='Re-impacts', line=.5)
lines(breaks/1e6,CumFreq.m,lty=2)
legend('bottomright',legend=c('Earth','Mars'),lty=c(1,2),cex=.7)

dev.off()	}

par(mar=c(5,4,4,1))

