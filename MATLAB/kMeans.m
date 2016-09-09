%Input 2011InterCombData.csv as InterCombData

icd = InterCombData;

icd = normc(icd);

icd = icd';

index = [];
max = 5;
[idx,C] = kmeans(icd,max);

for i = 1:max
    center(i) = 9999999;
end

for i=1:18
    if center(idx(i)) >= abs(sum(icd(i,:) - C(idx(i,:))))
        center(idx(i)) = abs(sum(icd(i,:) - C(idx(i,:))));
        index(idx(i)) = i;
    end
end
index

perf = [0.0193	0.0402	0.0336
0.0184	0.0348	0.0336
0.0182	0.0347	0.0337
0.0185	0.0347	0.0337
0.018	0.0353	0.0336]

for i=1:5
    avgB(i) = mean(perf(i,:))
end

perf = [0.0213	0.0419	0.0379
0.0206	0.039	0.0382
0.0205	0.038	0.0382
0.0209	0.0393	0.0386
0.0205	0.0353	0.0387]
for i=1:5
    avgL(i) = mean(perf(i,:))
end

perf=[0.0186	0.0399	0.0306
0.0167	0.0312	0.0296
0.0169	0.0314	0.0403
0.0174	0.0334	0.0301
0.0175	0.0384	0.0295]

for i=1:5
    avgR(i) = mean(perf(i,:))
end

perf=[0.0304	0.0462	0.0389
0.0341	0.0453	0.0383
0.035	0.0396	0.0403
0.0299	0.0393	0.0395
0.0331	0.0401	0.0402]

for i=1:5
    avgA(i) = mean(perf(i,:))
end

plot(x,1-avgB)
hold on
plot(x,1-avgL)
plot(x,1-avgR)
plot(x,1-avgA)
legend('Bagging','Linear Regression','Random Forest','ANN')
title('Performance upon sizes of parameters for Inter Provincial Rate')
xlabel('Size')
ylabel('1-RMS')