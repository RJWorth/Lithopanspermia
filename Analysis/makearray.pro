PRO makearray

home='/Volumes/Macintosh\ HD\ 2/rjw'
analysis='/astro/grads/rjw274/Panspermia/Lithopanspermia/Analysis'
cd, home

;number of simulations for each Earth and Mars origin
nsime=10
nsimm=10
names=['bigearth2','bigearth3','bigearth4','bigearth5','bigearth6','bigearth7','bigearth8','bigearth9','bigearth10','bigearth11',  'bigmars1','bigmars2','bigmars4','bigmars5','bigmars6','bigmars7','bigmars8','bigmars9','bigmars10','bigmars11']

data1=fltarr(8,1)
filesum=make_array([nsime+nsimm,11],/long)
percents=make_array([nsime+nsimm,11],/float)

;;;;;;Repeat from here for each directory/simulation	
for j=0,nsime+nsimm-1 do begin
	cd, home+'/'+names[j]

close,/all
if ((j le 6) || ((j ge 10) && (j le 16))) then begin
openr, 2, '/astro/grads/rjw274/Panspermia/bigSScart.in'
	nbig=file_lines('bigSScart.in')
endif else begin
openr, 2, 'bigSS.in'
	nbig=file_lines('bigSS.in')
endelse
openr, 3, 'small.in'
	nsmall=file_lines('small.in')
openr, 4, 'info.out'
	ninfo=file_lines('info.out')

	bigh=strarr(6)
	big=replicate({name:'', loc:dblarr(3,3)}, (nbig-n_elements(bigh))/4)
readf,2,bigh,big
headb=strsplit(big.name,/extract)
big.name=big.name[0]
bigx=big.loc[0,0]
bigy=big.loc[1,0]
bigz=big.loc[2,0]
bigu=big.loc[0,1]
bigv=big.loc[1,1]
bigw=big.loc[2,1]

;Center on which planet?
	;Earth
if (j le nsime-1) then begin
;	openr, 2, 'Earth	.in'
;	npl=file_lines('Earth	.in')
;		plhead=strarr(4)
;		pl=array(12)
;		pltail=strarr(npl-5)
;	readf,2,plhead,pl,pltail

	planetpos=[bigx[2],bigy[2],bigz[2]]
	planetvel=[bigu[2],bigv[2],bigw[2]]
;	planetpos=[3.539216298657206E-01, -9.528895415506942E-01,  2.240737713635441E-05]
;	planetvel=[1.585486546409684E-02,  5.930487654613723E-03,  4.405427927009799E-07]
	Mplanet = 5.9742e27		;g
	Rplanet = 6.3781e8		;cm

	;Mars
endif else begin
	planetpos=[bigx[3],bigy[3],bigz[3]]
	planetvel=[bigu[3],bigv[3],bigw[3]]
;	planetpos=[-1.491386495955182E+00, -6.176808782310850E-01,  2.367835723944626E-02]
;	planetvel=[5.877090413105990E-03, -1.173427891334947E-02, -3.901964246659431E-04]
	Mplanet = 6.4185e26		;g
	Rplanet = 3.3862e8		;cm
endelse


	smallh=strarr(5)
	small=replicate({name:'', loc:dblarr(3,3)}, (nsmall-n_elements(smallh))/4)
readf,3,smallh,small
heads=strsplit(small.name,/extract)
small.name=small.name[0]
	v0=dblarr(n_elements(small.name))
	theta=dblarr(n_elements(small.name))
	phi=dblarr(n_elements(small.name))
x=small.loc[0,0]-planetpos[0]
y=small.loc[1,0]-planetpos[1]
z=small.loc[2,0]-planetpos[2]
u=small.loc[0,1]-planetvel[0]
v=small.loc[1,1]-planetvel[1]
w=small.loc[2,1]-planetvel[2]
v0=sqrt(u^2+v^2+w^2)
theta1=180/!pi*atan(y,x)
theta=theta1
	for k=0,n_elements(x)-1 do begin
	if (theta1[k] lt 0.) then theta[k]=theta1[k]+360.
;	if (x[k] lt 0.) then theta[k]=theta1[k]+180.
;	if ((x[k] gt 0.) and (y[k] lt 0.)) then theta[k]=theta1[k]+360.
	endfor
phi=180/!pi*asin(z/sqrt(x^2+y^2+z^2))
;phi=phi1
;	for k=0,n_elements(x)-1 do begin
;	if (phi[k] gt 90.) then phi[k]=phi1[k]-180.
;	endfor

	headi=strarr(39)
	info=strarr(ninfo-39-8)
	dest1=strarr(n_elements(info))
	name1=strarr(n_elements(info))
	time1=strarr(n_elements(info))
	footi=strarr(8)
readf,4,headi,info,footi
info2=strsplit(info,/extract)
	for k=0,n_elements(info2)-1 do begin
	row=info2[k]
	if (size(info2[k],/dimensions) eq 8) then begin
	if (row[0] ne 'Continuing') then begin
	dest1[k]=row[0]
	name1[k]=row[4]
	time1[k]=row[6]	
	endif
	endif
	if (size(info2[k],/dimensions) eq 9) then begin
	dest1[k]='Sun'
	name1[k]=row[0]
	time1[k]=row[7]	
	endif
	if (size(info2[k],/dimensions) eq 5) then begin
	if (row[0] ne 'Fractional') then begin
	dest1[k]='ejected'
	name1[k]=row[0]
	time1[k]=row[3]	
	endif
	endif
	endfor

;These should just be at the breaks between integrations, in groups of 11, so all fields should be blank and get omitted in next step
;Possible misalignments would also show up here?
print,names[j]
print,string(where(float(time1) eq 0.))+replicate(': ',n_elements(where(float(time1) eq 0.)))+info[where(float(time1) eq 0.)]

name=strarr(n_elements(v0))
dest=replicate('orbit',n_elements(v0))
time=fltarr(n_elements(v0))
	for k=0,n_elements(name)-1 do name[k]='M'+strtrim(string(k),2)
	for k=0,n_elements(name1)-1 do begin
	dest[where (name eq name1[k])]=dest1[k]
	time[where (name eq name1[k])]=float(time1[k])
	endfor
name=fix(strmid(name,1))
	for k=0,n_elements(dest)-1 do begin
	if dest[k] eq 'orbit' then dest[k]=0
	if dest[k] eq 'Sun' then dest[k]=1
	if dest[k] eq 'Mercury' then dest[k]=2
	if dest[k] eq 'Venus' then dest[k]=3
	if dest[k] eq 'Earth' then dest[k]=4
	if dest[k] eq 'Mars' then dest[k]=5
	if dest[k] eq 'Jupiter' then dest[k]=6
	if dest[k] eq 'Saturn' then dest[k]=7
	if dest[k] eq 'Uranus' then dest[k]=8
	if dest[k] eq 'Neptune' then dest[k]=9
	if dest[k] eq 'ejected' then dest[k]=10
	endfor

;'origin' = 0 for Earth origin, 1 for Mars
if j le nsime-1 then origin=replicate(0,n_elements(v0)) else origin=replicate(1,n_elements(v0))
;'file'= the filenumber
file=replicate(j,n_elements(v0))
newpart=transpose([[origin],[file],[name],[dest],[time],[v0],[theta],[phi]])

for k=0,10 do begin
filesum[j,k]=total(newpart[3,*] eq k)
percents[j,k]=100.*float(filesum[j,k])/float(n_elements(v0))
endfor

data1=[[data1],[newpart]]
close,/all
endfor

data=data1[*,1:(n_elements(data1[0,*])-1)]

cd, home

results=make_array([2,11],/long)
for k=0,10 do begin
	results[0,k]=total(data[3,where(data[0,*] eq 0.)] eq k)
	results[1,k]=total(data[3,where(data[0,*] eq 1.)] eq k)
endfor

stop

openw, 6, '/astro/grads/rjw274/Panspermia/Lithopanspermia/Analysis/filesum.txt', width=150
printf, 6, ['	  Orbit','    Sun','Mercury','  Venus','  Earth','   Mars','Jupiter',' Saturn',' Uranus','Neptune','Ejected']
printf, 6, transpose([[names], [strtrim(string(filesum),2)]])
printf, 6, 'Percentages:'
printf, 6, transpose([[names], [strtrim(string(percents),2)]])
printf, 6, 'Totals:'
printf, 6, [transpose(['  Orbit','    Sun','Mercury','  Venus','  Earth','   Mars','Jupiter',' Saturn',' Uranus','Neptune','Ejected']), [string(results)], [string(100.*results[0,*]/total(results[0,*]))], [string(100.*results[1,*]/total(results[1,*]))] ]
close, 6

openw, 5, '/astro/grads/rjw274/Panspermia/Lithopanspermia/Analysis/data.txt', width=150
printf, 5, ['          Origin','           File','         Object','    Destination','           Time','             v0','          Theta','            Phi']
printf, 5, data
close, 5
close, /all

stop
end
