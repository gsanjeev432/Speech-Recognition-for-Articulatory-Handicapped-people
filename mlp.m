clc;
clear all;
close all;

%% Input training data

P = xlsread('D:\Sanjeev\speech_recognition\Features\0-10.xlsx');  % excel file where all features of training data are stored
P = P';
%data labels
T = xlsread('D:\Sanjeev\speech_recognition\Features\0-10labels.xlsx');  % excel file where all labels of training data are stored
T = T';
net = perceptron;
net = configure(net,P,T);

net.trainParam.epochs = 50;
net = train(net,P,T);