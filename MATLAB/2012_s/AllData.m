D = utfs';
T = ProCode';
D10 = stH';

mistake = 100000000000;
for i = 1:5
    for j = 1:5
        net = feedforwardnet([i,j]);
        net = configure(net, DT, T);
        net.trainParam.epochs = 150;
        net = train(net, DT, T);
        y = net(DT);
        p = perform(net,D,T);
        if p < mistake
            mistake = p;
            bI = i;
            bJ = j;
        end
    end
end

[coeff,score,latent,tsquared] = pca(utfs);
reducedDimension = coeff(:,1:3);
reducedData = utfs * reducedDimension;
reducedDataT = reducedData';


x = [];
y = [];
for i = 1:8
    x(i) = latent(i) / sum(latent);
    y(i) = latent(i) / sum(latent);
end

for i = 2:8
    y(i) = y(i) + y(i-1);
end

bar(x,'b')
hold on
plot(y,'r','LineWidth',2)
ylabel('Percentage of Eigenvalues');
xlabel('Rank');
legend('Eigenvalues','Sum of pre-ranked eigenvalues')
title('Percentage of Eigenvalues')

%2010
D10 = stH';
[coeff,score,latent,tsquared] = pca(stH);

x = [];
y = [];
for i = 1:8
    x(i) = latent(i) / sum(latent);
    y(i) = latent(i) / sum(latent);
end

for i = 2:8
    y(i) = y(i) + y(i-1);
end

bar(x,'b')
hold on
plot(y,'r','LineWidth',2)
ylabel('Percentage of Eigenvalues');
xlabel('Rank');
legend('Eigenvalues','Sum of pre-ranked eigenvalues')
title('Percentage of Eigenvalues in 2010 (1st Half)')


%tobeijing
[coeff,score,latent,tsquared] = pca(ToBeijing);
reducedDimension = coeff(:,1:3);
reducedData = utfs * reducedDimension;
reducedDataT = reducedData';


mistakegd = 100000000000;
mistakeda = 100000000000;
mistakedm = 100000000000;
mistakerp = 100000000000;
for i = 1:40
    for j = 1:40
        net = feedforwardnet([i,j]);
        net.trainParam.epochs = 30;
        net = configure(net, reducedDataT, T);
        net.trainParam.epochs = 30;
        net = traingd(net, reducedDataT, T);
        y = net(reducedDataT);
        p = perform(net,T,y);
        if p < mistakegd
            mistakegd = p;
            gdI = i;
            gdJ = j;
        end
        net = feedforwardnet([i,j]);
        net.trainParam.epochs = 30;
        net = configure(net, reducedDataT, T);
        net = traingda(net, reducedDataT, T);
        y = net(reducedDataT);
        p = perform(net,T,y);
        if p < mistakeda
            mistakeda = p;
            gdaI = i;
            gdaJ = j;
        end
        
        net = feedforwardnet([i,j]);
        net.trainParam.epochs = 30;
        net = configure(net, reducedDataT, T);
        net.trainParam.epochs = 30;
        net = traingdm(net, reducedDataT, T);
        y = net(reducedDataT);
        p = perform(net,T,y);
        if p < mistakedm
            mistakedm = p;
            gdmI = i;
            gdmJ = j;
        end
        
        net = feedforwardnet([i,j]);
        net.trainParam.epochs = 30;
        net = configure(net, reducedDataT, T);
        net.trainParam.epochs = 30;
        net = trainrp(net, reducedDataT, T);
        y = net(reducedDataT);
        p = perform(net,T,y);
        if p < mistakerp
            mistakerp = p;
            rpI = i;
            rpJ = j;
        end 
    end
end

mistakeList = [mistakegd,mistakeda,mistakedm,mistakerp];