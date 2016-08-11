#!/bin/bash

#################################
# You will need to edit these parameters:
BASE=guppi_57098_GBNCC96059_0055_0001
FACTOR=1466000
PSRFITSSUBBANDLOC=/data1/thankful/psrfits_utils/
DM=17.150
PERIOD=0.08314448
ZMAX=0
# If there's significant pdot, enter value here
PDOT=0
#################################

# First, do a full analysis of the 8-bit data without running psrfits_subband on it:
rfifind -time 1.0 -o ${BASE} ${BASE}.fits
prepdata -dm ${DM} -numout ${FACTOR} -o ${BASE} -mask ${BASE}_rfifind.mask ${BASE}.fits
realfft ${BASE}.dat
accelsearch -zmax ${ZMAX} ${BASE}.fft
#prepfold -accelfile ${BASE}_ACCEL_0.cand -accelcand 1 -mask *.mask ${BASE}.dat
prepfold -nosearch -fine -o ${BASE} -p ${PERIOD} -pdd ${PDOT} -dm ${DM} -mask *${BASE}*.mask ${BASE}.fits
single_pulse_search.py ${BASE}.dat
# When finished, compare outputs from prepfolds, single pulse search, compare file size, etc.

# Next, run psrfits_subband and output to 8bits for testing, using the scales and offsets:
BASE8BIT=${BASE}_8bit_conv
psrfits_quick_bandpass.py ${BASE}.fits
${PSRFITSSUBBANDLOC}psrfits_subband -outbits 8 -o ${BASE8BIT} -bandpass ${BASE}.fits.bandpass ${BASE}.fits
mv ${BASE8BIT}_0001.fits ${BASE8BIT}.fits
rfifind -time 1.0 -o ${BASE8BIT} ${BASE8BIT}.fits
prepdata -dm ${DM} -numout ${FACTOR} -o ${BASE8BIT} -mask ${BASE8BIT}_rfifind.mask ${BASE8BIT}.fits
realfft ${BASE8BIT}.dat
accelsearch -zmax ${ZMAX} ${BASE8BIT}.fft
#prepfold -accelfile ${BASE8BIT}_ACCEL_0.cand -accelcand 1 -mask *.mask ${BASE8BIT}.dat
prepfold -nosearch -fine -o ${BASE8BIT} -p ${PERIOD} -pdd ${PDOT} -dm ${DM} -mask *${BASE8BIT}*.mask ${BASE8BIT}.fits
single_pulse_search.py ${BASE8BIT}.dat
# When finished, compare outputs from prepfolds, single pulse search, compare file size, etc.

# Next, do the 2-bit conversion and analysis, first using the scales and offsets:
BASE2BIT=${BASE}_2bit
psrfits_quick_bandpass.py ${BASE}.fits
${PSRFITSSUBBANDLOC}psrfits_subband -outbits 2 -o ${BASE2BIT} -bandpass ${BASE}.fits.bandpass ${BASE}.fits
mv ${BASE2BIT}_0001.fits ${BASE2BIT}.fits
rfifind -time 1.0 -o ${BASE2BIT} ${BASE2BIT}.fits
prepdata -dm ${DM} -numout ${FACTOR} -o ${BASE2BIT} -mask ${BASE2BIT}_rfifind.mask ${BASE2BIT}.fits
realfft ${BASE2BIT}.dat
accelsearch -zmax ${ZMAX} ${BASE2BIT}.fft
#prepfold -accelfile ${BASE2BIT}_ACCEL_0.cand -accelcand 1 -mask *.mask ${BASE2BIT}.dat
prepfold -nosearch -fine -o ${BASE2BIT} -p ${PERIOD} -pdd ${PDOT} -dm ${DM} -mask *${BASE2BIT}.mask ${BASE2BIT}.fits
single_pulse_search.py ${BASE2BIT}.dat
# When finished, compare outputs from prepfolds, single pulse search, compare file size, etc.

# Next, do the 2-bit conversion and analysis, now WITHOUT scales and offsets:
BASE2BITNOSCOFF=${BASE}_2bit_noscoff
psrfits_quick_bandpass.py ${BASE}.fits
${PSRFITSSUBBANDLOC}psrfits_subband -outbits 2 -o ${BASE2BITNOSCOFF} -bandpass ${BASE}.fits.bandpass ${BASE}.fits
mv ${BASE2BITNOSCOFF}_0001.fits ${BASE2BITNOSCOFF}.fits
rfifind -time 1.0 -noscales -nooffsets -o ${BASE2BITNOSCOFF} ${BASE2BITNOSCOFF}.fits
prepdata -dm ${DM} -numout ${FACTOR} -noscales -nooffsets -o ${BASE2BITNOSCOFF} -mask ${BASE2BITNOSCOFF}_rfifind.mask ${BASE2BITNOSCOFF}.fits
realfft ${BASE2BITNOSCOFF}.dat
accelsearch -zmax ${ZMAX} ${BASE2BITNOSCOFF}.fft
#prepfold -accelfile ${BASE2BITNOSCOFF}_ACCEL_0.cand -noscales -nooffsets -accelcand 1 -mask *.mask ${BASE2BITNOSCOFF}.dat
prepfold -nosearch -fine -o ${BASE2BITNOSCOFF} -noscales -nooffsets -p ${PERIOD} -pdd ${PDOT} -dm ${DM} -mask *${BASE2BITNOSCOFF}*.mask ${BASE2BITNOSCOFF}.fits
single_pulse_search.py ${BASE2BITNOSCOFF}.dat
# When finished, compare outputs from prepfolds, single pulse search, compare file size, etc.

# Next, do the 4-bit conversion and analysis, using the scales and offsets:
BASE4BIT=${BASE}_4bit
psrfits_quick_bandpass.py ${BASE}.fits
${PSRFITSSUBBANDLOC}psrfits_subband -outbits 4 -o ${BASE4BIT} -bandpass ${BASE}.fits.bandpass ${BASE}.fits
mv ${BASE4BIT}_0001.fits ${BASE4BIT}.fits
rfifind -time 1.0 -o ${BASE4BIT} ${BASE4BIT}.fits
prepdata -dm ${DM} -numout ${FACTOR} -o ${BASE4BIT} -mask ${BASE4BIT}_rfifind.mask ${BASE4BIT}.fits
realfft ${BASE4BIT}.dat
accelsearch -zmax ${ZMAX} ${BASE4BIT}.fft
#prepfold -accelfile ${BASE4BIT}_ACCEL_0.cand -accelcand 1 -mask *.mask ${BASE4BIT}.dat
prepfold -nosearch -fine -o ${BASE4BIT} -p ${PERIOD} -pdd ${PDOT} -dm ${DM} -mask *${BASE4BIT}*.mask ${BASE4BIT}.fits
single_pulse_search.py ${BASE4BIT}.dat
# When finished, compare outputs from prepfolds, single pulse search, compare file size, etc.
