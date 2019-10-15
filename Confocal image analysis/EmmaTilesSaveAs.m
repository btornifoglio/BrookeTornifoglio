%%Split files by color and save as Tif
% Run InstallJava3D each time open Matlab
close all
clear all
clc

javaaddpath 'D:\Programs\java\mij.jar'

%%%%%%%%%%%%%%%%%
%only change parameters in this section
%file location for .lif file include final \
fLoc = "D:\Everything\Recellularisation\001\Day11\";
%file save location include final \
saveLoc = "D:\Everything\Recellularisation\001\Day11\TileSaveAs\";

%cell seeding densities (as written in titles, in "" with commas between)
sDen = ["Day11"];
%strain conditions (as written in titles, in "" with commas between)
strains = ["v"];
%number of samples
numSamp = 2;
%%%%%%%%%%%%%%%%%

%change for Java uses
javSLoc = strrep(saveLoc, '\', '\\');
%change for Java uses
javLoc = strrep(fLoc, '\', '\\');

Miji
for i = 1:length(sDen)
    for j = 1:length(strains)
        for k = 1:numSamp
            name = char(strcat(sDen(i),strains(j),num2str(k)));
            imgPath = strcat(javLoc,name,'.lif');
            if exist(imgPath) ==2
                %User input of start picture number
                dlg = ['What number image is the tileScan' name ' ?']; 
                input1 = [];
                while isempty(input1)
                    input1=str2num(cell2mat(inputdlg(dlg,' ',1,{'1'})));
                    if ~isscalar(input1)
                        input1 = [];
                    else
                        if input1 < 1
                            input1 = [];
                        end
                    end
                end
                %User input of how many individual pictures are in the
                %file, not including merged image
                dlg = ['How many tiles are in ' name '.lif?']; 
                input = [];
                while isempty(input)
                    input=str2num(cell2mat(inputdlg(dlg)));
                    if ~isscalar(input)
                        input = [];
                    else
                        if input < 1
                            input = [];
                        end
                    end
                end
            
                
                for fNum = input1:input+input1-1
                    args = strcat('open=[', imgPath, '] color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT series_',num2str(fNum));
                    MIJ.run('Bio-Formats Importer', args);
                    MIJ.run('Grouped Z Project...', 'projection=[Max Intensity]')
                    MIJ.run('Stack to Images');
                    images=string(MIJ.getListImages());
                    for m = 1:length(images)
                        nameIm = char(images(m));
                        if nameIm(1) == 'M'
                            image = uint16(MIJ.getImage(nameIm));
                            n = str2num(nameIm(length(nameIm)));
                            switch n
                                %blue
                                case 1
                                    imwrite(image,char(strcat(saveLoc, name, '-', num2str(fNum), '-blue.tif')));
                               
                                %red
                                case 2
                                    imwrite(image,char(strcat(saveLoc, name, '-', num2str(fNum), '-red.tif')));
                                
                                %green
                                case 3
                                    imwrite(image,char(strcat(saveLoc, name, '-', num2str(fNum), '-green.tif')));
                            end
                        end     
                    end
                    MIJ.closeAllWindows();
                end
            end
        end
    end
end
MIJ.exit();
