### Moon sims
options(scipen=999)

Jcollisions1=read.table('Jupinfosum.out',header=T,nrows=890)
Jcollisions2=read.table('Jupinfosum.out',col.names=c('Su','Me','Ve','Ea','Ma','Ju','Io','Eu','Ga','Ca','Sa','Ia','En','Rh','Ti','Ej','Stp')
,skip=891)
Jcollisions=rbind(Jcollisions1,Jcollisions2[,-12:-15])

#Scollisions=read.table('Satinfosum.out',header=T)
Stally=array(dim=c(2,3))
Stally[1,]=c(14561,	0,	2)
Stally[2,]=c(13036,	2,	1)
colnames(Stally)=c('Saturn','Enceladus','Titan')

