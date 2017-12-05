Names = {'OFFSET';'VIX   ';'PSL   ';'PSIN  ';'PSV   ';'MK    ';'MKL   ';'SHPO  ';'PVOL  ';'DVOL  ';
    'MCAP  ';'RVOLA ';'PRC   ';'AWSHP ';'SLOW  '};
n = 98268;
ntrain = 78614;
ntest = 19654;

xtr = Xcsv(1:ntrain,:);
xtest = Xcsv((ntrain+1):n,:);
ytr = YCSV(1:ntrain,:);
ytest = YCSV((ntrain+1):n,:);

sizes = (1:50)*100;
L1 = zeros(50);
MSE = zeros(50);
NLeaf = zeros(50);
%parfor i = 1:50
 %   fitrtree(xtr,ytr,'MinLeafSize',i,'PredictorNames',Names);
 %   [MSE(i),L1(i),NLeaf(i)] = cvloss(tree1);
    
%end

%mypool = parpool(8);
%paroptions = statset('UseParallel',true);

%B = TreeBagger(100,xtr,ytr,'MinLeafSize',50,'Method','r','Options',paroptions);

yhat = predict(B,xtr);
mean(abs(ytr-yhat)) %0.1493

yhatt = predict(B,xtest); %0.1586
mean(abs(ytest - yhatt));


error_forest_test = abs(ytest - yhatt);
error_forest_train = abs(ytr-yhat);



tree1 = fitrtree(xtr,ytr,'MinLeafSize',500,'PredictorNames',Names);

yhat = predict(tree1,xtr); %0.1920
yhatt = predict(tree1,xtest); %0.1949


mean(abs(yhat-ytr))
mean(abs(yhatt-ytest))


hold off
figure
hold on
cdfplot(error_forest_train)
cdfplot(error_forest_test)
set(findall(gca,'Type','Line'),'LineWidth',1);

legend('Training Set', 'Test Set')

hold off
figure
hold on
cdfplot(x2abs)
cdfplot(error_forest_train)
cdfplot(error_forest_test)
set(findall(gca,'Type','Line'),'LineWidth',1);
legend('l1 k-sparse Test', 'Random Forest Train', 'Random Forest T

abs(Ymean-realY)

