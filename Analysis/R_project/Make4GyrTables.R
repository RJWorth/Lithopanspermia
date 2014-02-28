### 4Gyr totals

#Planets
prob=c(earth.num[1:9]/earth.num[10], mars.num[1:9]/mars.num[10])
prob.err=c(earth.err[1:9]/earth.num[10], mars.err[1:9]/mars.num[10])
gy4=c(prob[1:9]*Nearth, prob[10:18]*Nmars )
gy4.err=c(Nearth*earth.err[1:9]/earth.num[10], 
	Nmars*mars.err[1:9]/mars.num[10])
mass4gy=signif(gy4*340000,2)

PlEstimates=cbind(paste(signif(100*prob,2),'+-',signif(100*prob.err,1)) , 
	paste(signif(gy4,2),'+-', signif(gy4.err,1)),mass4gy)

#Make Mars-Saturn an upper limit
PlEstimates[17,]=c(paste('<',signif(100*1/mars.num[10],2)),
	paste('<',signif(1/mars.num[10]*Nmars,2)),
	paste('<',signif(1/mars.num[10]*Nmars,2)*340000))

rownames(PlEstimates)=c(destlevels,destlevels)
colnames(PlEstimates)=c('Probability (%)','4 Gyr Total', 'Mass Transfer')
options(scipen=0)


##Moons
moonratios=c(Jnum[1]/Jnum[2:5], Snum[1]/Snum[2:3],  
	Jnum[1]/Jnum[2:5], Snum[1]/Snum[2:3])
moonratios.err=c( (Jnum[1]/Jnum[2:5])*sqrt(1/Jnum[2:5] + 1/Jnum[1]), 
	(Snum[1]/Snum[2:3])*sqrt(1/Snum[2:3] + 1/Snum[1]), 
	(Jnum[1]/Jnum[2:5])*sqrt(1/Jnum[2:5] + 1/Jnum[1]), 
	(Snum[1]/Snum[2:3])*sqrt(1/Snum[2:3] + 1/Snum[1]) )

moonprob=c(prob[7]/moonratios[1:4], prob[8]/moonratios[5:6], 
	prob[16]/moonratios[1:4], prob[17]/moonratios[5:6])

jprob=c(earth.num[7]/earth.num[10], mars.num[7]/mars.num[10])
sprob=c(earth.num[8]/earth.num[10], mars.num[8]/mars.num[10])
jprobrat=c( (prob.err[7]/prob[7])^2, (prob.err[16]/prob[16])^2 )
sprobrat=c( (prob.err[8]/prob[8])^2, (prob.err[17]/prob[17])^2 )

moonprob.err=moonprob*sqrt( (moonratios.err/moonratios)^2+c(jprob[1],jprob[1],
	jprob[1],jprob[1],sprob[1],sprob[1]) )
moongy4= c( moonprob[1:6]*Nearth,moonprob[7:12]*Nmars )
moongy4.err=c( moonprob.err[1:6]*Nearth,moonprob.err[7:12]*Nmars )

MnEstimates=cbind(paste(signif(moonratios,2),'+-',signif(moonratios.err,1)),
	paste(signif(100*moonprob,2),'+-',signif(100*moonprob.err,1)),
	paste(signif(moongy4,1),'+-',signif(moongy4.err,1)),
	signif(moongy4*340000,2)	)

#Make Mars-Saturn an upper limit
MnEstimates[11,2:4]=c(paste('<',signif(100*1/mars.num[10]/moonratios[5],2)),
	paste('<',signif(1/mars.num[10]/moonratios[5]*Nmars,2 )),
	paste('<',signif(1/mars.num[10]/moonratios[5]*Nmars*340000,2)	) )
MnEstimates[12,2:4]=c(paste('<',signif(100*1/mars.num[10]/moonratios[6],2)),
	paste('<',signif(1/mars.num[10]/moonratios[6]*Nmars,2 )),
	paste('<',signif(1/mars.num[10]/moonratios[6]*Nmars*340000,2)	) )

moonnames=c('Io','Europa','Ganymede','Callisto','Enceladus','Titan') 
rownames(MnEstimates)=rep(moonnames,2)
colnames(MnEstimates)=c('Impact Ratio','Probability (%)',
							'4 Gyr Total','Mass Transfer')


sink(file=paste('Output/4GyrRates',prefix,'.txt',sep=''))
print(PlEstimates, quote=F)
#cat(colnames(PlEstimates))
#cat('\n')
#for (j in 1:dim(PlEstimates)[1])	{
#	cat(PlEstimates[j,])
#	cat('\n')
#}
options(scipen=0)
print(MnEstimates, quote=F)
#cat('\n')
#cat(colnames(MnEstimates))
#cat('\n')
#for (j in 1:dim(MnEstimates)[1])	{
#	cat(MnEstimates[j,])
#	cat('\n')
#}

sink()


