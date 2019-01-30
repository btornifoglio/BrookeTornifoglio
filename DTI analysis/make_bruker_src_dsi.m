% file = '/mnt/d/MRI//Data/20181207_BT/47_DtiEpi_multib_200um_64dir_b800/pdata/1/2dseq';
% file = 'D:\Analysed_data\20181207BT\47_DtiEpi_multib_200um_64dir_b800\Btablenorma\2dseq';
% num_dif = 74;
% dimension = [128 128 24]; % [x y z] the dimension of the 2dseq file, suppose average=1
% voxel_size = [0.234 0.234 0.234]; % [x y z] pixel spacing in mm
% f1 = fopen(file,'r');
% A=fread(f1,'int16');
%file = '/mnt/d/MRI//Data/20181207_BT/47_DtiEpi_multib_200um_64dir_b800/pdata/1/2dseq';
file = 'D:\Analysed_data\20181207BT\48_DtiEpi_multib_100um_12dir_b800\assemblefrommatlab\2dseq';
num_dif = 88; %directions plus b0s
dimension = [128 128 80]; % [x y z] the dimension of the 2dseq file, suppose average=1
voxel_size = [0.117 0.117 0.117]; % [x y z] pixel spacing in mm
f1 = fopen(file,'r');
A=fread(f1,'int16');
A=reshape(A,dimension(1),dimension(2),dimension(3),num_dif);
%%
% slope is a dimension(3) x num_dif matrix that defines the scaling parameters
% input the slope here
% TODO: find out how to implement this
%{
slope=[81.3139111191806 81.3139111191806 81.3139111191806 81.3139111191806
...
]
slope = slope./min(min(slope));
slope = reshape(slope',dimension(3),num_dif);
for i = 1:dimension(3)
for j = 1:num_dif
    A(:,:,i,j) = A(:,:,i,j)/slope(i,j);
end
end
%}

% image0 ~ imageN, where N is the number of diffusion gradient encoding
image0   = reshape(A(:,:,:, 1) ,prod(dimension),1);
image1   = reshape(A(:,:,:, 2) ,prod(dimension),1);
image2   = reshape(A(:,:,:, 3) ,prod(dimension),1);
image3   = reshape(A(:,:,:, 4) ,prod(dimension),1);
image4   = reshape(A(:,:,:, 5) ,prod(dimension),1);
image5   = reshape(A(:,:,:, 6) ,prod(dimension),1);
image6   = reshape(A(:,:,:, 7) ,prod(dimension),1);
image7   = reshape(A(:,:,:, 8) ,prod(dimension),1);
image8   = reshape(A(:,:,:, 9) ,prod(dimension),1);
image9   = reshape(A(:,:,:, 10),prod(dimension),1);
image10  = reshape(A(:,:,:, 11),prod(dimension),1);
image11  = reshape(A(:,:,:, 12),prod(dimension),1);
image12  = reshape(A(:,:,:, 13),prod(dimension),1);
image13  = reshape(A(:,:,:, 14),prod(dimension),1);
image14  = reshape(A(:,:,:, 15),prod(dimension),1);
image15  = reshape(A(:,:,:, 16),prod(dimension),1);
image16  = reshape(A(:,:,:, 17),prod(dimension),1);
image17  = reshape(A(:,:,:, 18),prod(dimension),1);
image18  = reshape(A(:,:,:, 19),prod(dimension),1);
image19  = reshape(A(:,:,:, 20),prod(dimension),1);
image20  = reshape(A(:,:,:, 21),prod(dimension),1);
image21  = reshape(A(:,:,:, 22),prod(dimension),1);
image22  = reshape(A(:,:,:, 23),prod(dimension),1);
image23  = reshape(A(:,:,:, 24),prod(dimension),1);
image24  = reshape(A(:,:,:, 25),prod(dimension),1);
image25  = reshape(A(:,:,:, 26),prod(dimension),1);
image26  = reshape(A(:,:,:, 27),prod(dimension),1);
image27  = reshape(A(:,:,:, 28),prod(dimension),1);
image28  = reshape(A(:,:,:, 29),prod(dimension),1);
image29  = reshape(A(:,:,:, 30),prod(dimension),1);
image30  = reshape(A(:,:,:, 31),prod(dimension),1);
image31  = reshape(A(:,:,:, 32),prod(dimension),1);
image32  = reshape(A(:,:,:, 33),prod(dimension),1);
image33  = reshape(A(:,:,:, 34),prod(dimension),1);
image34  = reshape(A(:,:,:, 35),prod(dimension),1);
image35  = reshape(A(:,:,:, 36),prod(dimension),1);
image36  = reshape(A(:,:,:, 37),prod(dimension),1);
image37  = reshape(A(:,:,:, 38),prod(dimension),1);
image38  = reshape(A(:,:,:, 39),prod(dimension),1);
image39  = reshape(A(:,:,:, 40),prod(dimension),1);
image40  = reshape(A(:,:,:, 41),prod(dimension),1);
image41  = reshape(A(:,:,:, 42),prod(dimension),1);
image42  = reshape(A(:,:,:, 43),prod(dimension),1);
image43  = reshape(A(:,:,:, 44),prod(dimension),1);
image44  = reshape(A(:,:,:, 45),prod(dimension),1);
image45  = reshape(A(:,:,:, 46),prod(dimension),1);
image46  = reshape(A(:,:,:, 47),prod(dimension),1);
image47  = reshape(A(:,:,:, 48),prod(dimension),1);
image48  = reshape(A(:,:,:, 49),prod(dimension),1);
image49  = reshape(A(:,:,:, 50),prod(dimension),1);
image50  = reshape(A(:,:,:, 51),prod(dimension),1);
image51  = reshape(A(:,:,:, 52),prod(dimension),1);
image52  = reshape(A(:,:,:, 53),prod(dimension),1);
image53  = reshape(A(:,:,:, 54),prod(dimension),1);
image54  = reshape(A(:,:,:, 55),prod(dimension),1);
image55  = reshape(A(:,:,:, 56),prod(dimension),1);
image56  = reshape(A(:,:,:, 57),prod(dimension),1);
image57  = reshape(A(:,:,:, 58),prod(dimension),1);
image58  = reshape(A(:,:,:, 59),prod(dimension),1);
image59  = reshape(A(:,:,:, 60),prod(dimension),1);
image60  = reshape(A(:,:,:, 61),prod(dimension),1);
image61  = reshape(A(:,:,:, 62),prod(dimension),1);
image62  = reshape(A(:,:,:, 63),prod(dimension),1);
image63  = reshape(A(:,:,:, 64),prod(dimension),1);
image64  = reshape(A(:,:,:, 65),prod(dimension),1);
image65  = reshape(A(:,:,:, 66),prod(dimension),1);
image66  = reshape(A(:,:,:, 67),prod(dimension),1);
image67  = reshape(A(:,:,:, 68),prod(dimension),1);
image68  = reshape(A(:,:,:, 69),prod(dimension),1);
image69  = reshape(A(:,:,:, 70),prod(dimension),1);
image70  = reshape(A(:,:,:, 71),prod(dimension),1);
image71  = reshape(A(:,:,:, 72),prod(dimension),1);
image72  = reshape(A(:,:,:, 73),prod(dimension),1);
image73  = reshape(A(:,:,:, 74),prod(dimension),1);
image74  = reshape(A(:,:,:, 75),prod(dimension),1);
image75  = reshape(A(:,:,:, 76),prod(dimension),1);
image76  = reshape(A(:,:,:, 77),prod(dimension),1);
image77  = reshape(A(:,:,:, 78),prod(dimension),1);
image78  = reshape(A(:,:,:, 79),prod(dimension),1);
image79  = reshape(A(:,:,:, 80),prod(dimension),1);
image80  = reshape(A(:,:,:, 81),prod(dimension),1);
image81  = reshape(A(:,:,:, 82),prod(dimension),1);
image82  = reshape(A(:,:,:, 83),prod(dimension),1);
image83  = reshape(A(:,:,:, 84),prod(dimension),1);
image84  = reshape(A(:,:,:, 85),prod(dimension),1);
image85  = reshape(A(:,:,:, 86),prod(dimension),1);
image86  = reshape(A(:,:,:, 87),prod(dimension),1);
image87  = reshape(A(:,:,:, 88),prod(dimension),1);


%%
% if averaging on the repeat images is needed, run
repeat = 10;
dimension(3) = dimension(3)/repeat;
image0 = reshape(sum(reshape(image0 ,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image1 = reshape(sum(reshape(image1 ,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image2 = reshape(sum(reshape(image2 ,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image3 = reshape(sum(reshape(image3 ,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image4 = reshape(sum(reshape(image4 ,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image5 = reshape(sum(reshape(image5 ,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image6 = reshape(sum(reshape(image6 ,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image7 = reshape(sum(reshape(image7 ,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image8 = reshape(sum(reshape(image8 ,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image9 = reshape(sum(reshape(image9 ,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image10= reshape(sum(reshape(image10,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image11= reshape(sum(reshape(image11,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image12= reshape(sum(reshape(image12,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image13= reshape(sum(reshape(image13,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image14= reshape(sum(reshape(image14,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image15= reshape(sum(reshape(image15,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image16= reshape(sum(reshape(image16,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image17= reshape(sum(reshape(image17,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image18= reshape(sum(reshape(image18,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image19= reshape(sum(reshape(image19,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image20= reshape(sum(reshape(image20,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image21= reshape(sum(reshape(image21,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image22= reshape(sum(reshape(image22,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image23= reshape(sum(reshape(image23,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image24= reshape(sum(reshape(image24,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image25= reshape(sum(reshape(image25,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image26= reshape(sum(reshape(image26,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image27= reshape(sum(reshape(image27,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image28= reshape(sum(reshape(image28,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image29= reshape(sum(reshape(image29,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image30= reshape(sum(reshape(image30,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image31= reshape(sum(reshape(image31,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image32= reshape(sum(reshape(image32,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image33= reshape(sum(reshape(image33,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image34= reshape(sum(reshape(image34,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image35= reshape(sum(reshape(image35,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image36= reshape(sum(reshape(image36,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image37= reshape(sum(reshape(image37,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image38= reshape(sum(reshape(image38,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image39= reshape(sum(reshape(image39,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image40= reshape(sum(reshape(image40,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image41= reshape(sum(reshape(image41,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image42= reshape(sum(reshape(image42,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image43= reshape(sum(reshape(image43,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image44= reshape(sum(reshape(image44,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image45= reshape(sum(reshape(image45,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image46= reshape(sum(reshape(image46,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image47= reshape(sum(reshape(image47,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image48= reshape(sum(reshape(image48,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image49= reshape(sum(reshape(image49,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image50= reshape(sum(reshape(image50,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image51= reshape(sum(reshape(image51,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image52= reshape(sum(reshape(image52,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image53= reshape(sum(reshape(image53,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image54= reshape(sum(reshape(image54,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image55= reshape(sum(reshape(image55,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image56= reshape(sum(reshape(image56,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image57= reshape(sum(reshape(image57,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image58= reshape(sum(reshape(image58,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image59= reshape(sum(reshape(image59,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image60= reshape(sum(reshape(image60,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image61= reshape(sum(reshape(image61,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image62= reshape(sum(reshape(image62,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image63= reshape(sum(reshape(image63,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image64= reshape(sum(reshape(image64,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image65= reshape(sum(reshape(image65,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image66= reshape(sum(reshape(image66,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image67= reshape(sum(reshape(image67,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image68= reshape(sum(reshape(image68,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image69= reshape(sum(reshape(image69,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image70= reshape(sum(reshape(image70,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image71= reshape(sum(reshape(image71,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image72= reshape(sum(reshape(image72,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image73= reshape(sum(reshape(image73,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image74= reshape(sum(reshape(image74,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image75= reshape(sum(reshape(image75,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image76= reshape(sum(reshape(image76,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image77= reshape(sum(reshape(image77,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image78= reshape(sum(reshape(image78,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image79= reshape(sum(reshape(image79,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image80= reshape(sum(reshape(image80,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image81= reshape(sum(reshape(image81,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image82= reshape(sum(reshape(image82,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image83= reshape(sum(reshape(image83,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image84= reshape(sum(reshape(image84,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image85= reshape(sum(reshape(image85,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image86= reshape(sum(reshape(image86,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;
image87= reshape(sum(reshape(image87,dimension(1),dimension(2),dimension(3),repeat),4),prod(dimension),1)/repeat;



%%
% % the b-table should be arranged in the format of [b-value1 bx by bz; b-value2 bx by bz;...;b-valueN bx by bz]
b_table = [ ...
            0 0 0 0; ...
            0 0 0 0; ...
            0 0 0 0; ...
            0 0 0 0; ...
            0 0 0 0; ...
            0 0 0 0; ...
            0 0 0 0; ...
            0 0 0 0; ...
            0 0 0 0; ...
            0 0 0 0; ...
            866.886 0.0964511 0.111229 0.989103;...
            850.205 -0.278593 0.028615 0.959983;...
            863.182 -0.0344522 -0.17152 0.984578;...
            845.428 0.311383 -0.135146 0.940626;...
            828.254 0.278671 0.35535 0.892227;...
            847.615 -0.101114 0.336119 0.936376;...
            845.735 -0.571142 0.0568265 0.818882;...
            830.118 -0.247183 -0.360188 0.899536;...
            841.167 0.166862 -0.407358 0.897896;...
            825.23 0.543937 -0.279056 0.791366;...
            844.915 0.470531 0.115307 0.874817;...
            844.275 0.0863725 0.592362 0.801029;...
            829.318 -0.227605 0.599965 0.766966;...
            826.925 -0.410371 0.335683 0.847887;...
            828.474 -0.515972 -0.243034 0.821406;...
            823.03 -0.370785 -0.589097 0.717971;...
            845.196 -0.0374339 -0.607841 0.793176;...
            823.589 0.356673 -0.574596 0.73663;...
            842.338 0.707814 0.00595125 0.706374;...
            822.508 0.626028 0.342485 0.700566;...
            822.614 0.392352 0.591846 0.704116;...
            838.888 0.0207579 0.811432 0.584078;...
            820.227 -0.527565 0.575919 0.624495;...
            821.219 -0.693622 0.294076 0.657577;...
            837.257 -0.774683 -0.116285 0.621566;...
            820.005 -0.644472 -0.451495 0.617097;...
            830.844 -0.171402 -0.803564 0.570005;...
            832.377 0.162576 -0.791043 0.589762;...
            818.901 0.63056 -0.515435 0.580277;...
            821.549 0.802285 -0.235358 0.548584;...
            825.874 0.847634 0.193984 0.493849;...
            816.583 0.63655 0.584647 0.502983;...
            816.157 0.324133 0.80997 0.48876;...
            817.277 -0.295294 0.797497 0.526118;...
            813.585 -0.769448 0.495529 0.402991;...
            830.9 -0.876127 0.137338 0.462103;...
            813.576 -0.841293 -0.360669 0.402671;...
            815.257 -0.523423 -0.718051 0.458727;...
            810.742 -0.319878 -0.89594 0.308171;...
            831.501 0.0349779 -0.941153 0.336166;...
            815.407 0.459261 -0.757636 0.463753;...
            811.387 0.812651 -0.480534 0.329676;...
            829.902 0.94265 -0.0868198 0.322295;...
            810.699 0.835546 0.455834 0.306722;...
            809.339 0.580955 0.77083 0.261367;...
            830.424 0.0237779 0.953321 0.301021;...
            810.324 -0.30028 0.920448 0.250214;...
            811.436 -0.584368 0.740772 0.331317;...
            817.179 -0.927541 0.311869 0.205926;...
            827.806 -0.955522 -0.10171 0.276826;...
            809.233 -0.734787 -0.627387 0.257825;...
            828.27 -0.53356 -0.842121 0.078394;...
            841.966 -0.16263 -0.984777 0.0613657;...
            813.934 0.342713 -0.911317 0.228143;...
            816.156 0.662221 -0.718332 0.21322;...
            827.278 0.932423 -0.347167 0.100311;...
            829.986 0.964305 0.2016 0.171678;...
            828.924 0.772397 0.632813 0.0543184;...
            819.846 0.323887 0.927777 0.185276;...
            843.958 -0.140221 0.990118 -0.0022231;...
            829.118 -0.526138 0.849698 0.0345217;...
            828.442 -0.789176 0.60976 0.0734377;...
            848.841 -0.998689 0.0484764 0.0164472;...
            828.185 -0.922562 -0.377325 0.0806542]';

% b_table=[0 0 0 0
% 1000 0.337968743631421 0.337968743631421 0
% 1000 0 0.337968743631421 0.337968743631421
% 1000 0.337968743631421 0 0.337968743631421
% 1000 -0.337968743631421 0.337968743631421 0
% 1000 0 -0.337968743631421 0.337968743631421
% 1000 0.337968743631421 0 -0.337968743631421
% ]';% [b_value bx by bz; b_value bx by bz; ...]


%b_table(4,:) = -b_table(4,:);    % note that the z-dimension should be flipped for images from bruker
fclose(f1);
clear A;
clear ans;
clear f1;
save '1.src' '-v4'
