clc;
varianrt = 13;%Номер врианта
h = 0.1;
leftSide = [-0.1, 0, 0.1, 0.2, 0.3, 0.4, 0.5];
rightSide = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6];
Ii = -0.05:h:0.55;
NIi = -0.05:0.01:0.55;
mi = [5, 18, 22, 21, 15, 13, 6];%частоты
n = sum(mi);%общее количесво частот
pi = mi./n;% частота в %
figure, bar(-0.05:0.1:0.55,pi/(h), 1 , 'b');
title('Гистограмма');
axis([-0.3 0.8 0 3]);
MX = sum(pi.*Ii);
DX = sum((Ii - MX).^2.*mi./(n-1));
S = sqrt(DX);
disp('Мат. ожидание:'); disp(MX);
disp('Дисперсия:'); disp(DX);
disp('Среднеквадратическое отклонение: '); disp(S);

a = (normpdf(NIi, MX, S));
ltpi = normcdf(leftSide, MX, S);
rtpi = normcdf(rightSide, MX, S);
tpi = rtpi - ltpi;
disp('Относительные частоты:'); disp(pi.*n);
disp('Теоретические относительные частоты:'); disp(tpi.*n);

hold on;
plot(Ii, tpi);
hold on;
plot(NIi, a, 'g')
alpha = 0.05;
XI2 = sum((mi - n.*tpi).^2./(n.*tpi));
XI2k = chi2inv(1 - alpha,7-3);
disp('Статистика Хи2:');
disp(XI2);
disp('Критическая точка k2:');
disp(XI2k);
%Res = chi2gof(mi);%Check
%if Res == 0
%fprintf('H0 by chi2gof()')
%end


if XI2k > XI2
fprintf('Принимается гипотеза H0: случайная величина распределена по нормальному закону с параметрами m = %.3f и s = %.3f\n', MX, S);
else
fprintf('Принимается гипотеза H1: случайная величнараспредлена не по нормальному закону с параметрами m = %.3fи s = %.3f\n', MX, S);
end

fid = fopen('answers.txt', 'wb');     % открытие файла на запись
if fid == -1                     % проверка корректности открытия
    error('File is not opened');
end

fprintf(fid, '%.6f\t', varianrt);
fprintf(fid,'\n');
fprintf(fid, '%.6f\t', pi.*n);%Кол-во попаданий в интервал
fprintf(fid,'\n');
fprintf(fid, '%.6f\t',tpi.*n );%теоретические частоты
fprintf(fid,'\n');
fprintf(fid, '%.6f\t %.6f\t', XI2,XI2k);
%Мат ожидание;Дисперсия;Среднеквадратическое отклонение;Статистика Хи2;Критическая точка k2
fclose(fid);                % закрытие файла
