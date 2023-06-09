clc;
% 3. Guarde el archivo en su espacio de trabajo de MATLAB y léalo usando el comando readmatrix.Alumnos 
Alumnos = readmatrix("Inteligencia Artificial/Alumnos.xlsx");
% 4. Extraiga la columna correspondiente a la variable "Estatura” y guárdela en una variable “x4”.
x4 = Alumnos(:,3);
% 5. Calcule la media de la variable “Estatura”. Haga el cálculo en MATLAB:
% a. Usando la función que viene incorporada para este cálculo (mean).
media = mean(x4);
% b. Sin usar dicha función
media2 = sum(x4)/length(x4);
% 6. Calcule la varianza de la variable "Estatura". Haga el cálculo en MATLAB:
% a. Usando la función que viene incorporada para este cálculo (var). Por default, esta
%función normaliza con N-1. Para normalizar con N, use el argumento "w” = 1.
varianza = var(x4);
% b. Sin usar dicha función. Calcule tanto la varianza normalizada con N-1, como la
% normalizada con N.
varianza2 = sum(x4-media)^2/length(x4);

% 7. Calcule la desviación estándar de la variable "Estatura". Haga el cálculo en MATLAB:
% a. Usando la función que viene incorporada para este cálculo (std). Por default, esta
% función normaliza con N-1. Use solo esta configuración por default.
desviacion = std(varianza);
% b. Sin usar dicha función.
desviacion2 = sqrt(varianza);

% 8. Calcule la media de la variable "Peso" para las mujeres.
mediaM = Alumnos(17,4)/length(Alumnos(17,4)) ;

% 9. Cree una nueva variable "Estaturas_ord", con las estaturas en orden ascendente
estatura_ord = sort(x4);

% 10.Cree una nueva variable de nombre "F" y llénela con los valores de la frecuencia acumulativa.

F = 0:1/((length(x4))-1):1

% 11.Haga un gráfico de F vs Estaturas_ord usando el comando plot. Use la opción  b--o' como tercer argumento.
plot(estatura_ord,F,'b--o');

% 12. Haga el cálculo de Q1, Q2 y Q3, usando la función quantile.
Q = quantile(x4,[0.25 0.5 0.75]);


% Importar statesx77

states = readmatrix("Inteligencia Artificial/statesx77.csv");
% 13. Calcule el coeficiente de correlación de Pearson (r) entre las variables "Illiteracy" y "Murder", para dicho dataset.
illiteracy = states(:,4);
murder = states(:,6);

% Calculo de Pearson
pearson = corrcoef(illiteracy,murder);

% 14.Haga un gráfico de Illiteracy vs Murder usando scatter. (vea la sección Respuestas).
scatter(murder,illiteracy);

xlabel('Homicidios [por c/100000 habitantes]')
ylabel('Analfabetismo [porcentaje]')

% 15.Normalice las variables "Income" y "Life Exp” (en la sección Respuestas se presenta una muestra de valores, para que usted pueda corroborar su resultado). 
income = states(:,3);
lifeExp = states(:,5);
income_norm = (income - mean(income)) / (max(income)-min(income));
lifeExp_norm = (lifeExp - mean(lifeExp)) / (max(lifeExp)-min(lifeExp));

% 16. Estandarice las variables "Income" y "Life Exp" (en la sección Respuestas se presenta una muestra de valores, para que usted pueda corroborar su resultado).
income_std = (income - mean(income)) / std(income);
lifeExp_std = (lifeExp - mean(lifeExp)) / std(lifeExp);
% PREGUNTA 17. División estados
area = states(:,9);
grande = area >= 69000;
mediana1 = area < 69000;
mediana2 = area >= 41900;
mediana = mediana1.* mediana2;
pequenia = area < 41900;
states(:,10) = pequenia;
states(:,11) = mediana;
states(:,12) = grande;
% Calcule el promedio de la expectativa de vida tanto para los estados de la categoría
% "Pequeño" como para aquellos de la categoría “Grande”. Es decir, calcule la media de los
% valores que se encuentran en la columna "Life_Exp" para estos estados.
lifeExp_pequenio = mean(lifeExp(pequenia));
lifeExp_grande = mean(lifeExp(grande));



