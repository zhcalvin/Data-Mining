%Input 2011InterCombData.csv as InnerCombData

icd = InnerCombData;

icd = normc(icd);

icd = icd';

index = [];
max = 8;
[idx,C] = kmeans(icd,max);

for i = 1:max
    center(i) = 9999999;
end

for i=1:16
    if center(idx(i)) >= abs(sum(icd(i,:) - C(idx(i,:))))
        center(idx(i)) = abs(sum(icd(i,:) - C(idx(i,:))));
        index(idx(i)) = i;
    end
end
index


x=4:8

perf = [0.2869	0.2618	0.2321
0.2849	0.2578	0.2457
0.2943	0.2669	0.2601
0.2935	0.239	0.212
0.2953	0.2743	0.2536]

for i=1:5
    avgB(i) = mean(perf(i,:))
end

perf = [0.4731	0.2469	0.2327
0.4731	0.2458	0.2312
0.3855	0.2742	0.2653
0.3855	0.2742	0.2654
0.3971	0.2742	0.2668]
for i=1:5
    avgL(i) = mean(perf(i,:))
end

perf=[0.2851	0.3456	0.3028
0.2831	0.3449	0.298
0.2881	0.3492	0.3135
0.2845	0.3389	0.3107
0.2933	0.3383	0.321]

for i=1:5
    avgR(i) = mean(perf(i,:))
end

perf=[0.413	0.2631	0.2367
0.4777	0.2782	0.2476
0.3645	0.3037	0.2849
0.4092	0.2692	0.2529
0.4441	0.438	0.395]

for i=1:5
    avgA(i) = mean(perf(i,:))
end

plot(x,1-avgB)
hold on
plot(x,1-avgL)
plot(x,1-avgR)
plot(x,1-avgA)
legend('Bagging','Linear Regression','Random Forest','ANN')
title('Performance upon sizes of parameters for Inner Provincial Rate')
xlabel('Size')
ylabel('1-RMS')