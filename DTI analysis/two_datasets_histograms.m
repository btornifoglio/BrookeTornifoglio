%% load in all masked niftis
clear 
clc
% first data set
pe_dir = 'masked_native';
fa=load_nii(sprintf('%s_FA.nii',pe_dir));fa=fa.img;fa=reshape(fa,1,[]);
md=load_nii(sprintf('%s_MD.nii',pe_dir));md=md.img;md=reshape(md,1,[]);
cl=load_nii(sprintf('%s_CL.nii',pe_dir));cl=cl.img;cl=reshape(cl,1,[]);
cp=load_nii(sprintf('%s_CP.nii',pe_dir));cp=cp.img;cp=reshape(cp,1,[]);
cs=load_nii(sprintf('%s_CS.nii',pe_dir));cs=cs.img;cs=reshape(cs,1,[]);
%adc=load_nii(sprintf('%s_ADCs.nii',pe_dir));adc=adc.img;adc=reshape(adc,1,[]);
l1=load_nii(sprintf('%s_L1.nii',pe_dir));l1=l1.img;l1=reshape(l1,1,[]);
l2=load_nii(sprintf('%s_L2.nii',pe_dir));l2=l2.img;l2=reshape(l2,1,[]);
l3=load_nii(sprintf('%s_L3.nii',pe_dir));l3=l3.img;l3=reshape(l3,1,[]);
ra=load_nii(sprintf('%s_RA.nii',pe_dir));ra=ra.img;ra=reshape(ra,1,[]);
rd=load_nii(sprintf('%s_RD.nii',pe_dir));rd=rd.img;rd=reshape(rd,1,[]);

%%
% second data set 
pe_dir = 'masked_decell';
fa_2=load_nii(sprintf('%s_FA.nii',pe_dir));fa_2=fa_2.img;fa_2=reshape(fa_2,1,[]);
md_2=load_nii(sprintf('%s_MD.nii',pe_dir));md_2=md_2.img;md_2=reshape(md_2,1,[]);
cl_2=load_nii(sprintf('%s_CL.nii',pe_dir));cl_2=cl_2.img;cl_2=reshape(cl_2,1,[]);
cp_2=load_nii(sprintf('%s_CP.nii',pe_dir));cp_2=cp_2.img;cp_2=reshape(cp_2,1,[]);
cs_2=load_nii(sprintf('%s_CS.nii',pe_dir));cs_2=cs_2.img;cs_2=reshape(cs_2,1,[]);
%adc_2=load_nii(sprintf('%s_ADC.nii',pe_dir));adc_2=adc_2.img;adc_2=reshape(adc_2,1,[]);
l1_2=load_nii(sprintf('%s_L1.nii',pe_dir));l1_2=l1_2.img;l1_2=reshape(l1_2,1,[]);
l2_2=load_nii(sprintf('%s_L2.nii',pe_dir));l2_2=l2_2.img;l2_2=reshape(l2_2,1,[]);
l3_2=load_nii(sprintf('%s_L3.nii',pe_dir));l3_2=l3_2.img;l3_2=reshape(l3_2,1,[]);
ra_2=load_nii(sprintf('%s_RA.nii',pe_dir));ra_2=ra_2.img;ra_2=reshape(ra_2,1,[]);
rd_2=load_nii(sprintf('%s_RD.nii',pe_dir));rd_2=rd_2.img;rd_2=reshape(rd_2,1,[]);

%%
% third data set 
pe_dir = 'masked_elastase';
fa_3=load_nii(sprintf('%s_FA.nii',pe_dir));fa_3=fa_3.img;fa_3=reshape(fa_3,1,[]);
md_3=load_nii(sprintf('%s_MD.nii',pe_dir));md_3=md_3.img;md_3=reshape(md_3,1,[]);
cl_3=load_nii(sprintf('%s_CL.nii',pe_dir));cl_3=cl_3.img;cl_3=reshape(cl_3,1,[]);
cp_3=load_nii(sprintf('%s_CP.nii',pe_dir));cp_3=cp_3.img;cp_3=reshape(cp_3,1,[]);
cs_3=load_nii(sprintf('%s_CS.nii',pe_dir));cs_3=cs_3.img;cs_3=reshape(cs_3,1,[]);
%adc_2=load_nii(sprintf('%s_ADC.nii',pe_dir));adc_2=adc_2.img;adc_2=reshape(adc_2,1,[]);
l1_3=load_nii(sprintf('%s_L1.nii',pe_dir));l1_3=l1_3.img;l1_3=reshape(l1_3,1,[]);
l2_3=load_nii(sprintf('%s_L2.nii',pe_dir));l2_3=l2_3.img;l2_3=reshape(l2_3,1,[]);
l3_3=load_nii(sprintf('%s_L3.nii',pe_dir));l3_3=l3_3.img;l3_3=reshape(l3_3,1,[]);
ra_3=load_nii(sprintf('%s_RA.nii',pe_dir));ra_3=ra_3.img;ra_3=reshape(ra_3,1,[]);
rd_3=load_nii(sprintf('%s_RD.nii',pe_dir));rd_3=rd_3.img;rd_3=reshape(rd_3,1,[]);

%% 
% fourth data set 
pe_dir = 'masked_collagenase';
fa_4=load_nii(sprintf('%s_FA.nii',pe_dir));fa_4=fa_4.img;fa_4=reshape(fa_4,1,[]);
md_4=load_nii(sprintf('%s_MD.nii',pe_dir));md_4=md_4.img;md_4=reshape(md_4,1,[]);
cl_4=load_nii(sprintf('%s_CL.nii',pe_dir));cl_4=cl_4.img;cl_4=reshape(cl_4,1,[]);
cp_4=load_nii(sprintf('%s_CP.nii',pe_dir));cp_4=cp_4.img;cp_4=reshape(cp_4,1,[]);
cs_4=load_nii(sprintf('%s_CS.nii',pe_dir));cs_4=cs_4.img;cs_4=reshape(cs_4,1,[]);
%adc_2=load_nii(sprintf('%s_ADC.nii',pe_dir));adc_2=adc_2.img;adc_2=reshape(adc_2,1,[]);
l1_4=load_nii(sprintf('%s_L1.nii',pe_dir));l1_4=l1_4.img;l1_4=reshape(l1_4,1,[]);
l2_4=load_nii(sprintf('%s_L2.nii',pe_dir));l2_4=l2_4.img;l2_4=reshape(l2_4,1,[]);
l3_4=load_nii(sprintf('%s_L3.nii',pe_dir));l3_4=l3_4.img;l3_4=reshape(l3_4,1,[]);
ra_4=load_nii(sprintf('%s_RA.nii',pe_dir));ra_4=ra_4.img;ra_4=reshape(ra_4,1,[]);
rd_4=load_nii(sprintf('%s_RD.nii',pe_dir));rd_4=rd_4.img;rd_4=reshape(rd_4,1,[]);

%% remove zeros to be left with only the parameters in masked area
fa = nonzeros(fa);fa_2 = nonzeros(fa_2);fa_3 = nonzeros(fa_3);
fa_4 = nonzeros(fa_4);
md = nonzeros(md);md_2 = nonzeros(md_2);md_3 = nonzeros(md_3);
md_4 = nonzeros(md_4);
cl = nonzeros(cl);cl_2 = nonzeros(cl_2);cl_3 = nonzeros(cl_3);
cl_4 = nonzeros(cl_4);
cp = nonzeros(cp);cp_2 = nonzeros(cp_2);cp_3 = nonzeros(cp_3);
cp_4 = nonzeros(cp_4);
cs = nonzeros(cs);cs_2 = nonzeros(cs_2);cs_3 = nonzeros(cs_3);
cs_4 = nonzeros(cs_4);
l1 = nonzeros(l1);l1_2 = nonzeros(l1_2);l1_3 = nonzeros(l1_3);
l1_4 = nonzeros(l1_4);
l2 = nonzeros(l2);l2_2 = nonzeros(l2_2);l2_3 = nonzeros(l2_3);
l2_4 = nonzeros(l2_4);
l3 = nonzeros(l3);l3_2 = nonzeros(l3_2);l3_3 = nonzeros(l3_3);
l3_4 = nonzeros(l3_4);
ra = nonzeros(ra);ra_2 = nonzeros(ra_2);ra_3 = nonzeros(ra_3);
ra_4 = nonzeros(ra_4);
rd = nonzeros(rd);rd_2 = nonzeros(rd_2);rd_3 = nonzeros(rd_3);
rd_4 = nonzeros(rd_4);

%% histograms of two datasets
% note which data set is original and data_2 when using the legend


figure();
histogram(fa,75,'Normalization','probability'); title('FA');
hold on 
histogram(fa_2,75,'Normalization', 'probability');
hold on
histogram(fa_3,75,'Normalization', 'probability');
hold on 
histogram(fa_4,75,'Normalization', 'probability');
xlim([0 1]); 
legend('Native', 'Decell', 'Elastase', 'Collagenase')

figure();
histogram(md,50,'Normalization','probability');title('MD')
hold on
histogram(md_2,50,'Normalization','probability');
hold on
histogram(md_3,50,'Normalization','probability');
hold on
histogram(md_4,50,'Normalization','probability');
xlim([0.0001 .002]); 
legend('Native', 'Decell', 'Elastase', 'Collagenase')


figure();
histogram(l1,50,'Normalization','probability');title('L1')
hold on 
histogram(l1_2,50,'Normalization','probability');
hold on
histogram(l1_3,50,'Normalization','probability');
hold on
histogram(l1_4,50,'Normalization','probability');
xlim([0.0001 .002]); 
legend('Native', 'Decell', 'Elastase', 'Collagenase')


figure();
histogram(l2,50,'Normalization','probability');title('L2')
hold on
histogram(l2_2,50,'Normalization','probability');
hold on
histogram(l2_3,50,'Normalization','probability');
hold on
histogram(l2_4,50,'Normalization','probability');
xlim([0.0001 .002]); 
legend('Native', 'Decell', 'Elastase', 'Collagenase')


figure();
histogram(l3,50,'Normalization','probability');title('L3')
hold on
histogram(l3_2,50,'Normalization','probability');
hold on
histogram(l3_3,50,'Normalization','probability');
hold on
histogram(l3_4,50,'Normalization','probability');
xlim([0.0001 .002]); 
legend('Native', 'Decell', 'Elastase', 'Collagenase')


figure();
histogram(cl,50,'Normalization','probability');title(' CL')
hold on
histogram(cl_2,50,'Normalization','probability');
hold on
histogram(cl_3,50,'Normalization','probability');
hold on
histogram(cl_4,50,'Normalization','probability');
xlim([0 1]); 
legend('Native', 'Decell', 'Elastase', 'Collagenase')


figure();
histogram(cp,50,'Normalization','probability');title('CP')
hold on
histogram(cp_2,50,'Normalization','probability');
hold on
histogram(cp_3,50,'Normalization','probability');
hold on
histogram(cp_4,50,'Normalization','probability');
xlim([0 1]); 
legend('Native', 'Decell', 'Elastase', 'Collagenase')


figure();
histogram(cs,50,'Normalization','probability');title('CS')
hold on
histogram(cs_2,50,'Normalization','probability');
hold on
histogram(cs_3,50,'Normalization','probability');
hold on
histogram(cs_4,50,'Normalization','probability');
xlim([0 1]); 
legend('Native', 'Decell', 'Elastase', 'Collagenase')


figure();
histogram(ra,50,'Normalization','probability');title('RA')
hold on
histogram(ra_2,50,'Normalization','probability');
hold on
histogram(ra_3,50,'Normalization','probability');
hold on
histogram(ra_4,50,'Normalization','probability');
xlim([0.01 01]); 
legend('Native', 'Decell', 'Elastase', 'Collagenase')


figure();
histogram(rd,50,'Normalization','probability');title('RD')
hold on
histogram(rd_2,50,'Normalization','probability');
hold on
histogram(rd_3,50,'Normalization','probability');
hold on
histogram(rd_4,50,'Normalization','probability');
xlim([0.0001 0.002]); 
legend('Native', 'Decell', 'Elastase', 'Collagenase')

%% table of means
metrics = ['fa'; 'md'; 'ra'; 'rd'; 'cl'; 'cp'; 'cs'; 'l1'; 'l2'; 'l3'];

native = [mean(fa) std(fa); mean(md) std(md); mean(ra) std(ra); mean(rd)...
    std(rd); mean(cl) std(cl); mean(cp) std(cp); mean(cs) std(cs);...
    mean(l1) std(l1); mean(l2) std(l2); mean(l3) std(l3)];

decell = [mean(fa_2) std(fa_2); mean(md_2) std(md_2); mean(ra_2)...
    std(ra_2); mean(rd_2) std(rd_2); mean(cl_2) std(cl_2); mean(cp_2)...
    std(cp_2); mean(cs_2) std(cs_2); mean(l1_2) std(l1_2); mean(l2_2)...
    std(l2_2); mean(l3_2) std(l3_2)];

elastase = [mean(fa_3) std(fa_3); mean(md_3) std(md_3); mean(ra_3)...
    std(ra_3); mean(rd_3) std(rd_3); mean(cl_3) std(cl_3); mean(cp_3)...
    std(cp_3); mean(cs_3) std(cs_3); mean(l1_3) std(l1_3); mean(l2_3)...
    std(l2_3); mean(l3_3) std(l3_3)];

collagenase = [mean(fa_4) std(fa_4) ; mean(md_4) std(md_4); mean(ra_4)...
    std(ra_4); mean(rd_4) std(rd_4); mean(cl_4) std(cl_4); mean(cp_4)...
    std(cp_4); mean(cs_4) std(cs_4); mean(l1_4) std(l1_4); mean(l2_4)...
    std(l2_4); mean(l3_4) std(l3_4)];

T = table(metrics, native, decell, elastase, collagenase);

%% box plot values 
native_box_plot = [quantile(l3, [.25 .75]) median(l3)];
decell_box_plot = [quantile(l3_2, [.25 .75]) median(l3_2)];
elastase_box_plot = [quantile(l3_3, [.25 .75]) median(l3_3)];
collagenase_box_plot = [quantile(l3_4, [.25 .75]) median(l3_4)];
%% bar graph with error bars
x = categorical({'native', 'decell', 'elastase', 'collagenase'});
fa_data = [mean(fa) mean(fa_2) mean(fa_3) mean(fa_4)];
errorhigh = [std(fa) std(fa_2) std(fa_3) std(fa_4)];
errorlow = [std(fa) std(fa_2) std(fa_3) std(fa_4)];

bar(x,fa_data)
hold on
er = errorbar(x,fa_data,errorlow,errorhigh);
er.Color=[0 0 0];
er.LineStyle = 'none';

figure()
x = categorical({'native', 'decell', 'elastase', 'collagenase'});
md_data = [mean(md) mean(md_2) mean(md_3) mean(md_4)];
errorhigh = [std(md) std(md_2) std(md_3) std(md_4)];
errorlow = [std(md) std(md_2) std(md_3) std(md_4)];

bar(x,md_data)
hold on
er = errorbar(x,md_data,errorlow,errorhigh);
er.Color=[0 0 0];
er.LineStyle = 'none';
%% box plots
figure()
boxplot(fa);title('Native FA');ylim([0 1]);
figure()
boxplot(fa_2);title('Decell FA');ylim([0 1]);
figure()
boxplot(fa_3);title('Elastase FA');ylim([0 1]);
figure()
boxplot(fa_4);title('Collagenase FA');ylim([0 1]);
%% individual histograms:
figure();
histogram(fa_2,50,'Normalization','probability'); title('Native FA');
xlim([0 1]); 

figure();
histogram(md_2,50,'Normalization','probability');title('Native MD')
xlim([0.0001 .002]); 

figure();
histogram(l1_2,50,'Normalization','probability');title('Native L1')
xlim([0.0001 .002]); 

figure();
histogram(l2_2,50,'Normalization','probability');title('Native L2')
xlim([0.0001 .002]); 

figure();
histogram(l3_2,50,'Normalization','probability');title('Native L3')
xlim([0.0001 .002]); 

% figure();
% histogram(adc,50,'Normalization','probability');title('ADC')
% xlim([0.0001 .002]); 

figure();
histogram(cl_2,50,'Normalization','probability');title('Native CL')
xlim([0 1]); 

figure();
histogram(cp_2,50,'Normalization','probability');title('Native CP')
xlim([0 1]); 

figure();
histogram(cs_2,50,'Normalization','probability');title('Native CS')
xlim([0 1]); 

figure();
histogram(ra_2,50,'Normalization','probability');title('Native RA')
xlim([0.01 01]); 

figure();
histogram(rd_2,50,'Normalization','probability');title('Native RD')
xlim([0.0001 0.002]); 
