#!/usr/bin/env bash

slice_id=204

fslroi images/input/mri.nii.gz \
       images/output/mri_slice.nii.gz \
       0 -1 0 -1 $slice_id 1 0 1

fslmaths images/input/mri.nii.gz \
         -sub \
         images/input/mri.nii.gz \
         images/output/mri_mask.nii.gz
