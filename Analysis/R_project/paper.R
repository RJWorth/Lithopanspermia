###############################################################################
par(ask=F,mfrow=c(1,1))
#Column: Origin, File, Object, Destination, Time, v0, Theta, Phi

# Which version?
vers=1

if (vers==1)	{prefix=''
				file='../data.txt'}

if (vers==2)	{prefix='-long'
				file='../data_long.txt'}

if (vers==3)	{prefix='-fast'
				file='../data_fast.txt'}


#Constants
Msun 	= 1.989e33		#g
AU 		= 1.496e13		#cm
G 		= 6.67259e-8		#cm^3/(g*s^2)
day 		= 24.*3600.		#s
Mearth	= 5.9742e27		#g
Rearth	= 6.3781e8		#cm
Mmars 	= 6.4185e26		#g
Rmars 	= 3.3862e8		#cm
vesc.e	= 0.00033421974	#AU/day
vesc.m	= 0.00015886033	#AU/day
#Nearth	= 0.5e8			# viable fragments ejected
#Nmars	= 2.0e8			# viable fragments ejected
Nearth	= 2e8			# viable fragments ejected
Nmars	= 8e8			# viable fragments ejected
# printing sizes
p=16.5/2.54
c=8/2.54

### Read and prepare data (rocks, earthrocks, marsrocks)
source('ReadRocks.R')
attach(rocks)

par(mar=c(5,4,4,1))

### Make histograms of collision time by origin and destination
#source('MakeHist.R')

### Make small-grid histogram of Earth re-impact rates
#source('MakeReimpact.R')

### Make table of total transfer numbers and rates
source('MakeRatesTable.R')

### Make table of transfer timescales
#source('MakeTimeTable.R')

### Fit impact destination
##source('FitDest.R')

### Fit impact time
##source('FitTime.R')

### Make cumulative probability plots
#source('MakeCprobs.R')

### Read moon sim results
#source('ReadMoons.R')

### Make tables of collision rates
#source('MoonRateTable.R')

### Make tables of 4 Gyr totals
#if (vers!=3) source('Make4GyrTables.R')

### Make tables of collision rates
#source('MoonRatioPlot.R')

### Examine collision rates compared to physical data
source('PlanetRatioPlot.R')

detach(rocks)
par(ask=F,mfrow=c(1,1))

