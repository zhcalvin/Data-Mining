clear all
exp1 = [1.1,2.5,2.45,1.8,2.3,4.8,1.9,1.2,0.7,4.9]
exp2 = [1.9,3.8,2.4,4.8,3.7,0.8,1.1,0.6,0.7,0.4]
plot(exp1,exp2,'o')
xlabel('Exp.1')
ylabel('Exp.2')
exp = zeros(10,10)
for i = 1:10
    for j = 1:10
        exp(i, j) = ( (exp1(i) - exp1(j))^2 + (exp2(i) - exp2(j))^2)^(1/2)
    end
end

round1 = zeros(3,10)
for i = 1:3
    for j = 1:10
        round1(i,j) = ( (exp1(i) - exp1(j))^2 + (exp2(i) - exp2(j))^2)^(1/2)
    end
end

% Clustering:

cluster = zeros(1,10)
for i = 1:10
    [x,cluster(i)] = min(round1(:,i))
end

totalDis = zeros(1,10)

for i = 1:10
    for j = 1:10
        if cluster(i) ~= cluster(j)
            continue
        else
            totalDis(i) = totalDis(i) + ( (exp1(i) - exp1(j))^2 + (exp2(i) - exp2(j))^2)^(1/2)
        end
    end
end
[1:10;cluster;totalDis]
    
center = [8,5,6]
exp = zeros(10,10)
for i = 1:10
    for j = 1:10
        exp(i, j) = ( (exp1(i) - exp1(j))^2 + (exp2(i) - exp2(j))^2)^(1/2)
    end
end

round2 = zeros(3,10)
for i = 1:3
    for j = 1:10
        if i == 1
            index = 8
        elseif i == 2
            index = 5
        else
            index = 6
        end
        round2(i,j) = ( (exp1(index) - exp1(j))^2 + (exp2(index) - exp2(j))^2)^(1/2)
    end
end

% Clustering:

cluster = zeros(1,10)
for i = 1:10
    [x,cluster(i)] = min(round2(:,i))
end

[1:10; cluster]

totalDis = zeros(1,10)

for i = 1:10
    for j = 1:10
        if cluster(i) ~= cluster(j)
            continue
        else
            totalDis(i) = totalDis(i) + ( (exp1(i) - exp1(j))^2 + (exp2(i) - exp2(j))^2)^(1/2)
        end
    end
end
[1:10;cluster;totalDis]