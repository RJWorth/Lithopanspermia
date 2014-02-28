Jnum=c( sum(Jcollisions['Ju']), sum(Jcollisions['Io']),sum(Jcollisions['Eu']),sum(Jcollisions['Ga']),sum(Jcollisions['Ca']) )
Jerr=sqrt(Jnum)
Jcoll=cbind(Jnum,round(Jerr))
colnames(Jcoll)=c('Number','Uncertainty')
rownames(Jcoll)=c('Jupiter','Io','Europa','Ganymede','Callisto')

Snum=colSums(Stally)
Serr=sqrt(Snum)
Scoll=cbind(Snum,round(Serr))
colnames(Scoll)=c('Number','Uncertainty')
rownames(Scoll)=c('Saturn','Enceladus','Titan')

sink(file=paste('Output/MoonRates',prefix,'.txt',sep=''))
options(scipen=999)
print(Jcoll, quote=F)
cat('\n')
print(Scoll, quote=F)
sink()

