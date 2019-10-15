%%Take excel file nuclear stats and run summary statistics

close all
clear all
clc

%%%%%%%%%%%%%%%%%
%only change parameters in this section

%file location for .xls file include final \
fLoc = "E:\EmmaTrionaPostDocResults\BoseExperimentSeptember2018\AnalysisofSeptember2018BOSEexperiment\Emmaki67analysisSept2018\";

%cell seeding densities (as written in titles, in "" with commas between)
sden = ["225","300"];
%strain conditions (as written in titles, in "" with commas between)
strains = ["bs","ss","d0"];
%number of samples
numSamp = 4;

%Size of histogram bin. Make sure 180 is evenly divisible by this number
binSize=5;

%Image Scale in pixels/micron (you can check this in ImageJ)
scale = 2.0858;

%number of pixels per side (for example for 1024x1024 enter 1024)
numPix = 1024;
%%%%%%%%%%%%%%%%%


for i = 1:length(sden)
    for j = 1:length(strains)
        for k = 1:numSamp
            fileName = char(strcat(sden(i),strains(j),num2str(k)));
                   
            %initialize variable storage
            numbers = NaN(1,300);
            angles = NaN(1,300);
            angle_stds = NaN(1,300);
            histCounts = NaN(300,(180/binSize));
            ratios = NaN(1,300);
            ratio_stds = NaN(1,300);
            areas = NaN(1,300);
            area_stds = NaN(1,300);
            
            numsK = NaN(1,300);
            anglesK = NaN(1,300);
            angle_stdsK = NaN(1,300);
            histCountsK = NaN(300,(180/binSize));
            ratiosK = NaN(1,300);
            ratio_stdsK = NaN(1,300);
            areasK = NaN(1,300);
            area_stdsK = NaN(1,300);
            XY=NaN(300,2);
            
           
            filePath = strcat(fLoc, fileName, '.xls');
            
            if exist(filePath)==2
                 %set up for while loop for each image
                ind = 1;
                [A,B] = xlsfinfo(filePath);
                sheetValid = any(strcmp(B, num2str(ind)));
                while sheetValid ==1
                    
                    data = xlsread(filePath,num2str(ind));

                    if ~isempty(data)
                        [number,angle,angle_std,hist_counts,ratio,ratio_std,area,area_std]=NuclSumStats(data,binSize);
                        numbers(ind) = number;
                        angles(ind) = angle;
                        angle_stds(ind) = angle_std;
                        histCounts(ind,:) = hist_counts;
                        ratios(ind) = ratio;
                        ratio_stds(ind) = ratio_std;
                        areas(ind)=area;
                        area_stds(ind)=area_std;
                    else
                        numbers(ind) = 0;
                        angles(ind) = NaN;
                        angle_stds(ind) = NaN;
                        histCounts(ind,:) = NaN;
                        ratios(ind) = NaN;
                        ratio_stds(ind) = NaN;
                        areas(ind)=NaN;
                        area_stds(ind)=NaN;
                        
                        

                    %Histogram
                    % don't recommend using this for final images, just for checking data.
                    % Comment out if running in a loop
%                         start = -90+(binSize/2);
%                         stop = 90-(binSize/2);
%                         y = start:binSize:stop;
%                         figure
%                         bar(y,hist_counts)

                    end
                    
                    if sden(i) == "K-"
                        
                        [A,B] = xlsfinfo(filePath);
                        sheetValid = any(strcmp(B, [num2str(ind) 'Ki67']));

                        if sheetValid
                            data = xlsread(filePath,[num2str(ind) 'Ki67']);

                            if ~isempty(data)
                                [numberK,angleK,angle_stdK,hist_countsK,ratioK,ratio_stdK,areaK,area_stdK]=NuclSumStats(data,binSize);
                                numsK(ind) = numberK;
                                anglesK(ind) = angleK;
                                angle_stdsK(ind) = angle_stdK;
                                ratiosK(ind) = ratioK;
                                ratio_stdsK(ind) = ratio_stdK;
                                areasK (ind) = areaK;
                                area_stdsK(ind)= area_stdK;
                                histCountsK(ind,:) = hist_countsK;
                            else
                                numsK(ind) = 0;
                                anglesK(ind) = NaN;
                                angle_stdsK(ind) = NaN;
                                ratiosK(ind) = NaN;
                                ratio_stdsK(ind) = NaN;
                                areasK (ind) = NaN;
                                area_stdsK(ind)= NaN;
                                histCountsK(ind,:) = NaN;
                                
                            end
                                XY(ind,:) = [numbers(ind), numsK(ind)];
                        end
%                                  
                    end


                        %Histogram
                        % don't recommend using this for final images, just for checking data.
                        % Comment out if running in a loop
%                         start = -90+(binSize/2);
%                         stop = 90-(binSize/2);
%                         y = start:binSize:stop;
%                         figure
%                         bar(y,hist_counts)

                    ind = ind+1;
                    [A,B] = xlsfinfo(filePath);
                    sheetValid = any(strcmp(B, num2str(ind)));

                    end
          

                %put all data except histograms in one array
                datas = [numbers;angles;angle_stds;ratios;ratio_stds;areas;area_stds];

                %Titles of data
                dataTitles=["Image Number";"Number of Nuclei";"Average Angle (Deg)"; "Angle StDev (Deg)"; "Average Ratio Short/Long Axis"; "Ratio StDev"; "Average Nuclear Area"; "Area StDev"];
                %save to excel file
                xlswrite(filePath,dataTitles,'Averages','A1:A8')

                %sample numbers
                sNums = 1:ind;
                %save to excel file
                letter = Alphabet(ind+1);
                range = ['B1:' letter '1'];
                xlswrite(filePath,sNums,'Averages',range)

                %save initial data starting with B2
                for l=1:7
                    range = ['B' num2str(l+1) ':' letter num2str(l+1)];
                    xlswrite(filePath,datas(l,:),'Averages',range)
                end

                %save histograms to separate tab

                %sample numbers
                vertSNums=transpose(sNums);
                vertSNums=[vertSNums;"Total Sum"];
                range = ['A2:A' num2str(ind+1)];
                xlswrite(filePath,vertSNums,'Histograms',range);

                %bin names
                numBins = 180/binSize;
                binNames = " ";
                for l = 1:numBins
                    binStart = -90+((l-1)*binSize);
                    binEnd = -90+(l*binSize);
                    str = string([num2str(binStart) '-' num2str(binEnd)]);
                    binNames(l) = str;
                end
                range = ['B1:' Alphabet(numBins+1) '1'];
                xlswrite(filePath,binNames,'Histograms',range);


                %histograms
                histCounts = [histCounts; sum(histCounts,1)];
                letter = Alphabet(numBins+1);
                range = ['B2:' letter num2str(ind+1)];
                xlswrite(filePath,histCounts,'Histograms',range);


                %run summary stats
                %column titles for summary stats
                summary = ["Sample Average","Sample StDev"];

                for l=1:7
                    rdata = datas(l,:);
                    rdata(isnan(rdata)) = [];
                    if l==2
                        %circular average and stdev;
                        %axial data has a correction factor of 2
                        angs = deg2rad(rdata);
                        [~,avg] = circ_axialmean(angs,2,2);
                        sd=circ_std(rdata, [],[],2);
                        avg = rad2deg(avg);
                        sd=rad2deg(sd);
                    else
                        %regular average and stdev
                        avg = mean(rdata);
                        sd = std(rdata);
                    end
                    summary(l+1,:) = [avg,sd];
                end

                %add summary stats to data
                letter1 = Alphabet(ind+2);
                letter2 = Alphabet(ind+3);
                range = [letter1 '1:' letter2 '8'];
                xlswrite(filePath,summary,'Averages',range)
            
                if sden(i) == "K-"
                    
                    %put all data except histograms in one array
                    datasK = [numsK;anglesK;angle_stdsK;ratiosK;ratio_stdsK;areas;area_stdsK];
                    
                    %Titles of data
                    dataTitlesK=["Image Number";"Number of Nuclei"; "Average Angle (Deg)"; "Angle StDev (Deg)"; "Average Ratio Short/Long Axis"; "Ratio StDev"; "Average Nuclear Area"; "Area StDev"];
                    %save to excel file
                    xlswrite(strcat(fLoc, fileName),dataTitlesK,'Ki67Averages','A1:A8')
                    
                    %sample numbers
                    sNums = 1:ind;
                    %save to excel file
                    letter = Alphabet(ind+1);
                    range = ['B1:' letter '1'];
                    xlswrite(filePath,sNums,'Ki67Averages',range)

                    %save initial data starting with B2
                    for l=1:7
                        range = ['B' num2str(l+1) ':' letter num2str(l+1)];
                        xlswrite(filePath,datasK(l,:),'Ki67Averages',range)
                    end

                    %save histograms to separate tab

                    %sample numbers
                    vertSNums=transpose(sNums);
                    vertSNums=[vertSNums;"Total Sum"];
                    range = ['A2:A' num2str(ind+1)];
                    xlswrite(filePath,vertSNums,'Ki67Histograms',range);

                    %bin names
                    numBins = 180/binSize;
                    binNames = " ";
                    for l = 1:numBins
                        binStart = -90+((l-1)*binSize);
                        binEnd = -90+(l*binSize);
                        str = string([num2str(binStart) '-' num2str(binEnd)]);
                        binNames(l) = str;
                    end
                    range = ['B1:' Alphabet(numBins+1) '1'];
                    xlswrite(filePath,binNames,'Ki67Histograms',range);


                    %histograms
                    histCountsK = [histCountsK; sum(histCountsK,1)];
                    letter = Alphabet(numBins+1);
                    range = ['B2:' letter num2str(ind+1)];
                    xlswrite(filePath,histCountsK,'Ki67Histograms',range);


                    %bin names
                    numBins = 180/binSize;
                    binNames = " ";
                    for l = 1:numBins
                        binStart = -90+((l-1)*binSize);
                        binEnd = -90+(l*binSize);
                        str = string([num2str(binStart) '-' num2str(binEnd)]);
                        binNames(l) = str;
                    end
                    range = ['B1:' Alphabet(numBins+1) '1'];
                    xlswrite(strcat(fLoc, fileName),binNames,'Ki67Histograms',range);

                 
                    %XY relating number of Ki67+ cells to total cells/frame
                    titles =["Total Nuclei", "Ki67+ Nuclei"];
                    xlswrite(strcat(fLoc, fileName),titles,'Ki67XY','A1:B1');
                    range = ['A2:B' num2str(length(XY)+1)];
                    xlswrite(strcat(fLoc, fileName),XY,'Ki67XY',range);
                end
            end
        end
    end
end