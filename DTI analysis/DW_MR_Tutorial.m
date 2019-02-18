%% Tutorial on Diffusion Tensor MRI using MATLAB:
% to be followed from the online-available tutorial by Angelos Barmpoutis 
% this tutorial requires fanDTasia Toolbox, which supports Bruker files.
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

clc;
clear;

%% Step 1: Simulating a DWI MRI dataset in Matlab
% Due to the numerous file formats from different scanners, this will
% define a DW-MRI as follows:

%   (1) GradientOrientations: is a matrix of size Nx3 which contains the
%   list of diffusion sensitizing magnetic gradient orientations

%   (2) b_value: is a vector of Nx1 which contains the corresponding list
%   of diffusion weighting b-values

%   (3) S is a matrix of size sizeX x sizeY x num_of_slices x N which
%   contains the acquired DW-MR signal responses. N is the number of
%   acquired volumes (generally the number of magnetic gradients),
%   num_of_slices is the number of 2D slices within each volume, and each
%   of these slices is defined by sizeX and sizeY.

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Step 1.1
% The following script writes a set of 22 b-values and orientations. The
% first corresponds to the S0, or unweighted, while the other 21 have a b
% values of 1500 s/mm^2. They are generated by tessellating a icosahedron
% on the unit hemi-sphere.

UnitVectors;              % a file from the fanDTasia toolbox - generates g
GradientOrientations=[1 0 0;g([1:21],:)];
b_value=[10;ones(21,1)*1500];

% Step 1.2
% Next the simulation response that corresponds to a specific geometry can
% be simulated. This will generate the DW-MRI dataset for 1 voxel only
% which corresponds to two fibres crossing. Their interestion is defined as
% 20 and 100 degrees respectively in the X-Y plane. This forms an angle of
% 80 degrees between the two fibres. 

fiber_orientation1=[cos(20*pi/180) sin(20*pi/180) 0];
fiber_orientation2=[cos(100*pi/180) sin(100*pi/180) 0];
S=ones(1,1,1,size(GradientOrientations,1));   % DW-MRI response, see above.

for i=2:size(GradientOrientations,1)                  % skip 1, as it is b0
   S(1,1,1,i)=S(1,1,1,1)*(SimulateDWMRI(fiber_orientation1...
       ,GradientOrientations(i,:))+ SimulateDWMRI(fiber_orientation2,...
       GradientOrientations(i,:)))/2;
end

% This will now generate a whole DW-MRI field by extending the above code.
% When designing a field of fibre tracts, you need the underlying fibre
% orientations at each voxel in the field. There may be 1 - 3 distinct
% fibre orientations within a voxel. The goal is to create a variety of
% fibre structures (crossing, splaying) in order to test multi-fibre
% reconstruction. 

% This script creates a 2D field (32 x 32) with 2 for loops runnings for
% all x, y locations. The first if statement corresponds to a curved fibre
% which the second is a straight bundle. 


S=ones(32,32,32,size(GradientOrientations,1));
for i=2:size(GradientOrientations,1)
for x=1:32
   for y=1:32
      for z=1:32 
          f1_flag=0;
          f2_flag=0;
         if x*x+y*y>16*16 & x*x+y*y<32*32
            v=[y/x -1 0];v=v/sqrt(v*v');
           fiber_orientation1=v;f1_flag=1;
         end
          if x<y+10 & x>y-10
            fiber_orientation2=[sqrt(2)/2 sqrt(2)/2 0];f2_flag=1;
          end
       if f1_flag==0 & f2_flag==1
            fiber_orientation1=fiber_orientation2;
          elseif f1_flag==1 & f2_flag==0
            fiber_orientation2=fiber_orientation1;
       elseif f1_flag==0 & f2_flag==0
            fiber_orientation1=[0 0 1];fiber_orientation2=[0 0 1];
       end
       S(x,y,z,i)=S(x,y,z,1)*(SimulateDWMRI(fiber_orientation1,...
          GradientOrientations(i,:))+ SimulateDWMRI(fiber_orientation2,...
          GradientOrientations(i,:)))/2;
      end
   end 
end
end


% this can be "easily" adapted to make a 3D DW-MRI by adding one more for
% loop. you can also as more fibre bundles by adding more if statements.
% I think we did this.....maybe
%% Step 2: Estimating the Diffusion Tensor


G=constructMatrixOfMonomials(GradientOrientations, 2);
C=constructSetOf81Polynomials(2)';
P=G*C;P=[-diag(b_value)*P ones(size(GradientOrientations,1),1)];
DTI=zeros(3,3,size(S,1),size(S,2));S0=zeros(size(S,1),size(S,2));
for i=1:size(S,1)
   for j=1:size(S,2)
      y=log(squeeze(S(i,j,1,:)));
      x=lsqnonneg(P, y);
      T = C * x([1:81]);
      UniqueTensorCoefficients(:,i,j)=T;
      DTI(:,:,i,j)=[T(6) T(5)/2 T(4)/2
      T(5)/2 T(3) T(2)/2
      T(4)/2 T(2)/2 T(1)];
      S0(i,j)=exp(x(82));
   end
end
