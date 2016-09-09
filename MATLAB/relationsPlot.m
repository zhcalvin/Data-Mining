% read province 2012fromHenan.csv, GDP data.

% plot GDP and fromHenan Data:

% Normalization
henan = fromHenan(:,3) * (mean(fromHenan(3)) / mean(fromHenan(:,3))/3)

% Plot:
plot(GDP2010(:,1),GDP2010(:,2))
hold on
plot(GDP2010(:,1),henan)

title('Migration Rate from Henan Province and GDP per capita');

legend(['GDP per capita';'Migration Rate']);

xlabel('Province Code');


%unemployment

henan = fromHenan(:,3) * (mean(Data(:,7)) / mean(fromHenan(:,3)) / 4)

% Plot:
plot(Data(:,1),Data(:,7))
hold on
plot(GDP2010(:,1),henan)

title('Migration Rate from Henan Province and GDP per capita');

legend(['Unemployment Rate';'Migration Rate']);

xlabel('Province Code');