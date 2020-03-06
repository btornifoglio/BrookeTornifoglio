% Simulation of fractional anisotropy calculation in low SNR
% Based on https://uk.mathworks.com/matlabcentral/fileexchange/21130-dti-and-fiber-tracking
%% Alan Stone TCD 01/05/2019
clear;clc;close all;
% gradient directions based on unit vector 
bdir = [0 0 0; 1 0 1; -1 0 1; 0 1 1; 0 1 -1; 1 1 0; -1 1 0];

% b values
bval = 800;

% number of diffusion weighted volumes (one less because of the b-0 image)
nbdirs = size(bdir,1)-1;

% simulate no attenuation with gradient application 
%(noise - b0 mean is around the mean of the b-direction signal
% - the signal does not change)
s_dti_dataset1 = (ones(128,128,1,7) .* 150) + (randn(128,128,1,7) .* 50);

% simulate attenuation with gradient application ... low SNR (b0 mean is 
% higher than the mean of the b-drections - i.e. the signal is attenuating)
% only thing that is changing here is the attenuation of the b0
s_dti_dataset2 = s_dti_dataset1;
s_dti_dataset2(:,:,:,1) = (ones(128,128,1) .* 450) + randn(128,128,1)*50;

% make b matrices
% (http://www.meteoreservice.com/PDFs/Mattiello97.pdf)
b = zeros([3 3 nbdirs]);

for i = 1:nbdirs,
    b(:,:,i) = bval * bdir(i+1,:)' * bdir(i+1,:);
end

% convert signal intenisty to norm'd log
[row col sli ~] = size(s_dti_dataset1);
empty_mat_size = [row col sli nbdirs];
slog_norm_dti_dataset1 = zeros(empty_mat_size,'single');
slog_norm_dti_dataset2 = zeros(empty_mat_size,'single');

for i=1:nbdirs,
    slog_norm_dti_dataset1(:,:,:,i) = log((s_dti_dataset1(:,:,:,i+1)./s_dti_dataset1(:,:,:,1))+eps);
    slog_norm_dti_dataset2(:,:,:,i) = log((s_dti_dataset2(:,:,:,i+1)./s_dti_dataset2(:,:,:,1))+eps);
end

% sort b mats into vector Bv = [Bxx, 2*Bxy, 2*Bxz, Byy, 2*Byz, Bzz];
bvec = squeeze([b(1,1,:),2*b(1,2,:),2*b(1,3,:),b(2,2,:),2*b(2,3,:),b(3,3,:)])';

% empty matrices
% diffusion tensor
dt1 = zeros(empty_mat_size,'single');
dt2 = zeros(empty_mat_size,'single');
% eigenvalues
eigvals1 = zeros([row col sli 3],'single');
eigvals2 = zeros([row col sli 3],'single');
% eigenvectors
evecs1 = zeros([row col sli 3],'single');
evecs2 = zeros([row col sli 3],'single');
% eigenvalues
fa1 = zeros([row col sli],'single');
fa2 = zeros([row col sli],'single');
% mean diffusivity
md1 = zeros([row col sli],'single');
md2 = zeros([row col sli],'single');
% main fiber direction
vecf1 = zeros([row col sli 3],'single');
vecf2 = zeros([row col sli 3],'single');

% calculate parameters for each voxel
for x = 1:row
    for y = 1:col
        for z = 1:sli

            % calculate diffusion tensor
            slog_norm1 = squeeze(slog_norm_dti_dataset1(x,y,z,:));
            slog_norm2 = squeeze(slog_norm_dti_dataset2(x,y,z,:));
            xout1 = -bvec\slog_norm1;
            xout2 = -bvec\slog_norm2;
            diffusiontensor1 = [xout1(1) xout1(2) xout1(3); xout1(2) xout1(4) xout1(5); xout1(3) xout1(5) xout1(6)];
            diffusiontensor2 = [xout2(1) xout2(2) xout2(3); xout2(2) xout2(4) xout2(5); xout2(3) xout2(5) xout2(6)];

            % eigenvectors and eigenvalues
            [eigvecs1, D1] = eig(diffusiontensor1);
            [eigvecs2, D2] = eig(diffusiontensor2);
            eigvals1(x,y,z,:) = diag(D1);
            eigvals2(x,y,z,:) = diag(D2);
            [t1, index1] = sort(eigvals1(x,y,z,:));
            [t2, index2] = sort(eigvals2(x,y,z,:));
            eigvals1(x,y,z,:) = eigvals1(x,y,z,index1);
            eigvals2(x,y,z,:) = eigvals2(x,y,z,index2);
            eigvecs1 = eigvecs1(:, index1);
            eigvecs2 = eigvecs2(:, index2);
            eigvals_orig1(x,y,z,:) = eigvals1(x,y,z,:);
            eigvals_orig2(x,y,z,:) = eigvals2(x,y,z,:);

            % Regulating of the eigen values (negative eigenvalues are
            % due to noise and other non-idealities of MRI)
            if((eigvals1(x,y,z,1)<0)&&(eigvals1(x,y,z,2)<0)&&(eigvals1(x,y,z,3)<0)), eigvals1(x,y,z,:)=abs(eigvals1(x,y,z,:)); end
            if((eigvals2(x,y,z,1)<0)&&(eigvals2(x,y,z,2)<0)&&(eigvals2(x,y,z,3)<0)), eigvals2(x,y,z,:)=abs(eigvals2(x,y,z,:)); end

            if(eigvals1(x,y,z,1)<=0), eigvals1(x,y,z,1)=eps; end
            if(eigvals2(x,y,z,1)<=0), eigvals2(x,y,z,1)=eps; end

            if(eigvals1(x,y,z,2)<=0), eigvals1(x,y,z,2)=eps; end
            if(eigvals2(x,y,z,2)<=0), eigvals2(x,y,z,2)=eps; end

            % mean diffusivity
            md1(x,y,z) = ( eigvals1(x,y,z,1) + eigvals1(x,y,z,2) + eigvals1(x,y,z,3)) /3;
            md2(x,y,z) = ( eigvals2(x,y,z,1) + eigvals2(x,y,z,2) + eigvals2(x,y,z,3)) /3;

            % fractional anisotropy
            fa1(x,y,z) = sqrt(1.5) * ( sqrt((eigvals1(x,y,z,1)-md1(x,y,z)).^2 + ...
                        (eigvals1(x,y,z,2)-md1(x,y,z)).^2 + ...
                        (eigvals1(x,y,z,3)-md1(x,y,z)).^2) ./ ...
                        sqrt(eigvals1(x,y,z,1).^2+eigvals1(x,y,z,2).^2+eigvals1(x,y,z,3).^2) );
            fa2(x,y,z) = sqrt(1.5) * ( sqrt((eigvals2(x,y,z,1)-md2(x,y,z)).^2 + ...
                        (eigvals2(x,y,z,2)-md2(x,y,z)).^2 + ...
                        (eigvals2(x,y,z,3)-md2(x,y,z)).^2) ./ ...
                        sqrt(eigvals2(x,y,z,1).^2+eigvals2(x,y,z,2).^2+eigvals2(x,y,z,3).^2) );

            % diffusion tensor and fiber direction
            dt1(x,y,z,:)=[diffusiontensor1(1:3) diffusiontensor1(5:6) diffusiontensor1(9)];
            dt2(x,y,z,:)=[diffusiontensor2(1:3) diffusiontensor2(5:6) diffusiontensor2(9)];
            vecf1(x,y,z,:) = eigvecs1(:,end)*eigvals_orig1(x,y,z,end);
            vecf2(x,y,z,:) = eigvecs2(:,end)*eigvals_orig2(x,y,z,end);

        end
    end
end

% view
figure,
subplot(2,2,1), imshow(fa1(:,:,1),'displayrange',[0 1]), title('FA - No attenuation with gradient application')
subplot(2,2,2), imshow(fa2(:,:,1),'displayrange',[0 1]), title('FA - Attenuation with gradient application ... SNR: 3')
subplot(2,2,3), imshow(md1(:,:,1),'displayrange',[0 5e-3]), title('MD - No attenuation with gradient application')
subplot(2,2,4), imshow(md2(:,:,1),'displayrange',[0 5e-3]), title('MD - Attenuation with gradient application ... SNR: 3')
%%
figure(), subplot(2,1,1), for i=1:7, plot(i,s_dti_dataset1(46,72,:,i),'o'), hold on, end
md1(36, 45, 1);
hold on, title(ans); ylim([0 500]), grid on
subplot(2,1,2), for i=1:7, plot(i,s_dti_dataset2(46,72,:,i),'o'), hold on, end
md2(36, 45, 1);
hold on, title(ans); ylim([0 500]), grid on