#!/bin/bash

export BLADERF_SEARCH_DIR="/data" 

brdc_file_year="brdc$(date -u +%j0.%g)n"

if [ ! -e "$brdc_file_year" ]; then
 wget --no-check-certificate "ftps://gdc.cddis.eosdis.nasa.gov/gnss/data/daily/$(date -u +%Y)/brdc/brdc$(date -u +%j0.%g)n.gz" -O ${brdc_file_year}.gz
	if [ ! -e "${brdc_file_year}.gz" ]; then
		echo "Can't download BRDC file"
		exit
	fi
	uncompress ${brdc_file_year}.gz
fi

./bladegps -e $brdc_file_year -t `date -u +'%Y/%m/%d,%H:%M:%S'` $*
#bladegps -e $brdc_file_year -t `date -u +%Y/%m/%d,+%X` $*
