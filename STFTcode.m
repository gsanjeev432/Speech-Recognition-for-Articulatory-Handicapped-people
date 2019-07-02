close all; 
clc; 
%% 
wavFiles = 'D:\Sanjeev\speech_recognition\train\';
file_ext = '.wav';
folder_content = dir ([wavFiles,'*',file_ext]); 
numfiles = length(folder_content);

%%

for k = 1:numfiles 
    string = [wavFiles,folder_content(1,1).name];
    [ x, fs ] = audioread(string);        %   reading files one by one
     % Define variables
    xlen = length(x);                   % length of the signal
    wlen = 1024;                        % window length (recomended to be power of 2)
    hop = wlen/4;                       % hop size (recomended to be power of 2)
    nfft = 4096;                        % number of fft points (recomended to be power of 2)

      % perform STFT
    [S, f, t] = stft(x, wlen, hop, nfft, fs);

    % define the coherent amplification of the window
    K = sum(hamming(wlen, 'periodic'))/wlen;

    % take the amplitude of fft(x) and scale it, so not to be a
    % function of the length of the window and its coherent amplification
    S = abs(S)/wlen/K;

    % correction of the DC & Nyquist component
    if rem(nfft, 2)                     % odd nfft excludes Nyquist point
        S(2:end, :) = S(2:end, :).*2;
    else                                % even nfft includes Nyquist point
        S(2:end-1, :) = S(2:end-1, :).*2;
    end

    % convert amplitude spectrum to dB (min = -120 dB)
    S = 20*log10(S + 1e-6);

      STFT = mean(S);    
      disp(folder_content(k,1).name);
      xlswrite('STFT_train.xlsx',STFT,'Sheet1',num2str(k));

end

