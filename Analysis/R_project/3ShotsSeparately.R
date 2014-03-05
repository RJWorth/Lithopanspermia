###############################################################################
### Pretty pictures of flight
print('Make flight images')
require(plotrix)	#to draw circles

side=8
###############################################################################
### Make images
pdf('Output/flight1.pdf', height=side, width=side)
par(mar=c(2.5,2.5,1.5,0.5), oma=c(2,2,2,1))
par(bg='black',fg='white',
	col.axis='white',col.lab='white',col.main='white',col.sub='white')
#pch 19 > 20, 21=open 19, 8=*


### Ejection, t=0
#Mars
plot( matrix(planets.m[[2]]$x[1]), matrix(planets.m[[2]]$y[1]),
	type='p',pch=20, ,col='white', xlim=c(-1.5,-1.48), ylim=c(-.65,-.6))
		mtext('X (AU)', side=1, line=0.2, cex=1.2, outer=TRUE)
		mtext('Y (AU)', side=2, line=0.2, cex=1.2, outer=TRUE)
		mtext('Initial Configuration', side=3, line=0.2, cex=1.2, outer=TRUE)
#Meteoroids
#for (j in c(0:10,165,638))	{
#	lines( matrix(obj.m[[j+1]]$x[1]), matrix(obj.m[[j+1]]$y[1]), 
#		lty=2, pch=20,cex=.5, col=colors[j+1],type='p')	
#	}

legend('bottomleft', legend=c('Sun','Planets',
		'Meteoroids that stay in orbit',
		'Meteoroids that collide with the Sun',
		'Meteoroids that collide with Earth',
		'Meteoroids that collide with Mars',
		'Meteoroids that collide with Jupiter',
		'Meteoroids that are ejected'), cex=2,
	col=c('yellow','white','gray','yellow','blue',
		'red','purple','light gray'), 
	pch=20,pt.cex=c(3,1,.5,.5,.5,.5,.5,.5))

dev.off()
###############################################################################
pdf('Output/flight2.pdf', height=side, width=side)
par(mar=c(2.5,2.5,1.5,0.5), oma=c(2,2,2,1))
par(bg='black',fg='white',
	col.axis='white',col.lab='white',col.main='white',col.sub='white')

### Orbits, first 1 Myr=1000 steps
#Sun
plot( 0,0,pch=20,col='yellow',cex=3,
	xlim=c( -5.5, 5.5 ),	ylim=c( -5.5, 5.5 ) )
		mtext('X (AU)', side=1, line=0.2,  cex=2, outer=TRUE)
		mtext('Y (AU)', side=2, line=0.2,  cex=2, outer=TRUE)
		mtext('First Million Years', side=3, line=-0.2,  cex=2, outer=TRUE)
#Planets
for (j in 1:length(pnames))	{
	draw.circle(0,0,planets.m[[j]]$a[1],border="white")
	}

#Meteoroids
for (j in c(0:10,165,638))	{
	lines(matrix(obj.m[[j+1]]$x[1:1001]), matrix(obj.m[[j+1]]$y[1:1001]), 
		lty=2, pch=20,cex=.5, col=colors[j+1],type='p')
	}


legend('topleft', legend=c('Sun','Planets',
		'Meteoroids'),  cex=2,
	col=c('yellow','white','light gray'), 
	pch=c(20,NA,20),pt.cex=c(3,1,.5),
	lty=c(NA, 1,NA))

dev.off()
###############################################################################
pdf('Output/flight3.pdf', height=side, width=side)
par(mar=c(2.5,2.5,1.5,0.5), oma=c(2,2,2,1))
par(bg='black',fg='white',
	col.axis='white',col.lab='white',col.main='white',col.sub='white')

### Collision, last Myr
#Sun
plot( 0,0,pch=20,col='yellow',cex=3,
	xlim=c( -5.5, 5.5 ),	ylim=c( -5.5, 5.5 ) )
		mtext('X (AU)', side=1, line=0.2, cex=2, outer=TRUE)
		mtext('Y (AU)', side=2, line=0.2, cex=2, outer=TRUE)
		mtext('Last Million Years', side=3, line=-0.2, cex=2, outer=TRUE)
#Planets
for (j in 1:length(pnames))	{
	draw.circle(0,0,planets.m[[j]]$a[1],border="white")
	}
#Meteoroids
for (j in c(0:10,165,638))	{
	lines(matrix(obj.m[[j+1]]$x[9001:10001]),
		  matrix(obj.m[[j+1]]$y[9001:10001]), 
		lty=2, pch=20,cex=.5, col=colors[j+1],type='p')
	}

#mtext('X (AU)', side=1, line=0.2, cex=1.2, outer=TRUE)
#mtext('Y (AU)', side=2, line=0.2, cex=1.2, outer=TRUE)
#mtext('Top-down view of Solar System', side=3, line=0.2, cex=1.2, outer=TRUE)


legend('topleft', legend=c('Sun','Planets',
		'Meteoroids'),  cex=2,
	col=c('yellow','white','light gray'), 
	pch=c(20,NA,20),pt.cex=c(3,1,.5),
	lty=c(NA, 1,NA))

dev.off()

#par(bg='white',fg='black',
#	col.axis='black',col.lab='black',col.main='black',col.sub='black',
#	ask=F,mfrow=c(1,1))

