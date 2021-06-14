#!/usr/bin/env python3
import SimpleITK as sitk

# MRI Formatting
print('Formatting MRI for registration')

# convert .nii.gz to MetaImage (.mhd)
mriMasked = sitk.ReadImage('images/output/mri_masked.nii.gz')
sitk.WriteImage(mriMasked, 'images/output/mri_masked.mhd')

# make new .mhd files to correct alignment and scaling
f = open('images/output/mri_masked_NEW.mhd', "w+")
f.write("\
ObjectType = Image\n\
NDims = 2\n\
BinaryData = True\n\
BinaryDataByteOrderMSB = False\n\
CompressedData = False\n\
TransformMatrix = 1 0 0 1\n\
Offset = 0 0\n\
CenterOfRotation = 0 0\n\
ElementSpacing = 1.17 1.17\n\
DimSize = 256 256\n\
AnatomicalOrientation = ??\n\
ElementType = MET_DOUBLE\n\
ElementDataFile = mri_masked.raw")
f.close()

mriMaskedNew = sitk.ReadImage('images/output/mri_masked_NEW.mhd')
sitk.WriteImage(mriMaskedNew, 'images/output/mri_masked_NEW.nii.gz')
