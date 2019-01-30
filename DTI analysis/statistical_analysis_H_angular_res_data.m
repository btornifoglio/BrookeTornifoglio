clc
clear all
close all
%% dti indices
pe_dir = 'dwi_pa_noise_gibbs_corrected_34';

fa=load_nii(sprintf('%s_FA.nii',pe_dir));fa=fa.img;fa=reshape(fa,1,[]);
md=load_nii(sprintf('%s_MD.nii',pe_dir));md=md.img;md=reshape(md,1,[]);
cl=load_nii(sprintf('%s_CL.nii',pe_dir));cl=cl.img;cl=reshape(cl,1,[]);
cp=load_nii(sprintf('%s_CP.nii',pe_dir));cp=cp.img;cp=reshape(cp,1,[]);
cs=load_nii(sprintf('%s_CS.nii',pe_dir));cs=cs.img;cs=reshape(cs,1,[]);

%mask=load_nii('MASK.nii');mask=double(mask.img);
% %% dki indices
% ka=load_nii('dwi_dki_KA.nii');ka=ka.img;ka=reshape(ka,1,[]);
% mk=load_nii('dwi_dki_MK.nii');mk=mk.img;mk=reshape(mk,1,[]);
% ak=load_nii('dwi_dki_AK.nii');ak=ak.img;ak=reshape(ak,1,[]);
% rk=load_nii('dwi_dki_RK.nii');rk=rk.img;rk=reshape(rk,1,[]);
% tot=load_nii('dwi_dki_TORT.nii');tot=tot.img;tot=reshape(tot,1,[]);
%%
%{
m1=fa;
m2=m1;
m3=m1;
%cl(cl<0.4)=0;
m1(cl>0.4)=1;m1=m1.*mask; 
%cp(cp>0.2)=0;
m2(cp<0.2)=1;m2=m2.*mask;
%cs(cs>0.35)=0;
m3(cs<0.35)=1;m3=m3.*mask;
%%
M=mask.*maskk;
imagesc(M(:,:,5))
figure
imagesc(cl(:,:,5))
figure
imagesc(cp(:,:,5))
figure
imagesc(cs(:,:,5))
%}
%% 
i=find (fa>0 & fa <1);
fa=fa(i);fa=fa';
md=md(i);md=md';md(md>=3e-3)=3e-3;
cl=cl(i);cl=cl';
cp=cp(i);cp=cp';
cs=cs(i);cs=cs';
% ka=ka(i);ka=ka';ka(ka>=5)=5;ka(ka<0)=0;
% mk=mk(i);mk=mk';mk(mk>=5)=5; mk(mk<0)=0;
% ak=ak(i);ak=ak';ak(ak>=5)=5;ak(ak<0)=0;
% rk=rk(i);rk=rk';rk(rk>=5)=5;rk(rk<0)=0;
%tot=tot(i);tot=tot';tot(tot>=5)=5;
%%
figure
subplot(3,2,1)
histogram(cl,50,'Normalization','probability');ylabel('VF');xlabel('CL')
xlim([0 0.35])
subplot(3,2,2)
histogram(fa,50,'Normalization','probability');ylabel('VF');xlabel('FA')
xlim([ 0 0.3])
subplot(3,2,3)
histogram(cp,50,'Normalization','probability');ylabel('VF');xlabel('C_P')
xlim([0 0.2])
subplot(3,2,4)
histogram(md,50,'Normalization','probability');ylabel('VF');xlabel('MD'),xlim([0 3e-3])
subplot(3,2,5)
histogram(cs,50,'Normalization','probability');ylabel('VF');xlabel('C_S')
xlim([0 1])
% figure
% subplot(3,2,1)
% histogram(ka,50,'Normalization','probability');ylabel('VF');xlabel('KA')
% subplot(3,2,2)
% histogram(mk,50,'Normalization','probability');ylabel('VF');xlabel('MK')
% subplot(3,2,3)
% histogram(ak,50,'Normalization','probability');ylabel('VF');xlabel('AK')
% subplot(3,2,4)
% histogram(rk,50,'Normalization','probability');ylabel('VF');xlabel('RK')%,xlim([0 3e-3])
% subplot(3,2,5)
% histogram(tot,50,'Normalization','probability');ylabel('VF');xlabel('TORT')
%% The 3P plots
x=(1-cl+cp)/1.732; %cs
y=(1-cl-cp); %cs
% interpolating between 0 and 1
Xi=scaledata(x,0,1);
Yi=scaledata(y,0,1);
vq1=interp1(x,y,Xi); 
figure
w = [0 1 .5 0]; %manually put in triangle
e = [0 0 1 0];
plot(x,y,'.', w, e, '-')
xlim([0 1]); ylim([0 1]);
figure
plot(Xi,Yi,'.', w, e, '-')
%% writing to excel
filename='dti_and_dki_indices_HAR.xlsx';
C1={'FA'};
C2={'MD'};
C3={'CL'};
C4={'CP'};
C5={'CS'};

C6={'KA'};
C7={'MK'};
C8={'AK'};
C9={'RK'};
C10={'TORT'};
xlswrite(filename,fa,1,'A2')
xlswrite(filename,C1,1,'A1')
xlswrite(filename,md,1,'B2')
xlswrite(filename,C2,1,'B1')
xlswrite(filename,cl,1,'C2')
xlswrite(filename,C3,1,'C1')

xlswrite(filename,cp,1,'D2')
xlswrite(filename,C4,1,'D1')
xlswrite(filename,cs,1,'E2')
xlswrite(filename,C5,1,'E1')
xlswrite(filename,ka,1,'F2')
xlswrite(filename,C6,1,'F1')
%---------------------------------------------------
xlswrite(filename,mk,1,'G2')
xlswrite(filename,C7,1,'G1')
xlswrite(filename,ak,1,'H2')
xlswrite(filename,C8,1,'H1')
xlswrite(filename,rk,1,'I2')
xlswrite(filename,C9,1,'I1')

xlswrite(filename,tot,1,'J2')
xlswrite(filename,C10,1,'J1')

