#read .aei for planets, rocks
print('Read .aei files')


subset=rocks[rocks$File==16,]
colors=factor(subset$Destination,labels=c('gray','yellow','cyan4','cyan',
	'blue','red','purple','light gray'))
colors=matrix(colors)
nobj.m=742
obj.m=list()
#for (j in ObjInd)	{
for (j in c(0:10,165,638))	{
#	dir=file.path('/astro/grads/rjw274/Panspermia',
#	'Lithopanspermia/Analysis/bigmars8/AEI/')
	dir=file.path('../bigmars8/AEI/')
	obj.m[[j+1]]=read.table(paste(dir,'M',j,'.aei', sep=''), header=F,skip=4,
	col.names=c('Time','a','e','i','mass','dens', 'x','y','z','vx','vy','vz')
	)[,c(2:3,7:8)]
	}

#pnames=c('Mercury	','Venus	','Earth	','Mars	','Jupiter	','Saturn	',
#	'Uranus	','Neptune	')
pnames=c('Mercury	','Venus	','Earth	','Mars	','Jupiter	','Saturn	',
	'Uranus	','Neptune	')
planets.m=list()
for (j in 1:length(pnames)) planets.m[[j]]=read.table(
	paste(dir,pnames[j],'.aei',sep=''), header=F,skip=4,
	col.names=c('Time','a','e','i','mass','dens', 'x','y','z','vx','vy','vz')
	)[,c(2:3,7:8)]

