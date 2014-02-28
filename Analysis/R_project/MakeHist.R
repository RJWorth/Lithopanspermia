
### Make histograms of transfer times

nbars=round(max(rocks$Time)/1e6)	# number of bars in histogram
	br=0:nbars*1e6					# breaks for bars
AllEarth = dim(earthrocks)[1]
#MercEarth= sum(earthrocks$File %in% c(0,1,2,3,4,5,6,7,8,9))
	# I can't tell if Mercury ever actually got excluded...?
	# Currently all files are included in the counts.
AllMars  = dim(marsrocks)[1]
#MercMars = sum(marsrocks$File %in% c(10,11,12,13,14,15,16,17,18,19))
nInFiles=rbind(rep(AllEarth,ndest),rep(AllMars,ndest))	# # of rocks in files containing this dest (currently all same for each origin)
	dimnames(nInFiles)=list(c('Earth','Mars'), destlevels)
#	nInFiles[1,3]=MercEarth
#	nInFiles[2,3]=MercMars

# Make array of rates for each orig-dest pair, over time bins
EarthBars=array(dim=c(ndest,nbars))
	rownames(EarthBars)=destlevels
MarsBars =array(dim=c(ndest,nbars))
	rownames(MarsBars)=destlevels
for (j in 1:ndest)	{
EarthBars[j,]=100*hist(earthrocks$Time[earthrocks$Destination==destlevels[j]], 
	breaks=br)$counts/nInFiles[1,j]
MarsBars[j,]=100*hist(marsrocks$Time[marsrocks$Destination==destlevels[j]], 
	breaks=br)$counts/nInFiles[2,j]
	}

# axis labels
#lbls=c(0,'',2,'',4,'',6,'',8,'',10)
#spots=0:10*(12/10)
#if (vers==2) { lbls=c(0,'',4,'',8,'',12,'',16,'',20)
#spots=0:10*(12/5)	}

# Plot histograms
for (i in 1:2)	{
if (i==1) pdf(paste('Output/Worth-Fig1',prefix,'.pdf',sep=''),width=p,height=p)
if (i==2) postscript(paste('Output/Worth-Fig1',prefix,'.eps',sep=''),
	onefile=FALSE,horizontal=FALSE, width=p, height=p)

par(mfrow=c(4,4), mar=c(2.5,2.5,1.5,0.5), oma=c(1.5,2,1,0))
# Earth histograms
for (j in 2:ndest)	{barplot(EarthBars[j,], col='gray22', space=0, 
	main=paste('Earth to',destlevels[j]), xlab='', ylab='')		# Earth set
	axis(1)	}
#	axis(1,at=spots, labels=lbls )		}
# Mars histograms
for (j in 2:7)	{barplot(MarsBars[j,], col='gray22', space=0,
	main=paste('Mars to',destlevels[j]), xlab='', ylab='')		# Mars set
	axis(1)	}
#	axis(1,at=spots, labels=lbls )		}
plot(c(0,1),c(0,1),ann=F,bty='n',type='n',xaxt='n',yaxt='n')	# Saturn
barplot(MarsBars[9,], col='gray22', space=0,					# Ejected
	main=paste('Mars to',destlevels[9]), xlab='', ylab='')
	axis(1)
#	axis(1,at=spots, labels=lbls )		

mtext("Time (Myr)", side=1, line=0, cex=1.2, outer=TRUE)
mtext("Percent of total ejecta", side=2, line=0.2, cex=1.2, outer=TRUE)
#mtext("Collision times by planet of origin and destination", side=3, line=0.2, cex=1.2, outer=TRUE)

dev.off()	}

