### Timescales of transfers
earth.time=array(dim=c(8,2))
rownames(earth.time)=destlevels[2:9]
colnames(earth.time)=c('First Impact','Peak')
for (j in 2:9)	{
earth.time[j-1,]=c(min(earthrocks[
					earthrocks$Destination==destlevels[j],5]),
	mean(which(EarthBars[j,]==max(EarthBars[j,]))))	}
#earth.time[earth.time[,1]>1,1]=round(earth.time[earth.time[,1]>1,1])

mars.time=array(dim=c(8,2))
rownames(mars.time)=destlevels[2:9]
colnames(mars.time)=c('First Impact','Peak')
for (j in c(2:7,9))	{
mars.time[j-1,]=c(min(marsrocks[
					marsrocks$Destination==destlevels[j],5]),
	mean(which(MarsBars[j,]==max(MarsBars[j,]))))	}
#mars.time[(mars.time[,1]>1 & !is.na(mars.time[,1])),1]=
#	round(mars.time[(mars.time[,1]>1 & !is.na(mars.time[,1])),1])
mars.time[7,]=c(NA,NA)

# Calculate medians for long version
medians=array(dim=c(8,2))
rownames(medians)=destlevels[2:9]
colnames(medians)=c('Earth Median','Mars Median')
for (j in 2:9)	{
medians[j-1,]=c(median(earthrocks[earthrocks$Destination==destlevels[j],5]),
	median(marsrocks[marsrocks$Destination==destlevels[j],5]))	}
mars.time[7,]=c(NA,NA)
medians=signif(medians/1e6,2)


options(scipen=999)
sink(file=paste('Output/Times',prefix,'.txt',sep=''))
print(earth.time, quote=F)
cat('\n')
print(mars.time, quote=F)
	cat('\n')
	print(medians, quote=F)
sink()
options(scipen=0)



