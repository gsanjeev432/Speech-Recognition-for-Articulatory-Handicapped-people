close all;  
clc; 

%%  Data Acquisition 

wavFiles =  'D:\Sanjeev\speech_recognition\train\';             %  Specify data folder
file_ext = '.wav';                          %   Include all .wav files
folder_content = dir ([wavFiles,'*',file_ext]); 
numfiles = length(folder_content);          %   No. of files


%%  Loop for multiple files

for k = 1:numfiles 
    string = [wavFiles,folder_content(33,1).name];   %   Filename
    
%     Read speech samples and sampling rate from file
    d = 1;
    wavfile = miraudio(string);             %   Read file information
    dmfcc = mirmfcc(wavfile, 'Delta', d);
    ddmfcc = mirmfcc(wavfile, 'Delta', 2);
    dmfcc = mirgetdata(dmfcc);  
    ddmfcc = mirgetdata(ddmfcc);     
    disp(strcat('dmfcc',folder_content(k,1).name));
    xlswrite('dmfcc.xlsx',dmfcc,'Sheet1',num2str(k));
    disp(strcat('ddmfcc',folder_content(k,1).name));
    xlswrite('ddmfcc.xlsx',ddmfcc,'Sheet1',num2str(k));    
end