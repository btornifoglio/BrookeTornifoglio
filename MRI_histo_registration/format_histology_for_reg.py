#!/usr/bin/env python3
import SimpleITK as sitk

# Histology Formatting
print('Formatting Histology for registration')

# convert .nii.gz to MetaImage (.mhd)
brightField = sitk.ReadImage('images/output/histology_BF_manual.tiff')
sitk.WriteImage(brightField, 'images/output/histology_BF_manual.mhd')

elastinSAF = sitk.ReadImage('images/output/histology_SAF_manual.tiff')
sitk.WriteImage(elastinSAF, 'images/output/histology_SAF_manual.mhd')

# make new BrightField .mhd file to correct alignment and scaling
f = open('images/output/histology_BF_manual_NEW.mhd', "w+")
f.write("\
ObjectType = Image\n\
NDims = 2\n\
BinaryData = True\n\
BinaryDataByteOrderMSB = False\n\
CompressedData = False\n\
TransformMatrix = 1 0 0 1\n\
Offset = 0 0\n\
CenterOfRotation = 0 0\n\
ElementSpacing = 0.1572 0.1572\n\
DimSize = 1905 1905\n\
ElementNumberOfChannels = 3\n\
AnatomicalOrientation = ??\n\
ElementType = MET_UCHAR\n\
ElementDataFile = histology_BF_manual.raw")
f.close()

brightFieldNew = sitk.ReadImage('images/output/histology_BF_manual_NEW.mhd')
sitk.WriteImage(brightFieldNew, 'images/output/histology_BF_manual_NEW.nii.gz')

# make new SAF .mhd file to correct alignment and scaling
f = open('images/output/histology_SAF_manual_NEW.mhd', "w+")
f.write("\
ObjectType = Image\n\
NDims = 2\n\
BinaryData = True\n\
BinaryDataByteOrderMSB = False\n\
CompressedData = False\n\
TransformMatrix = 1 0 0 1\n\
Offset = 0 0\n\
CenterOfRotation = 0 0\n\
ElementSpacing = 0.1572 0.1572\n\
DimSize = 1905 1905\n\
ElementNumberOfChannels = 3\n\
AnatomicalOrientation = ??\n\
ElementType = MET_UCHAR\n\
ElementDataFile = histology_SAF_manual.raw")
f.close()

elastinSAFNew = sitk.ReadImage('images/output/histology_SAF_manual_NEW.mhd')
sitk.WriteImage(elastinSAFNew, 'images/output/histology_SAF_manual_NEW.nii.gz')
