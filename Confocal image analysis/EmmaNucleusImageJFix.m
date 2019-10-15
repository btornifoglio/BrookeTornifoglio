%%Run ImageJ nuclear stats and save as excel files
% Run InstallJava3D each time open Matlab

close all
clear all
clc

javaaddpath 'C:\Program Files\MATLAB\R2017a\java\mij.jar'

%%%%%%%%%%%%%%%%%
%only change parameters in this section

%file location for .tif file include final \
fLoc = "E:\EmmaTrionaPostDocResults\SUCCESStubularvesselsJulyAug2019\Day11SUCCESSseedingvessel7.8.19\pulledoutfiles\";

%file location include final \
sLoc = "E:\EmmaTrionaPostDocResults\SUCCESStubularvesselsJulyAug2019\Day11SUCCESSseedingvessel7.8.19\testEmmaBrooke\";

%cell seeding densities (as written in titles, in "" with commas between)
sDen = ["Day11"];
%strain conditions (as written in titles, in "" with commas between)
strains = ["v2"];
%number of samples
%numSamp = 2;

%Image Scale in pixels/micron (you can check this in ImageJ)
scale = 1.7600;
%%%%%%%%%%%%%%%%%

%change for Java uses
javLoc = strrep(fLoc, '\', '\\');

Miji
for i = 1:length(sDen)
    for j = 1:length(strains)
        %for k = 1:numSamp
            name = char(strcat(sDen(i),strains(j)));
            
            %set up for while loop for each image
            ind = 1;
            imgPath = strcat(javLoc,name,'-',num2str(ind),'-blue.tif');
            while exist(imgPath) ==2
                args = strcat('path=[', imgPath ,']');
                MIJ.run('Open...', args)
                args2 = ['distance=' num2str(scale) ' known=1 pixel=1 unit=micron'];
                MIJ.run('Set Scale...',args2);
                MIJ.run('Subtract Background...','rolling=50');
                MIJ.run('Threshold...')
                uiwait(msgbox('Check Threshold and Click Ok'));
                MIJ.run('Convert to Mask');
                MIJ.run('Fill Holes');
                MIJ.run('Watershed');
                MIJ.run('Analyze Particles...', 'size=20-Infinity display exclude clear include summarize'); 

                %get results from imagej
                colLabels = MIJ.getListColumns();
                colLabels = string(colLabels);
                colLabels = transpose(colLabels);
                table = MIJ.getResultsTable();
                [r,c] = size(table);
                
                saveName = [char(sLoc) char(name)];
                
                if ~isempty(table)
                    xlswrite(saveName,colLabels,num2str(ind),'A1:D1');
                    range = ['A2:D' num2str(r+1)];
                    xlswrite(saveName,table,num2str(ind),range);
                else
                    xlswrite(saveName,"No Nuclei",num2str(ind),'A1:A1');
                end
                
                ind = ind+1;
                imgPath = strcat(javLoc,name,'-',num2str(ind),'-blue.tif'); 
                MIJ.run('Close All');
            end
        %end
    end
end
                