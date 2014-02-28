### ...fitting impact destination
list.dest0=list(8)
for (j in 2:9)	{
rocks2=rocks[rocks$Destination==destlevels[j] | rocks$Destination=='Orbit',]
fit=glm(rocks2$Destination ~ rocks2$Origin+rocks2$v0+rocks2$Theta+rocks2$Phi, family='binomial')
list.dest0[[j-1]]=summary(fit)$coefficients
names(list.dest0)=destlevels[2:9]
	}

dest.fit0=array(dim=c(4,8))
for (j in 1:8) dest.fit0[,j]=signif(list.dest0[[j]][2:5,1],2)
rownames(dest.fit0)=c('Origin','v0','Theta0','Phi')
dest.fit0=signif(dest.fit0,2)

#space=replicate(dim(dest.fit0)[1],' & ')
#end=replicate(dim(dest.fit0)[1],'   \\')
#dest.fit0=cbind(space,dest.fit0[,1], space,dest.fit0[,2], space,dest.fit0[,3], space,dest.fit0[,4], space,dest.fit0[,5], space,dest.fit0[,6], space,dest.fit0[,7], space,dest.fit0[,8],end)
#colnames(dest.fit0)=c(' & ',destlevels[2], ' & ',destlevels[3], ' & ',destlevels[4], ' & ',destlevels[5], ' & ',destlevels[6], ' & ',destlevels[7], ' & ',destlevels[8], ' & ',destlevels[9], '   \\')


dest.probs0=array(dim=c(4,8))
rownames(dest.probs0)=c('Origin','$v_0$','$theta$','$phi$')
for (j in 1:8) dest.probs0[,j]=signif(list.dest0[[j]][2:5,4],2)
dest.probs0=signif(dest.probs0,2)


#dest.probs0=cbind(space,dest.probs0[,1], space,dest.probs0[,2], space,dest.probs0[,3], space,dest.probs0[,4], space,dest.probs0[,5], space,dest.probs0[,6], space,dest.probs0[,7], space,dest.probs0[,8],end)
#colnames(dest.probs0)=c(' & ',destlevels[2], ' & ',destlevels[3], ' & ',destlevels[4], ' & ',destlevels[5], ' & ',destlevels[6], ' & ',destlevels[7], ' & ',destlevels[8], ' & ',destlevels[9], '   \\')

library(randomForest)
form=Destination~v0
rfor=randomForest(form,data=earthrocks,ntree=100)



