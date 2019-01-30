%% Stastical analysis for multi_expo data
%from mono-exp analysis
clc
clear all
close all
load ('FA.mat');
%load ADC.mat;
fa=reshape(FA,1,[]);
md=reshape(ADC,1,[]);
i=find(fa>0 & fa <1);
fa=fa(i);
fa=fa';
md=md(i);
md=md';
figure
subplot(2,1,1)
histogram(fa,50,'Normalization','probability');ylabel('VF');xlabel('FA')
subplot(2,1,2)
histogram(md,50,'Normalization','probability');ylabel('VF');xlabel('ADC')
%% writing to excel
filename='mono_exp_indices_b_full_range.xlsx';
C1={'FA'};
C2={'MD'};
xlswrite(filename,fa,1,'A2')
xlswrite(filename,C1,1,'A1')
xlswrite(filename,md,1,'B2')
xlswrite(filename,C2,1,'B1')
%% from bi-exponential analysis
clc
clear all
close all
load FA.mat;
load FA1.mat;
fa=reshape(FA,1,[]);
fa1=reshape(FA1,1,[]);fa2=reshape(FA2,1,[]);
adc1=reshape(ADC1,1,[]);adc2=reshape(ADC2,1,[]);
S0_fast=M(:,:,:,1);S0_fast=reshape(S0_fast,1,[]);
S0_slow=M(:,:,:,8);S0_slow=reshape(S0_slow,1,[]);
i=find(fa>0.2);
fa=fa(i);
fa=fa';
fa1=fa1(i);
fa2=fa2(i);
adc1=adc1(i);
adc2=adc2(i);
S0_fast=S0_fast(i);
S0_fast=S0_fast./max(S0_fast);
S0_slow=S0_slow(i);
S0_slow=S0_slow./max(S0_slow);
figure
subplot(6,1,1)
histogram(fa1,50,'Normalization','probability');ylabel('VF');xlabel('FA1')
subplot(6,1,2)
histogram(fa2,50,'Normalization','probability');ylabel('VF');xlabel('FA2')
subplot(6,1,3)
histogram(adc1,50,'Normalization','probability');ylabel('VF');xlabel('ADC1')
subplot(6,1,4)
histogram(adc2,50,'Normalization','probability');ylabel('VF');xlabel('ADC2')
subplot(6,1,5)
histogram(S0_fast,50,'Normalization','probability');ylabel('VF');xlabel('S_0fast')
subplot(6,1,6)
histogram(S0_slow,50,'Normalization','probability');ylabel('VF');xlabel('S_0slow')
%%
%writing to excel
filename='bi_exp_indices_fa_higher_than_0.2.xlsx';
C1={'FA1'};
C2={'FA2'};
C3={'ADC1'};
C4={'ADC2'};
C5={'D_Fast'};
C6={'D_Slow'};


xlswrite(filename,fa1',1,'A2')
xlswrite(filename,C1,1,'A1')
xlswrite(filename,fa2',1,'B2')
xlswrite(filename,C2,1,'B1')

xlswrite(filename,adc1',1,'C2')
xlswrite(filename,C3,1,'C1')
xlswrite(filename,adc2',1,'D2')
xlswrite(filename,C4,1,'D1')

xlswrite(filename,S0_fast',1,'E2')
xlswrite(filename,C5,1,'E1')
xlswrite(filename,S0_slow',1,'F2')
xlswrite(filename,C6,1,'F1')
%%




