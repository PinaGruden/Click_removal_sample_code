% SAMPLE CODE for De-clicking procedure used in 
% Gruden, Nosal & Oleson (2021). Tracking Time Differences of Arrivals of 
% multiple sound sources in the presence of clutter and missed detections.
% Submitted to Journal of the Acoustical Society of America.

clear, close all

% Load example containing echolocation clicks and whistles
[x,fs]= audioread('Example_FKW_wWhistlesandClicks.wav');

% STEP 1
%~~~~~ Bandpass Butterworth ~~~~~~~~~
freq_filter =[2500,12000]; % frequency filter limits (Hz)- bandpass- where the whistles occur
[b,a] = butter(4,freq_filter/(fs/2),'bandpass'); %Coefficients for Butterworth
x_filt = filtfilt(b,a,x); % Butterworth in forward-reverse fashion- so that it is zero phase

% STEPS 2 and 3
%~~~~~~ Weighting function and median filtering ~~~~~~~~~~
tresh= 5; %threshold used in weighting function (see Gillespie et al (2013), Section II.A.1 for details)
p= 6; %power factor used in weighting function (see Gillespie et al (2013), Section II.A.1 for details)
y = preprocess(x_filt,1024,0.5,tresh,p); 

%y is a time domain de-clicked signal