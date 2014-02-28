# Total rates of transfer
earth.num=rep(0,ndest+1)
for (j in 1:9) earth.num[j]=round(sum(earthrocks$Destination==destlevels[j]))
earth.num[10]=sum(earth.num[1:9])
earth.per=signif(100*earth.num/dim(earthrocks)[1],2)

earth.err=sqrt(earth.num)
earth.err[10]=NA
earth.erp=signif(100*earth.err/dim(earthrocks)[1],1)
earth.erp[10]=NA

mars.num=rep(0,ndest+1)
for (j in 1:9) mars.num[j]=round(sum(marsrocks$Destination==destlevels[j]))
mars.num[10]=sum(mars.num[1:9])
mars.per=signif(100*mars.num/dim(marsrocks)[1],2)

mars.err=sqrt( mars.num)
mars.err[c(8,10)]=NA
mars.erp=signif(100*mars.err/dim(marsrocks)[1],1)
mars.erp[10]=NA

# Horizontal
#numbers=rbind(earth.num,round(earth.err),earth.per,mars.num,round(mars.err),mars.per)
#colnames(numbers)=c(destlevels,'Total')
#rownames(numbers)=c('Earth','Uncertainty','Earth (%)', 'Mars', 'Uncertainty','Mars (%)')

# Vertical
vertnumbers=cbind(earth.num, paste(earth.per, '+-', earth.erp),
				  mars.num,  paste(mars.per,  '+-', mars.erp))

rownames(vertnumbers)=c(destlevels,'Total')
colnames(vertnumbers)=c('Earth Impacts', 'Rate (%)', 
						'Mars Impacts',  'Rate (%)')
#vertnumbers=cbind(
#	paste(round(vertnumbers[,1]),'+-',round(vertnumbers[,2])),
#	signif(vertnumbers[,3],2),
#	paste(round(vertnumbers[,4]),'+-',round(vertnumbers[,5])),
#	signif(vertnumbers[,6],2) )
#colnames(vertnumbers)=c('Earth Impacts', 'Rate (%)', 
#						'Mars Impacts',  'Rate (%)')

sink(file=paste('Output/TotalRates',prefix,'.txt',sep=''))
print(vertnumbers, quote=F)
sink()
