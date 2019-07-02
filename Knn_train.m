clc;
close all;

%% Input training data

traindata = xlsread('D:\Sanjeev\speech_recognition\Features\0-10.xlsx');  % excel file where all features of training data are stored
% m = mean(traindata); 
% s = std(traindata);
% traindata = (traindata-m)./s;
%data labels
labels=xlsread('D:\Sanjeev\speech_recognition\Features\0-10labels.xlsx');  % excel file where all labels of training data are stored


% select value of k
% k = 1; % value of number of nearest neighbours
testdata = xlsread('D:\Sanjeev\speech_recognition\Features\t0-10.xlsx');  % excel file where all features of testing data are stored
% m = mean(testdata); 
% s = std(testdata);
% testdata = (testdata-m)./s;
%% Data classification
tic
output = fitcknn(traindata,labels,'NumNeighbors',1,'Standardize',1,'Distance','cosine');
% output = fitcknn(traindata,labels,'OptimizeHyperparameters','auto');
% output = fitcensemble(traindata,labels,'Method','Bag');
predicted_labels = predict(output,testdata);
toc

%   Obtaining testing data labels
testlabel = xlsread('D:\Sanjeev\speech_recognition\Features\test0-10.xlsx');
obtained = predicted_labels;


%   Calculating classification accuracy
 tp = 0;
    [r, c] = size(testlabel);
    for  i = 1:r
        for j = 1:c
            if obtained(i,j) == testlabel(i,j)
                tp = tp+1;
            end
        end
    end
    
    accuracy = (tp/r)*100;

  