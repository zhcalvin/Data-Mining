Bagging1 = [0.0172	0.032	0.0329]
Bagging2 = [0.0175	0.035	0.0285]

before = [0.0172	0.032	0.0329
0.0169	0.0305	0.0285
0.0281	0.038	0.0385
0.0204	0.0385	0.039]

after = [0.0175	0.035	0.0285
0.0149	0.0358	0.0329
0.0222	0.2758	0.0385
0.0203	0.0398	0.039]

a = ['    Bagging      ';'Random Forest    ';'Neural Networks  ';'Linear Regression']


x = [1,2,3]

for i = 1:4
    plot(x, before(i,:))
    hold on
    plot(x, after(i,:))
    legend('one for each','duel for each')
    title(a(i,:))
    hold off
end