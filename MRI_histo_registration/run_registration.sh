#!/usr/bin/env bash

# needed to get elastix to work on my computer (Mac)
export DYLD_LIBRARY_PATH=/usr/local/elastix-5.0.0-mac/lib:$DYLD_LIBRARY_PATH

# make output directory for brightfield registrations
mkdir images/output/reg_brightfield_to_mri

# register Brightfield histology to MRI
elastix -f images/output/mri_masked_NEW.mhd \
        -m images/output/histology_BF_manual_NEW.mhd  \
        -out images/output/reg_brightfield_to_mri \
        -p parameters_BSpline.txt


# make output directory for SAF registrations
mkdir images/output/reg_saf_to_mri

# copy and format transform parameters
cp images/output/reg_brightfield_to_mri/TransformParameters.0.txt \
    images/output/reg_saf_to_mri/TransformParameters.0+.txt

sed 's/FinalBSplineInterpolationOrder 3/FinalBSplineInterpolationOrder 0/' \
    images/output/reg_saf_to_mri/TransformParameters.0+.txt

transformix -in images/output/histology_SAF_manual_NEW.nii.gz \
            -out images/output/reg_saf_to_mri \
            -tp images/output/reg_saf_to_mri/TransformParameters.0+.txt \
            -def all

# copy and rename registered histology files
cp images/output/reg_brightfield_to_mri/result.0.nii.gz \
    images/output/histology_BF_to_mri.nii.gz

cp images/output/reg_saf_to_mri/result.nii.gz \
    images/output/histology_SAF_to_mri.nii.gz

# view
fsleyes images/output/mri_masked_NEW.nii.gz \
        images/output/histology_BF_to_mri.nii.gz \
        images/output/histology_SAF_to_mri.nii.gz
