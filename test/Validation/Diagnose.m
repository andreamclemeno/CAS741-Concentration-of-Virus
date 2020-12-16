%% CAS 741 Project - Testing Code (Diagnose)
%Andrea
close all;
clear all;

%% inputs
vLoado = 15000000; %in mol/mL -- typical value 10000000
vLoadt = 5000000; %in mol/L -- typical value 
ttest = 10;
tpredict = 30;% in s -- 30 days in seconds = 2592000 s

%test = [vLoado vLoadt ttest tpredict]
pt = [947.6*100000 706.2*100000 9-7 15-7;
    284.0*100000 216*100000 6-5 14-5; 
    1485*100000 701.6*100000 8-3 10-3;
    2398.6*100000 337.2*100000 9-4 12-4;
    2427.9*100000 2200.4*100000 7-4 11-4;
    355.4*100000 146.8*100000 12-8 19-8;
    9622.8*100000 7830.0*100000 10-9 14-9]

% calculations
for i = [1:7]
elimConst(i) = (log(pt(i,1)) - log(pt(i,2)))\(pt(i,3));
predictedVL(i) = pt(i,1) * (exp(-1*elimConst(i)*pt(i,4)));
end

elimConst = elimConst'
predictedVL = predictedVL'

%results from study

studyVL = [14.4*100000;143.0*100000;
        564*100000;340.6*100000;1134.3*100000;100.9*100000;715.81*100000]

%% graphing
for i = [1:7]
 vLoad_Diagnose = [pt(i,1) pt(i,2) predictedVL(i)];
 vLoad_Strafford = [pt(i,1) pt(i,2) studyVL(i)];
 time = [0 pt(i,3) pt(i,4)];
 
% error
% percenterror = [experimental value - theoretical value] / theoretical value x 100%
error(i)= (abs(predictedVL(i) - studyVL(i))/predictedVL(i))*100
   
figure
plot(time, vLoad_Diagnose);
hold on;
plot(time,vLoad_Strafford);
title(sprintf('Strafford vs. Diagnose Viral Load for Patient %d',i));

xlabel('time (days)'); ylabel('HIV-1 RNA (mol/mL)');
legend('vLoad_{Diagnose}','vLoad_{Strafford}');
end


%%
%test_normal = [10000000 5000000 10 30];
%test_2_1=[0 5000000 1 30]; % vLoado
%test_2_2=[-10000000 5000000 1 30];
%test_3_1=[0 5000000 1 30]; % vLoadt
%test_3_2=[-10000000 5000000 1 30];
%test_4_1=[5000000 10000000 1 30]; % vLoadt>vLoado
%test_5_1=[10000000 5000000 0 30]; % t_time
%test_5_2=[10000000 5000000 -1 30]; % t_time
%test_6_1=[10000000 5000000 0 30]; % t_predicted
%test_6_2=[10000000 5000000 -1 30]; % t_predicted
%test_7_1=[10000000 5000000 30 1]; % t_time>t_predicted


