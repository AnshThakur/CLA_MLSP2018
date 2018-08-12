%% demo
clc;
clear;

%% load training data (N time D) 
load train1

%% learn a GMM or Pseudo-topic acoustic model 

[m,v,w]=gaussmix(train1,[],[],k); % diagnola covariances. Full covariance works betters but can produce ill-conditional covariances
gmm.mu=m;
gmm.Sigma=v;
gmm.PComponents=w;

%% Projecting the data in likelihood space (for simplicity of demo, we are using a subset of GMM training data)
   % in general, the data of all classes is projected on Likelihood space
data=train1(1:100,:);  
[pav] = getResponsibility(data,gmm);

%% learning an archetypal dictionary
   % parameter setting
param.p=20;  % learns a dictionary with 20 elements
param.robust=true;
param.epsilon=1e-3;  % width for Huber loss
param.computeXtX=true;
param.stepsFISTA=0;
param.stepsAS=20;
param.numThreads=-1;    

[D A B] = mexArchetypalAnalysis(pav',param);
 
%% obtaining CLA by simplex projevtion on the learned dictionary
CLA=full(mexDecompSimplex(pav',D,param))';






   
   


 