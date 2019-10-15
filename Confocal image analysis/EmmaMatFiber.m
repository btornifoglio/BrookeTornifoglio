% MatFiber fiber orientation analysis code.
% Source: 
%     Cardiac Biomechanics Group
%     PI: Jeffrey W. Holmes, MD,PhD
%         Biomedical Engineering, Medicine, Robert M. Berne Cardiovascular Research Center
%         University of Virginia
%     If used, please reference Fomovsky & Holmes. "Evolution of scar structure, mechanics, and ventricular 
%     function after myocardial infarction in the rat." AJP Heart Circ Phys 298: H221-228, 2010.

% Description:
%     MatFiber is a Matlab adaptation of Fiber3, a C++ program that uses the intensity gradient method described by 
%     Karlon, Covell, McCulloch, Hunter, and Omens. The Anatomical Record 252:612-625. 1998.

clear all;
close all;
clc;

% SPECIFY IMAGE FILE (8-BIT GRAYSCALE), SUBREGION SIZE, AND THRESHOLD LEVEL

% SUBREGION SIZE (S) determines how many pixels (S x S) you wish to group into only 1 output angle.
% The code will divide the original image into N1 x N2 subregions of SxS
% pixels each, and calculate 1 orientation value for each subregion. This
% orientation will correspond to the angle perpendicular to the strongest 
% mean intensity gradient direction within that subregion.

% THRESHOLD (Thresh) determines the minimum value of intensity gradient
% within a subregion that is required for the code to output an orientation
% for that subregion. Subregions with summed intensity gradients below 'Thresh' 
% will not return an orientation angle. Warning: because the threshold is compared to intensity
% gradients summed within each subregion of SxS pixels, an appropriate value of 'Thresh' may vary depending upon the
% subregion size S.

% Sample images:
% 'SIMULATED1' ... this is an artifically generated image of straight lines, populated from a distribution with MVL = 0.3 and Mean Angle = 0.
% 'SIMULATED2' ... this is an artifically generated image of straight lines, populated from a distribution with MVL = 0.7 and Mean Angle = -60.
% 'CP15S219_SUBTRACTED' ... subtracted image of infarct scar (processing methods descibed in Fomovsky 2010)
% Also included are output images after analyzing 'CP15S219_SUBTRACTED'
% with settings we considered appropriate for this image (S = 40, Thresh = 100000),
% as well as with substantially higher/lower subregion size, or thresholds.
% Note that increasing subregion size and threshold resulted in an increased
% mean vector length (MVL) measurement, while decreasing subregion size and
% threshold resulted in decreased MVL.

%%%%%%%%%%%%%%%%%
%only change parameters in this section

%file location for .tif file include final \
fLoc = "E:\EmmaTrionaPostDocResults\BOSErunNovember2018EmmaconfocalDecember2018\RawpulledoutsaveasimagesNovember2018BOSE\";

%file location include final \
sLoc = "E:\EmmaTrionaPostDocResults\BOSErunNovember2018EmmaconfocalDecember2018\Emmafibrealignment\";

%cell seeding densities (as written in titles, in "" with commas between)
sDen = ["225"];
%strain conditions (as written in titles, in "" with commas between)
strains = ["d0"];
%number of samples
numSamp = 2;

binSize = 5; %Size of bins for alignment histograms. Pick a number that divides 180 evenly

redName = "CNA35"; %name of red channel stain
redS = 5;   % Size of the square subregion (pixels)-red channel
redThresh = 350; % Threshold of which regions to count - red channel

greenName = "SMA"; %name of green channel stain
greenS = 5;   % Size of the square subregion (pixels)-green channel
greenThresh = 12000; % Threshold of which regions to count - green channel

dispRes = 'y'; %displays vector plots of results if set to 'y', 'Y', or 1.
%%%%%%%%%%%%%%%%%


for i = 1:length(sDen)
    for j = 1:length(strains)
        for k = 1:numSamp
            name = char(strcat(sDen(i),strains(j),num2str(k)));
            %set up parameters for saving
            histsR = [];
            statsR = [];
           
            
            histsG = [];
            statsG = [];
            
            names= [];
         
            %set up for while loop for each image
            ind = 1;
            fileNameR = strcat(fLoc,name,'-',num2str(ind),'-red.tif');
            while exist(fileNameR) ==2
                %once for red channel
                 iImage = imread(fileNameR, 'tif');   % Import the image
                 dImage = double(iImage)+1;                   % Convert into double
                     
                
                 % Initial computations related to the image and subregions
                 % Because gradient mask (next step) is 9x9, convolution result will be
                 % erroneous in pixels near image border. Subregions are shifted 5 pixels
                 % away from the image borders to avoid this error.
                D = size(dImage);
                N1 = floor((D(1)-10)/redS);           % Number of subregions vertically;
                N2 = floor((D(2)-10)/redS);           % Number of subregions horizontally;

                % Gradient masks computation
                % for i=-4:4;
                %     for j=-4:4;
                %         MX(i+5,j+5) = 2*i/9*exp(-(i^2+j^2)/4);
                %         MY(i+5,j+5) = 2*j/9*exp(-(i^2+j^2)/4);
                %     end
                % end
                % Hard coded here to save computation time.
                MX = ...
                [-0.00029819    -0.001716	-0.0059893	-0.012679	-0.016281	-0.012679	-0.0059893	-0.001716	-0.00029819;...
                -0.001287      -0.007406	-0.025849	-0.054723	-0.070266	-0.054723	-0.025849	-0.007406	-0.001287;...
                -0.0029946     -0.017233	-0.060149	-0.12734	-0.1635     -0.12734	-0.060149	-0.017233	-0.0029946;...
                -0.0031698     -0.018241	-0.063668	-0.13478	-0.17307	-0.13478	-0.063668	-0.018241	-0.0031698;...
                0              0           0           0           0           0           0           0           0;...
                0.0031698      0.018241	0.063668	0.13478     0.17307     0.13478     0.063668	0.018241	0.0031698;...
                0.0029946      0.017233	0.060149	0.12734     0.1635      0.12734     0.060149	0.017233	0.0029946;...
                0.001287       0.007406	0.025849	0.054723	0.070266	0.054723	0.025849	0.007406	0.001287;...
                0.00029819     0.001716	0.0059893	0.012679	0.016281	0.012679	0.0059893	0.001716	0.00029819];

                MY = ...
                [-0.00029819    -0.001287	-0.0029946	-0.0031698	0	0.0031698	0.0029946	0.001287	0.00029819;...
                -0.001716      -0.007406	-0.017233	-0.018241	0	0.018241	0.017233	0.007406	0.001716;...
                -0.0059893     -0.025849	-0.060149	-0.063668	0	0.063668	0.060149	0.025849	0.0059893;...
                -0.012679      -0.054723	-0.12734	-0.13478	0	0.13478     0.12734     0.054723	0.012679;...
                -0.016281      -0.070266	-0.1635     -0.17307	0	0.17307     0.1635      0.070266	0.016281;...
                -0.012679      -0.054723	-0.12734	-0.13478	0	0.13478     0.12734     0.054723	0.012679;...
                -0.0059893     -0.025849	-0.060149	-0.063668	0	0.063668	0.060149	0.025849	0.0059893;...
                -0.001716      -0.007406	-0.017233	-0.018241	0	0.018241	0.017233	0.007406	0.001716;...
                -0.00029819	-0.001287	-0.0029946	-0.0031698	0	0.0031698	0.0029946	0.001287	0.00029819];

                % Convolve masks with the image
                GX = conv2(dImage,MX,'same');
                GY = conv2(dImage,MY,'same');
                clear MX MY

                % Edge image and gradient direction
                E = GX.^2+GY.^2;
                phi = 180/pi*atan2(GY, GX);
                clear GX GY

                % Determine local orientation in each subregion
                bins = 0:1:179;
                FiberAngle = zeros([N1*N2 1]);
                FiberPosX = zeros([N1*N2 1]);
                FiberPosY = zeros([N1*N2 1]);
                count = 0;

                for q = 1:1:N1
                    for r = 1:1:N2
                        lx = 5 + redS*(r - 1) + 1;
                        ux = 5 + redS*r;
                        ly = 5 + redS*(q - 1) + 1;
                        uy = 5 + redS*q;
                        AthetaW = zeros(size(bins));
                        for n = 1:1:numel(bins)
                            C = E(ly:uy,lx:ux).*exp(2*cos(2*pi/180*(bins(n) - phi(ly:uy,lx:ux))))/exp(2);
                            AthetaW(n) = sum(sum(C)); % AthetaW is a sum of alignment values between pixel gradient directions and each direction from 'bins', weighted by pixel gradient magnitudes.
                                  % The sum includes all pixels within the subregion bounded by lx, ux, ly, uy.
                        end
                        if max(AthetaW) > redThresh
                            [~, Ang] = max(AthetaW); % Sets 'Ang' as the entry from 'bins' corresponding to the maximum 'AthetaW' value.
                            if Ang > 90
                                Ang = Ang - 180;
                            end
                            count = count + 1;
                            FiberAngle(count) = Ang;
                            FiberPosY(count) = round(5 + redS*q - redS/2);
                            FiberPosX(count) = round(5 + redS*r - redS/2);
                        end
                        clear AthetaW Ang;
                    end
                end

                if count < numel(FiberAngle)
                    FiberAngle(count+1:end) = [];
                    FiberPosY(count+1:end) = [];
                    FiberPosX(count+1:end) = [];
                end

                FiberOrientationX = cos(FiberAngle*pi/180);
                FiberOrientationY = sin(FiberAngle*pi/180);
                FiberPosY = -(FiberPosY-D(1));

                % Calculate MA, MVL, CSD
                c2m = mean(cos(2*FiberAngle*pi/180));
                s2m = mean(sin(2*FiberAngle*pi/180));
                MA = 180/pi*1/2*atan2(s2m, c2m);        % mean angle (deg)
                MVL = sqrt(s2m^2 + c2m^2) ;             % mean vector length
                CSD = 180/pi*1/2*sqrt(-2*log(MVL));     % circular standard deviation (deg)
                AD = 180/pi*1/2*sqrt(2*(1-MVL)) ;      % angular deviation (deg)

                if (dispRes == 'y') || (dispRes == 'Y') || (dispRes == 1)
                    % Display Results
                    figure;
                    clf;
                    imagesc(iImage);
                    colormap(gray);
                    hold on;
                    quiver(FiberPosX, -FiberPosY+D(1), FiberOrientationX, -FiberOrientationY, 0.5, 'y', 'LineWidth', 1);
                    hold off;
                    title(['MatFiber: Thresh = ' num2str(redThresh) ', Size = ' num2str(redS) ', MA = ' num2str(MA), ', MVL = ' num2str(MVL) ', CSD = ' num2str(CSD)]);
                    set(gca, 'DataAspectRatio', [1 1 1]);
                    display(fileNameR);
                    display([redThresh redS]);
                    display([MA MVL CSD]);
                end

                %make histogram of angle data
                edges = -90:binSize:90;
                angHist = histcounts(FiberAngle,edges);

                %save values
                statsR = [statsR; MA, MVL, CSD];
                names = [names;ind];
                histsR = [histsR;angHist];
                

                %once for green channel
                fileNameG = strcat(fLoc,name,'-',num2str(ind),'-green.tif');

                iImage = imread(fileNameG, 'tif');   % Import the image
                dImage = double(iImage)+1;                   % Convert into double



                % Initial computations related to the image and subregions
                % Because gradient mask (next step) is 9x9, convolution result will be
                % erroneous in pixels near image border. Subregions are shifted 5 pixels
                % away from the image borders to avoid this error.
                D = size(dImage);
                N1 = floor((D(1)-10)/greenS);           % Number of subregions vertically;
                N2 = floor((D(2)-10)/greenS);           % Number of subregions horizontally;

                % Gradient masks computation
                % for i=-4:4;
                %     for j=-4:4;
                %         MX(i+5,j+5) = 2*i/9*exp(-(i^2+j^2)/4);
                %         MY(i+5,j+5) = 2*j/9*exp(-(i^2+j^2)/4);
                %     end
                % end
                % Hard coded here to save computation time.
                MX = ...
                [-0.00029819    -0.001716	-0.0059893	-0.012679	-0.016281	-0.012679	-0.0059893	-0.001716	-0.00029819;...
                -0.001287      -0.007406	-0.025849	-0.054723	-0.070266	-0.054723	-0.025849	-0.007406	-0.001287;...
                -0.0029946     -0.017233	-0.060149	-0.12734	-0.1635     -0.12734	-0.060149	-0.017233	-0.0029946;...
                -0.0031698     -0.018241	-0.063668	-0.13478	-0.17307	-0.13478	-0.063668	-0.018241	-0.0031698;...
                0              0           0           0           0           0           0           0           0;...
                0.0031698      0.018241	0.063668	0.13478     0.17307     0.13478     0.063668	0.018241	0.0031698;...
                0.0029946      0.017233	0.060149	0.12734     0.1635      0.12734     0.060149	0.017233	0.0029946;...
                0.001287       0.007406	0.025849	0.054723	0.070266	0.054723	0.025849	0.007406	0.001287;...
                0.00029819     0.001716	0.0059893	0.012679	0.016281	0.012679	0.0059893	0.001716	0.00029819];

                MY = ...
                [-0.00029819    -0.001287	-0.0029946	-0.0031698	0	0.0031698	0.0029946	0.001287	0.00029819;...
                -0.001716      -0.007406	-0.017233	-0.018241	0	0.018241	0.017233	0.007406	0.001716;...
                -0.0059893     -0.025849	-0.060149	-0.063668	0	0.063668	0.060149	0.025849	0.0059893;...
                -0.012679      -0.054723	-0.12734	-0.13478	0	0.13478     0.12734     0.054723	0.012679;...
                -0.016281      -0.070266	-0.1635     -0.17307	0	0.17307     0.1635      0.070266	0.016281;...
                -0.012679      -0.054723	-0.12734	-0.13478	0	0.13478     0.12734     0.054723	0.012679;...
                -0.0059893     -0.025849	-0.060149	-0.063668	0	0.063668	0.060149	0.025849	0.0059893;...
                -0.001716      -0.007406	-0.017233	-0.018241	0	0.018241	0.017233	0.007406	0.001716;...
                -0.00029819	-0.001287	-0.0029946	-0.0031698	0	0.0031698	0.0029946	0.001287	0.00029819];

                % Convolve masks with the image
                GX = conv2(dImage,MX,'same');
                GY = conv2(dImage,MY,'same');
                clear MX MY

                % Edge image and gradient direction
                E = GX.^2+GY.^2;
                phi = 180/pi*atan2(GY, GX);
                clear GX GY

                % Determine local orientation in each subregion
                bins = 0:1:179;
                FiberAngle = zeros([N1*N2 1]);
                FiberPosX = zeros([N1*N2 1]);
                FiberPosY = zeros([N1*N2 1]);
                count = 0;

                for q = 1:1:N1
                    for r = 1:1:N2
                        lx = 5 + greenS*(r - 1) + 1;
                        ux = 5 + greenS*r;
                        ly = 5 + greenS*(q - 1) + 1;
                        uy = 5 + greenS*q;
                        AthetaW = zeros(size(bins));
                        for n = 1:1:numel(bins)
                            C = E(ly:uy,lx:ux).*exp(2*cos(2*pi/180*(bins(n) - phi(ly:uy,lx:ux))))/exp(2);
                            AthetaW(n) = sum(sum(C)); % AthetaW is a sum of alignment values between pixel gradient directions and each direction from 'bins', weighted by pixel gradient magnitudes.
                                  % The sum includes all pixels within the subregion bounded by lx, ux, ly, uy.
                        end
                        if max(AthetaW) > greenThresh
                            [~, Ang] = max(AthetaW); % Sets 'Ang' as the entry from 'bins' corresponding to the maximum 'AthetaW' value.
                            if Ang > 90
                                Ang = Ang - 180;
                            end
                            count = count + 1;
                            FiberAngle(count) = Ang;
                            FiberPosY(count) = round(5 + greenS*q - greenS/2);
                            FiberPosX(count) = round(5 + greenS*r - greenS/2);
                        end
                        clear AthetaW Ang;
                    end
                end

                if count < numel(FiberAngle)
                    FiberAngle(count+1:end) = [];
                    FiberPosY(count+1:end) = [];
                    FiberPosX(count+1:end) = [];
                end

                FiberOrientationX = cos(FiberAngle*pi/180);
                FiberOrientationY = sin(FiberAngle*pi/180);
                FiberPosY = -(FiberPosY-D(1));

                % Calculate MA, MVL, CSD
                c2m = mean(cos(2*FiberAngle*pi/180));
                s2m = mean(sin(2*FiberAngle*pi/180));
                MA = 180/pi*1/2*atan2(s2m, c2m);        % mean angle (deg)
                MVL = sqrt(s2m^2 + c2m^2) ;             % mean vector length
                CSD = 180/pi*1/2*sqrt(-2*log(MVL));     % circular standard deviation (deg)
                AD = 180/pi*1/2*sqrt(2*(1-MVL)) ;      % angular deviation (deg)

                if (dispRes == 'y') || (dispRes == 'Y') || (dispRes == 1)
                    % Display Results
                    figure;
                    clf;
                    imagesc(iImage);
                    colormap(gray);
                    hold on;
                    quiver(FiberPosX, -FiberPosY+D(1), FiberOrientationX, -FiberOrientationY, 0.5, 'y', 'LineWidth', 1);
                    hold off;
                    title(['MatFiber: Thresh = ' num2str(greenThresh) ', Size = ' num2str(greenS) ', MA = ' num2str(MA), ', MVL = ' num2str(MVL) ', CSD = ' num2str(CSD)]);
                    set(gca, 'DataAspectRatio', [1 1 1]);
                    display(fileNameG);
                    display([greenThresh greenS]);
                    display([MA MVL CSD]);
                end

                %make histogram of angle data
                edges = -90:binSize:90;
                angHist = histcounts(FiberAngle,edges);

                %save values
                statsG = [statsG; MA, MVL, CSD];
                histsG = [histsG;angHist];
                
                ind = ind +1;
                fileNameR = strcat(fLoc,name,'-',num2str(ind),'-red.tif');
            end

            if ~isempty(names)
                %file location to save to
                fileSave = strcat(sLoc,name,'-Alignment.xls');
                %Add averages to ends of stats
                namesS = [names;"Averages"];
                
                %once for red
                avgsR = [0,0,0];

                avgsR(2) = mean(statsR(:,2));

                angs = deg2rad(statsR(:,1));
                [~,avg] = circ_axialmean(angs,2,1);
                sd=circ_std(statsR(:,1), [],[],1);
                avgsR(1) = rad2deg(avg);
                avgsR(3)=rad2deg(sd);

                statsR = [statsR;avgsR];

                namesH = [names;"Total Sum"];
                histsR = [histsR;sum(histsR)];

                %Save stats
                %Titles of data
                dataTitles = ["SampleNumber","Mean Angle (Deg)","Mean Vector Length", "Angle StDev (Deg)"];
                %save to excel file
                xlswrite(fileSave,dataTitles,['Averages' char(redName)],'A1:D1')
                %dataNames
                range = ['A2:A' num2str(length(namesS)+1)];
                xlswrite(fileSave,namesS, ['Averages' char(redName)],range);
                %data
                range = ['B2:D' num2str(length(namesS)+1)];
                xlswrite(fileSave,statsR,['Averages' char(redName)],range);

                %Save histograms
                %Titles of data
                range = ['A2:A' num2str(length(namesH)+1)];
                xlswrite(fileSave,namesH,['Histograms' char(redName)],range);

                numBins = 180/binSize;
                binNames = " ";
                for l = 1:numBins
                    binStart = -90+((l-1)*binSize);
                    binEnd = -90+(l*binSize);
                    str = string([num2str(binStart) '-' num2str(binEnd)]);
                    binNames(l) = str;
                end
                range = ['B1:' Alphabet(numBins+1) '1'];
                xlswrite(fileSave,binNames,['Histograms' char(redName)],range);

                letter = Alphabet(numBins+1);
                range = ['B2:' letter num2str(length(namesH)+1)];
                xlswrite(fileSave,histsR,['Histograms' char(redName)],range);

                
                %once for green
                avgsG = [0,0,0];

                avgsG(2) = mean(statsG(:,2));

                angs = deg2rad(statsG(:,1));
                [~,avg] = circ_axialmean(angs,2,1);
                sd=circ_std(statsG(:,1), [],[],1);
                avgsG(1) = rad2deg(avg);
                avgsG(3)=rad2deg(sd);

                statsG = [statsG;avgsG];

                histsG = [histsG;sum(histsG)];

                %Save stats
                %save to excel file
                xlswrite(fileSave,dataTitles,['Averages' char(greenName)],'A1:D1')
                %dataNames
                range = ['A2:A' num2str(length(namesS)+1)];
                xlswrite(fileSave,namesS, ['Averages' char(greenName)],range);
                %data
                range = ['B2:D' num2str(length(namesS)+1)];
                xlswrite(fileSave,statsG,['Averages' char(greenName)],range);

                %Save histograms
                %Titles of data
                range = ['A2:A' num2str(length(namesH)+1)];
                xlswrite(fileSave,namesH,['Histograms' char(greenName)],range);

                numBins = 180/binSize;
                binNames = " ";
                for l = 1:numBins
                    binStart = -90+((l-1)*binSize);
                    binEnd = -90+(l*binSize);
                    str = string([num2str(binStart) '-' num2str(binEnd)]);
                    binNames(l) = str;
                end
                range = ['B1:' Alphabet(numBins+1) '1'];
                xlswrite(fileSave,binNames,['Histograms' char(greenName)],range);

                letter = Alphabet(numBins+1);
                range = ['B2:' letter num2str(length(namesH)+1)];
                xlswrite(fileSave,histsG,['Histograms' char(greenName)],range);

            end
        end
    end
end
