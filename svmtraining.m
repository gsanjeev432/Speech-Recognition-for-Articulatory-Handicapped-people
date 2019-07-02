clc;
clear all;
close all;

x=xlsread('D:\Sanjeev\speech_recognition\train\train_features.xlsx');  % excel file where all features of 40 images are stored
% Xdata=x';

%  grouping data
labels=xlsread('D:\Sanjeev\speech_recognition\train\train_labels.xlsx');  % excel file where all labels of training data are stored

test = xlsread('D:\Sanjeev\speech_recognition\train\test_features.xlsx')';  % excel file where all features of 40 images are stored
test = test';
[itrfin] = multisvm( x,labels,test);

%   Obtaining testing data labels
% testlabel = xlsread('D:\Sanjeev\speech_recognition\train\test_labels.xlsx');
obtained = itrfin;


%   Calculating classification accuracy
 tp = 0;
    [r c] = size(testlabel);
    for  i = 1:r
        for j = 1:c
            if obtained(i,j) == testlabel(i,j)
                tp = tp+1;
            end
        end
    end
    
    accuracy = (tp/r)*100
