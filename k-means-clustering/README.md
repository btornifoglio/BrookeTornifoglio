# Comparison of *ex vivo* MRI and histology using k-means clustering

## Data – example MRI & Histology
Example MRI and histology images are contained in *hist_mri_data.mat*

For MRI, *hist_mri_data.mat* contains magnitude, QSM and R2* MRI for a single slice in a cadaver carotid artery. These images are all derived from the same MRI acquisition (3D multi-echo gradient-echo) so they are inherently registered.

For histology, *hist_mri_data.mat* contains Brightfield and Standard Area Fraction (SAF) images. A Verhoeff's stain was used that identifies elastin. The SAF map was calculated in quPath. Histology images were registered to MRI using elastix and some home-baked scripts.

## Running analysis
The analysis script (*run_kmeans_analysis.m*) relies on the matlab function [imsegkmeans](mathworks.com/help/images/ref/imsegkmeans.html). This was introduced in Matlab R2018b so you will need this version or later to run analysis.
