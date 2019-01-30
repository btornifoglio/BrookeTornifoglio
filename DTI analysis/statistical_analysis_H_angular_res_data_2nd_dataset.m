pe_dir = 'dwi_middle_slices';

fa=load_nii(sprintf('%s_FA.nii',pe_dir));fa=fa.img;fa=reshape(fa,1,[]);
md=load_nii(sprintf('%s_MD.nii',pe_dir));md=md.img;md=reshape(md,1,[]);
cl=load_nii(sprintf('%s_CL.nii',pe_dir));cl=cl.img;cl=reshape(cl,1,[]);
cp=load_nii(sprintf('%s_CP.nii',pe_dir));cp=cp.img;cp=reshape(cp,1,[]);
cs=load_nii(sprintf('%s_CS.nii',pe_dir));cs=cs.img;cs=reshape(cs,1,[]);
%%
i=find (fa>0 & fa <1);
fa=fa(i);fa=fa';
md=md(i);md=md';md(md>=3e-3)=3e-3;
cl=cl(i);cl=cl';
cp=cp(i);cp=cp';
cs=cs(i);cs=cs';
%%
figure
subplot(3,2,1)
histogram(cl,50,'Normalization','probability');ylabel('VF');xlabel('CL')
subplot(3,2,2)
histogram(fa,50,'Normalization','probability');ylabel('VF');xlabel('FA')
subplot(3,2,3)
histogram(cp,50,'Normalization','probability');ylabel('VF');xlabel('C_P')
subplot(3,2,4)
histogram(md,50,'Normalization','probability');ylabel('VF');xlabel('MD'),xlim([0 3e-3])
subplot(3,2,5)
histogram(cs,50,'Normalization','probability');ylabel('VF');xlabel('C_S')
%%
x=(1-cl+cp)/1.732;
y=(1-cl-cp);
% interpolating between 0 and 1
Xi=scaledata(x,0,1);
Yi=scaledata(y,0,1);
vq1=interp1(x,y,Xi);
% w = [0 1 .5 0];
% e = [0 0 1 0];
figure
plot(x,y,'.')
xlim([0 1]); ylim([0 1]);
title('Decell')

%% dataset 2
pe_dir = 'dwi_pa_noise_gibbs_corrected_36';

fa_2=load_nii(sprintf('%s_FA.nii',pe_dir));fa_2=fa_2.img;fa_2=reshape(fa_2,1,[]);
md_2=load_nii(sprintf('%s_MD.nii',pe_dir));md_2=md_2.img;md_2=reshape(md_2,1,[]);
cl_2=load_nii(sprintf('%s_CL.nii',pe_dir));cl_2=cl_2.img;cl_2=reshape(cl_2,1,[]);
cp_2=load_nii(sprintf('%s_CP.nii',pe_dir));cp_2=cp_2.img;cp_2=reshape(cp_2,1,[]);
cs_2=load_nii(sprintf('%s_CS.nii',pe_dir));cs_2=cs_2.img;cs_2=reshape(cs_2,1,[]);
%%
i=find (fa_2>0 & fa_2 <1);
fa_2=fa_2(i);fa_2=fa_2';
md_2=md_2(i);md_2=md_2';md_2(md_2>=3e-3)=3e-3;
cl_2=cl_2(i);cl_2=cl_2';
cp_2=cp_2(i);cp_2=cp_2';
cs_2=cs_2(i);cs_2=cs_2';
%%
figure
subplot(3,2,1)
histogram(cl_2,50,'Normalization','probability');ylabel('VF');xlabel('CL')
subplot(3,2,2)
histogram(fa_2,50,'Normalization','probability');ylabel('VF');xlabel('FA')
subplot(3,2,3)
histogram(cp_2,50,'Normalization','probability');ylabel('VF');xlabel('C_P')
subplot(3,2,4)
histogram(md_2,50,'Normalization','probability');ylabel('VF');xlabel('MD'),xlim([0 3e-3])
subplot(3,2,5)
histogram(cs_2,50,'Normalization','probability');ylabel('VF');xlabel('C_S')
%%
x_2=(1-cl_2+cp_2)/1.732;
y_2=(1-cl_2-cp_2);
% interpolating between 0 and 1
Xi_2=scaledata(x_2,0,1.2);
Yi_2=scaledata(y_2,0,1);
vq1=interp1(x_2,y_2,Xi_2);
figure
plot(x_2,y_2,'.')
xlim([0 1]); ylim([0 1]);
title('Anisotropic')