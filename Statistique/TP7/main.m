clear();
clc();

%% Exercice 1

%Calculs
mu = 1;
sigma = 5;
nbTirages = 100000;

p = [2, 5, 10, 35];

p1 = randn(nbTirages, p(1)) * sigma + mu;
p2 = randn(nbTirages, p(2)) * sigma + mu;
p3 = randn(nbTirages, p(3)) * sigma + mu;
p4 = randn(nbTirages, p(4)) * sigma + mu;

%% Exercice 3
khi2Calc = zeros(4, nbTirages);

for (i = 1:nbTirages)
  khi2Calc(1, i) = khi2(p1(i,:), mu, sigma);
  khi2Calc(2, i) = khi2(p2(i,:), mu, sigma);
  khi2Calc(3, i) = khi2(p3(i,:), mu, sigma);
  khi2Calc(4, i) = khi2(p4(i,:), mu, sigma);
end

[values1, centers1] = hist(khi2Calc(1, :));
[values2, centers2] = hist(khi2Calc(2, :));
[values3, centers3] = hist(khi2Calc(3, :));
[values4, centers4] = hist(khi2Calc(4, :));

%% Exercice 4
figure(1)
subplot(2,2,1);
bar(centers1, cumsum(values1));

subplot(2,2,2);
bar(centers2, cumsum(values2));

subplot(2,2,3);
bar(centers3, cumsum(values3));

subplot(2,2,4);
bar(centers4, cumsum(values4));


figure(2)
subplot(2,2,1);
bar(centers1, chisqp(centers1, p(1) - 1));

subplot(2,2,2);
bar(centers2, chisqp(centers2, p(2) - 1));

subplot(2,2,3);
bar(centers3, chisqp(centers3, p(3) - 1));

subplot(2,2,4);
bar(centers4, chisqp(centers4, p(4) - 1));

%% Exercice 5

% Calcul
moyKhi2 = zeros(4, 1);
moyKhi2(1) = mean(khi2Calc(1,:));
moyKhi2(2) = mean(khi2Calc(2,:));
moyKhi2(3) = mean(khi2Calc(3,:));
moyKhi2(4) = mean(khi2Calc(4,:));

varKhi2 = zeros(4, 1);
varKhi2(1) = var(khi2Calc(1,:));
varKhi2(2) = var(khi2Calc(2,:));
varKhi2(3) = var(khi2Calc(3,:));
varKhi2(4) = var(khi2Calc(4,:));

NZ4 = (2*khi2Calc(4,:)).^0.5;

% Affichage
disp('Moyenne: ');
disp([moyKhi2, p', abs(moyKhi2 - p')]);
disp('Variance: ');
disp([varKhi2, 2*p', abs(varKhi2 - 2*p')]);

disp('Verification NZ4');
disp('- Moyenne : ');
disp([mean(NZ4), sqrt(2*p(4) - 1), abs(mean(NZ4) - sqrt(2*p(4) - 1))]);
disp('- Variance : ');
disp([var(NZ4), 1, abs(var(NZ4) - 1)]);

%% Exercice 6
