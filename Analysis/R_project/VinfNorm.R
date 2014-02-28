
nbr=5
h.e=array(dim=c(ndest+1,nbr),dimnames=list(c(destlevels,'Total'),NULL))
h.m=array(dim=c(ndest+1,nbr),dimnames=list(c(destlevels,'Total'),NULL))

br.e=min(vinf.e)+(0:nbr)*(max(vinf.e)-min(vinf.e))/nbr
br.m=min(vinf.m)+(0:nbr)*(max(vinf.m)-min(vinf.m))/nbr

h.e[ndest+1,]=hist(vinf.e, br=br.e, plot=F)$counts
h.m[ndest+1,]=hist(vinf.m, br=br.m, plot=F)$counts



for (j in 1:9)	{
	h=hist(vinf.e[earthrocks$Destination==destlevels[j]], br=br.e, plot=F)
	h.e[j,]=h$counts/h.e[ndest+1,]	}

for (j in 1:9)	{
	h=hist(vinf.m[marsrocks$Destination==destlevels[j]], br=br.m, plot=F)
	h.m[j,]=h$counts/h.m[ndest+1,]	}

### Plot
for (i in 1:2)	{
if (i==1) pdf(paste('Output/VinfNorm',prefix,'.pdf',sep=''),	width=8/2.54, height=8/2.54)
if (i==2) jpeg(paste('Output/VinfNorm',prefix,'.jpg',sep=''),width = 3780, height = 3780, res=1200)
par(mfrow=c(4,5), mar=c(2.5,2.5,1.5,0.5), oma=c(1.5,2,2,0))
	for (j in 1:9) {
		barplot(h.e[j,], space=0, main=destlevels[j])
		axis(1, labels=round(br.e,2), at=0:5)
		}
plot(c(0,1),c(0,1), ann=F,bty='n',type='n', xaxt='n',yaxt='n')
	for (j in 1:7) {
		barplot(h.m[j,], space=0, main=destlevels[j])
		axis(1, labels=round(br.m,2), at=0:5)
		}
plot(c(0,1),c(0,1), ann=F,bty='n',type='n', xaxt='n',yaxt='n')
		barplot(h.m[9,], space=0, main=destlevels[9])
		axis(1, labels=round(br.m,2), at=0:5)
dev.off()

