
for i = 1:47
    Data(i) = mean(utfssdel(:,i));
end

for i = 1:887 
    for j = 1:47
        utfData(i,j) = utfssdel(i,j) - Data(j);
    end
end

TTG = GDPPC'
DT = ToBeijing'


% NN

mistake = 100000000000;
for i = 1:20
    for j = 1:20
        net = feedforwardnet([i,j]);
        net = configure(net, DT, TTG);
        net.trainParam.epochs = 30;
        net = train(net, DT, TTG);
        y = net(DT);
        p = perform(net,TTG,y);
        if p < mistake
            mistake = p;
            bI = i;
            bJ = j;
        end
    end
end


% PCA
[coeff,score,latent,tsquared] = pca(ToBeijing);
reducedDimension = coeff(:,1:3);
reducedData = ToBeijing * reducedDimension;
reducedDataT = reducedData';


mistakegd = 100000000000;
mistakeda = 100000000000;
mistakedm = 100000000000;
mistakerp = 100000000000;
for i = 1:40
    for j = 1:40
        net = feedforwardnet([i,j]);
        net.trainParam.epochs = 30;
        net = configure(net, reducedDataT, TTG);
        net.trainParam.epochs = 30;
        net = traingd(net, reducedDataT, TTG);
        y = net(reducedDataT);
        p = perform(net,TTG,y);
        if p < mistakegd
            mistakegd = p;
            gdI = i;
            gdJ = j;
        end
        net = feedforwardnet([i,j]);
        net.trainParam.epochs = 30;
        net = configure(net, reducedDataT, TTG);
        net = traingda(net, reducedDataT, TTG);
        y = net(reducedDataT);
        p = perform(net,TTG,y);
        if p < mistakeda
            mistakeda = p;
            gdaI = i;
            gdaJ = j;
        end
        
        net = feedforwardnet([i,j]);
        net.trainParam.epochs = 30;
        net = configure(net, reducedDataT, TTG);
        net.trainParam.epochs = 30;
        net = traingdm(net, reducedDataT, TTG);
        y = net(reducedDataT);
        p = perform(net,TTG,y);
        if p < mistakedm
            mistakedm = p;
            gdmI = i;
            gdmJ = j;
        end
        
        net = feedforwardnet([i,j]);
        net.trainParam.epochs = 30;
        net = configure(net, reducedDataT, TTG);
        net.trainParam.epochs = 30;
        net = trainrp(net, reducedDataT, TTG);
        y = net(reducedDataT);
        p = perform(net,TTG,y);
        if p < mistakerp
            mistakerp = p;
            rpI = i;
            rpJ = j;
        end 
    end
end

mistakeList = [mistakegd,mistakeda,mistakedm,mistakerp];

IList = [ gdI, gdaI, gdmI,rpI];

JList = [ gdJ, gdaJ, gdmJ,rpJ];



//with adding 0 to missing data:
mistake = 100000000000;
for i = 1:20
    for j = 1:20
        net = feedforwardnet([i,j]);
        net = configure(net, DT, TTG);
        net.trainParam.epochs = 30;
        net = train(net, DT, TTG);
        y = net(DT);
        p = perform(net,D,T);
        if p < mistake
            mistake = p;
            bI = i;
            bJ = j;
        end
    end
end
