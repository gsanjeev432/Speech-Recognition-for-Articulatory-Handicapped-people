close all;
clc; 
%%  Data Acquisition 

wavFiles = 'D:\Sanjeev\speech_recognition\test\';          %  Specify data folder
file_ext = '.wav';                                          %   Include all .wav files
folder_content = dir ([wavFiles,'*',file_ext]); 
numfiles = length(folder_content);                          %   No. of files

           
%%  Loop for multiple files

for k = 1:1:numfiles 
    string = [wavFiles,folder_content(k,1).name];
    
    % Read speech samples and sampling rate from file
    
    [ s, fs ] = audioread( string );

%%
    % Feature extraction (MFCC)
    
    c = frftmfcc( s, fs );     
    c(~isfinite(c))=0;
    c = mean(c,2);
    c = transpose(c);
    disp(folder_content(k,1).name);
    xlswrite('D:\Sanjeev\speech_recognition\train\FRFTtest.xlsx',c,'Sheet1',num2str(k));   %   Writing data to excel spreadsheet
  
end