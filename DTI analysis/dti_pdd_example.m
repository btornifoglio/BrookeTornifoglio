% Simulation to color code FA Maps
% Based on https://uk.mathworks.com/matlabcentral/fileexchange/21130-dti-and-fiber-tracking
% Open source dataset from ExploreDTI http://www.exploredti.com/exampledataset.htm
%% Alan Stone TCD 08/08/2019

data_location = '/Users/astone/albin/dti/example_data/Fiber_phantom_data';

% read b-directions
fid = fopen(sprintf('%s/Fiber_phantom_grads.txt',data_location));
C = textscan(fid, '%f%f%f');
fclose(fid);
c1 = C{1}; c2 = C{2}; c3 = C{3};
bdir = [c1 c2 c3];

% b values
bval = 1200; % see readme

% load imaging data
s_dti_dataset = read_avw(sprintf('%s/Fiber_phantom_DWIs.nii',data_location));

% correction for leading b0's
s_dti_dataset_b0avg = mean(s_dti_dataset(:,:,:,1:6),4);
s_dti_dataset(:,:,:,1:6) = [];
s_dti_dataset = cat(4,s_dti_dataset_b0avg,s_dti_dataset);

% add b0 volume
bdir = [[0, 0, 0]; bdir];

% view
figure,
subplot(1,3,1), imshow(s_dti_dataset(:,:,ceil(end/2),2),'displayrange',[0 5000])
subplot(1,3,2), imshow(imrotate(squeeze(s_dti_dataset(:,ceil(end/2),:,2)),90),'displayrange',[0 5000])
subplot(1,3,3), imshow(imrotate(squeeze(s_dti_dataset(ceil(end/2),:,:,2)),90),'displayrange',[0 5000])

% number of diffusion weighted volumes
nbdirs = size(bdir,1)-1;

% make b matrices
% (http://www.meteoreservice.com/PDFs/Mattiello97.pdf)
b = zeros([3 3 nbdirs]);

for i = 1:nbdirs,
    b(:,:,i) = bval * bdir(i+1,:)' * bdir(i+1,:);
end

% convert signal intenisty to norm'd log
[row col sli ~] = size(s_dti_dataset);
empty_mat_size = [row col sli nbdirs];
slog_norm_dti_dataset = zeros(empty_mat_size,'single');

for i=1:nbdirs,
    slog_norm_dti_dataset(:,:,:,i) = log((s_dti_dataset(:,:,:,i+1)./s_dti_dataset(:,:,:,1))+eps);
end

% sort b mats into vector Bv = [Bxx, 2*Bxy, 2*Bxz, Byy, 2*Byz, Bzz];
bvec = squeeze([b(1,1,:),2*b(1,2,:),2*b(1,3,:),b(2,2,:),2*b(2,3,:),b(3,3,:)])';

% empty matrices
% diffusion tensor
dt = zeros([row col sli 6],'single');

% eigenvalues
eigvals = zeros([row col sli 3],'single');

% eigenvectors
evecs = zeros([row col sli 3],'single');

% eigenvalues
fa = zeros([row col sli],'single');

% mean diffusivity
md = zeros([row col sli],'single');

% main fiber direction
vecf = zeros([row col sli 3],'single');

% calculate parameters for each voxel
for x = 1:row
    for y = 1:col
        for z = 1:sli

            % calculate diffusion tensor
            slog_norm = squeeze(slog_norm_dti_dataset(x,y,z,:));
            xout = -bvec\slog_norm;
            diffusiontensor = [xout(1) xout(2) xout(3); xout(2) xout(4) xout(5); xout(3) xout(5) xout(6)];

            % eigenvectors and eigenvalues
            [eigvecs, D] = eig(diffusiontensor);

            eigvals(x,y,z,:) = diag(D);

            [t, index] = sort(eigvals(x,y,z,:));

            eigvals(x,y,z,:) = eigvals(x,y,z,index);
            eigvecs = eigvecs(:, index);
            eigvals_orig(x,y,z,:) = eigvals(x,y,z,:);

            % Regulating of the eigen values (negative eigenvalues are
            % due to noise and other non-idealities of MRI)
            if((eigvals(x,y,z,1)<0)&&(eigvals(x,y,z,2)<0)&&(eigvals(x,y,z,3)<0)), eigvals(x,y,z,:)=abs(eigvals(x,y,z,:)); end
            if(eigvals(x,y,z,1)<=0), eigvals(x,y,z,1)=eps; end
            if(eigvals(x,y,z,2)<=0), eigvals(x,y,z,2)=eps; end

            % mean diffusivity
            md(x,y,z) = ( eigvals(x,y,z,1) + eigvals(x,y,z,2) + eigvals(x,y,z,3)) /3;

            % fractional anisotropy
            fa(x,y,z) = sqrt(1.5) * ( sqrt((eigvals(x,y,z,1)-md(x,y,z)).^2 + ...
                        (eigvals(x,y,z,2)-md(x,y,z)).^2 + ...
                        (eigvals(x,y,z,3)-md(x,y,z)).^2) ./ ...
                        sqrt(eigvals(x,y,z,1).^2+eigvals(x,y,z,2).^2+eigvals(x,y,z,3).^2) );

            % diffusion tensor and fiber direction
            dt(x,y,z,:)=[diffusiontensor(1:3) diffusiontensor(5:6) diffusiontensor(9)];
            vecf(x,y,z,:) = eigvecs(:,end)*eigvals_orig(x,y,z,end);

            % calculate angles
            angle_x(x,y,z) = atan2d(norm(cross(eigvecs(:,3),[1;0;0])),dot(eigvecs(:,3),[1;0;0]));
            angle_y(x,y,z) = atan2d(norm(cross(eigvecs(:,3),[0;1;0])),dot(eigvecs(:,3),[0;1;0]));
            angle_z(x,y,z) = atan2d(norm(cross(eigvecs(:,3),[0;0;1])),dot(eigvecs(:,3),[0;0;1]));

        end
    end
end

% view
figure('Name','FA','NumberTitle','off')
subplot(1,3,1), imshow(fa(:,:,ceil(end/2)),'displayrange',[0 1])
subplot(1,3,2), imshow(imrotate(squeeze(fa(:,ceil(end/2),:)),90),'displayrange',[0 1])
subplot(1,3,3), imshow(imrotate(squeeze(fa(ceil(end/2),:,:)),90),'displayrange',[0 1])

figure('Name','MD','NumberTitle','off')
subplot(1,3,1), imshow(md(:,:,ceil(end/2)),'displayrange',[0 0.001])
subplot(1,3,2), imshow(imrotate(squeeze(md(:,ceil(end/2),:)),90),'displayrange',[0 0.001])
subplot(1,3,3), imshow(imrotate(squeeze(md(ceil(end/2),:,:)),90),'displayrange',[0 0.001])

% Principal Diffusion Direction
% calculate angles
r = fa.*abs(cosd(angle_x)); % Red channel
g = fa.*abs(cosd(angle_y)); % Green channel
b = fa.*abs(cosd(angle_z)); % Blue channel
pdd = cat(4,r,g,b);

figure('Name','PDD (FA)','NumberTitle','off')
subplot(1,3,1), imshow(squeeze(pdd(:,:,ceil(end/2),:)))
subplot(1,3,2), imshow(imrotate(squeeze(pdd(:,ceil(end/2),:,:)),90))
subplot(1,3,3), imshow(imrotate(squeeze(pdd(ceil(end/2),:,:,:)),90))


% subplot(3,3,9), plot3(linspace(0,1,100),linspace(0,0,100),linspace(0,0,100),'r'), hold on
%                 plot3(linspace(0,0,100),linspace(0,1,100),linspace(0,0,100),'g')
%                 plot3(linspace(0,0,100),linspace(0,0,100),linspace(0,1,100),'b'), grid on

% calculate angles
% R = fa(:,:,ceil(end/2)).*cosd(angle_x(:,:,ceil(end/2))); % Red channel
% G = fa(:,:,ceil(end/2)).*cosd(angle_y(:,:,ceil(end/2))); % Green channel
% B = fa(:,:,ceil(end/2)).*cosd(angle_z(:,:,ceil(end/2))); % Blue channel
% rgb = cat(3,R,G,B);
% figure, imshow(rgb)

% view
% figure,
% subplot(1,3,1), imshow(s_dti_dataset(:,:,ceil(end/2),2),'displayrange',[0 5000])
% subplot(1,3,2), imshow(imrotate(squeeze(s_dti_dataset(:,ceil(end/2),:,2)),90),'displayrange',[0 5000])
% subplot(1,3,3), imshow(imrotate(squeeze(s_dti_dataset(ceil(end/2),:,:,2)),90),'displayrange',[0 5000])