### Collision-time model parameters
# should only fit times that actually count, I guess...
collisions=rocks[rocks$Time>0,]

time.fit=glm(collisions$Time ~ collisions$Destination+collisions$Origin+collisions$v0+collisions$Theta+collisions$Phi)

time.models=cbind(summary(time.fit)$coefficients[2:12,1], signif(summary(time.fit)$coefficients[2:12,4],2))
rownames(time.models)=c('Destination: Mercury','Destination: Venus','Destination: Earth','Destination: Mars','Destination: Jupiter','Destination: Saturn','Destination: Ejected','Origin','$v_0$','$theta$','$phi$')

#time.models[1:10,1]=round(time.models[1:10,1])
time.models[,1]=signif(time.models[,1],2)

space=replicate(dim(time.models)[1],' & ')
end=replicate(dim(time.models)[1],'   \\')
time.models=cbind(space,time.models[,1], space,time.models[,2],end)
colnames(time.models)=c(' & ','$beta$', ' & ','P','   \\')

#stop

