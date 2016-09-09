D = utfs';
T = ProCode';

mistake = 100000000000;
for i = 1:5
    for j = 1:5
        net = feedforwardnet([i,j]);
        net = configure(net, D, T);
        net.trainParam.epochs = 100;
        net = train(net, D, T);
        y = net(D);
        p = perform(net,T,y);
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

mistakegd = 100000000000;
mistakeda = 100000000000;
mistakedm = 100000000000;
mistakerp = 100000000000;
for i = 1:3
    for j = 1:10
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

for i = 1:40
    for j = 1:40
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

scatter(x,y,'r')
hold on
scatter(x,T,'b')
legend('Real','Estimation')
title('Real and Estimation on GDP Per Capita')
ylabel('GDP Per Capita of Destinations')
xlabel('Index of samples');

smart = 0;
% narrow
max = 1500; 
for k = 0:max
    counter = 0;
    k
    for i = 1:65499
        if y(i) - T(i) < k & y(i) - T(i) > k - max
            counter = counter + 1;
        end
            if counter > smart
                smart = counter;
                j = k;
            end
    end
end

% Medium
max = 2000; 
smartm = 0;
for k = 0:max
    counter = 0;
    for i = 1:65499
        if y(i) - T(i) < k & y(i) - T(i) > k - max
            counter = counter + 1;
        end
            if counter > smartm
                smartm = counter;
                jm = k;
            end
    end
end

% General
max = 3000; 
smartg = 0;
for k = 0:max
    counter = 0;
    for i = 1:65499
        if y(i) - T(i) < k & y(i) - T(i) > k - max
            counter = counter + 1;
        end
            if counter > smartg
                smartg = counter;
                jg = k;
            end
    end
end

    
 smartl = [smart,smartm,smartg]
 jl = [j,jm,jg]

