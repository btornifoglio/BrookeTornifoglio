#!/usr/bin/env bash

fslmaths images/output/mri_slice.nii.gz \
         -mul \
         images/output/mri_mask.nii.gz \
         images/output/mri_masked.nii.gz
