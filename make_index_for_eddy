#!/bin/csh
# Script to make index file for input into open_eddymp
# this assumes all volumes acquired with phase encoding in same direction
# see https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/eddy/UsersGuide#A--index
# Alan Stone (TCD), 18/10/2018

# Number of volumes in DTI dataset
# This can determined using fslnvols your_nifti_dataset.nii.gz
set num_vols = `fslnvols $1`

# loop index
set i = 0
set master_array =

# loop
while ( $i < $num_vols )
  set master_array = ( $master_array 1 )
  @ i++
end

echo $master_array > index.txt
