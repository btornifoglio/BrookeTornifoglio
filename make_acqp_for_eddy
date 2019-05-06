#!/bin/csh
# Script to make acqparams file for input into open_eddymp
# This file makes alot of presumptions and needs to be edited for custom acqs
# See https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/topup/TopupUsersGuide#A--datain
# This parameter specifies a text-file that contains information about how the
# volumes in --imain were acquired. The three first columns specify the
# direction of the phase-encoding (x y z, y-direction (typically corresponding
# to the anterior-posterior direction). The fourth column is the total readout
# time (defined as the time from the centre of the first echo to the centre of
# the last) in seconds. If your readout time is identical for all acquisitions
# you don't neccessarily have to specify a valid value in this column (you can
# e.g. just set it to 1), but if you do specify correct values the estimated
# field will be correctly scaled in Hz, which may be a useful sanity check.
# Also note that this value corresponds to the time you would have had had you
# collected all k-space lines. I.e. let us say you collect a 96x96 matrix with
# 1ms dwell-time (time between centres of consecutive echoes) and let us further
# say that you have opted for partial k-space (in order to reduce the echo time)
# , collecting only 64 echoes. In this case the level of distortion will be
# identical to what it would have been had you collected all 96 echoes, and you
# should put 0.095 in the fourth column.
# Alan Stone (TCD), 22/10/2018

# Number of volumes in DTI dataset
# This can determined using fslnvols your_nifti_dataset.nii.gz
set num_vols = `fslnvols $1`

# loop index
set i = 1

# clear txt file
echo > acqparams.txt

# loop
while ( $i < $num_vols + 1 )
  # x-direction y-direction z-direction readout-time
  echo 0 1 0 0.00064 >> acqparams.txt
  @ i++
end
