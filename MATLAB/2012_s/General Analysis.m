D = CombData';
T = MigrationRates';
Test = Result';

mistake = 100000000000;
for i = 1:2
    for j = 1:2
        net = feedforwardnet([i,j], 'traingd');
        net = configure(net, D, T);
        net.trainParam.epochs = 30;
        net = traingd(net, D, T);
        y = net(D);
        p = perform(net,T,y);
        if p < mistake
            mistake = p;
            bI = i;
            bJ = j;
        end
    end
end


mistakegd = 100000000000;
mistakeda = 100000000000;
mistakedm = 100000000000;
mistakerp = 100000000000;
for i = 1:10
    for j = 1:40
        net = feedforwardnet([i,j],'traingd');
        net = configure(net, D, T);
        net.trainParam.epochs = 100;
        net = traingd(net, D, T);
        y = net(D);
        p = perform(net,T,y);
        if p < mistakegd
            mistakegd = p;
            gdI = i;
            gdJ = j;
        end
        net = feedforwardnet([i,j],'traingda');
        net = configure(net, D, T);
        net.trainParam.epochs = 100;
        net = traingda(net, D, T);
        y = net(D);
        p = perform(net,T,y);
        if p < mistakeda
            mistakeda = p;
            gdaI = i;
            gdaJ = j;
        end
        
        net = feedforwardnet([i,j],'traingdm');
        net.trainParam.epochs = 100;
        net = configure(net, D, T);
        net = traingdm(net, D, T);
        y = net(D);
        p = perform(net,T,y);
        if p < mistakedm
            mistakedm = p;
            gdmI = i;
            gdmJ = j;
        end
        
        net = feedforwardnet([i,j],'trainrp');
        net.trainParam.epochs = 100;
        net = configure(net, D, T);
        net = trainrp(net, D, T);
        y = net(D);
        p = perform(net,T,y);
        if p < mistakerp
            mistakerp = p;
            rpI = i;
            rpJ = j;
        end 
    end
end

mistakeList = [mistakegd,mistakeda,mistakedm,mistakerp]

I = [gdI,gdaI,gdmI,rpI]

J = [gdJ,gdaJ,gdmJ,rpJ]


%2 years prediction:
i = I(1);
j = J(1);
net = feedforwardnet([i,j],'traingd');
        net = configure(net, D, T);
        net.trainParam.epochs = 100;
        net = traingd(net, D, T);
        y = net(D);
        mistakegd = perform(net,Test,y);
        
 i = I(2);
j = J(2);       
        net = feedforwardnet([i,j],'traingda');
        net = configure(net, D, T);
        net.trainParam.epochs = 100;
        net = traingda(net, D, T);
        y = net(D);
        mistakeda = perform(net,Test,y);

        
 i = I(3);
j = J(3);  
        net = feedforwardnet([i,j],'traingdm');
        net.trainParam.epochs = 100;
        net = configure(net, D, T);
        net = traingdm(net, D, T);
        y = net(D);
        mistakedm = perform(net,Test,y);


         i = I(4);
j = J(4);  
        net = feedforwardnet([i,j],'trainrp');
        net.trainParam.epochs = 100;
        net = configure(net, D, T);
        net = trainrp(net, D, T);
        y = net(D);
        p = perform(net,Test,y);
        if p < mistakerp
            mistakerp = p;
            rpI = i;
            rpJ = j;
        end 
