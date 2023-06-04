dataPol = readmatrix("iA/datasetPolítica.xlsx"); % Lectura del dataset
x = dataPol(:,1:47);
y1 = dataPol(:,48);% IZQUIERDISTA
y2 = dataPol(:,49);% CORREISTA
        
X_train = x(1:91,:);
y1_train = y1(1:91,:); %DATASET TRAINING IZQUIERDISTA
y2_train = y2(1:91,:); %DATASET TRAINING CORREISMO

X_test = x(92:107,:);
y1_test = y1(92:107,:);%DATASET PRUEBA IZQUIERDISTA
y2_test = y2(92:107,:);%DATASET PRUEBA CORREISMO



% 1.Probabilidad marginal de que una persona vote por Correa.
n_training = length(y2_train); %Numero de datos en los vectores training
total_correistas = sum(y2_train); %Total de correistas
PvCorrea = total_correistas/n_training; % P(C=1) 

% 2.Probabilidad de que una persona izquierdista vote por Correa.
I = 0;
for i=1:n_training
    if y2_train(i)==1 %Valida si es correista
        if y1_train(i) == 1 %Valida si es de izquierda
          I = I + 1;
        end
    end
end
total_izquierda = sum(y1_train); %Total de izquierdistas
PIzqCorrea = I / total_izquierda; % P(C=1∣I=1)

% 3.Probabilidad de que una persona derechista vote por Correa.
D = 0;
for i=1:n_training
    if y2_train(i)==1 %Valida si es correista
        if y1_train(i) == 0 %Valida si es de derecha
          D = D + 1;
        end
    end
end
total_derecha = n_training-total_izquierda; % Total de derechistas
PDerCorrea = D / (total_derecha); % P(C=1∣I=0) 

% 4. Probabilidad marginal de que una persona sea de izquierda.

Izquierdista = total_izquierda/n_training; %P(I=1) 

% 5.Probabilidad marginal de que una encuesta escogida al azar pertenezca a un hombre.
genero = x(:,5); %Vector del genero
genero_train = genero(1:91,:); %Datos para training
genero_test = genero(92:107,:); %Datos para test
total_mujeres = sum(genero_train); %Numero total de mujeres
total_hombres= n_training - total_mujeres; %Numero total de hombres
PHombre = (total_hombres)/n_training; % P(M=0)
% 6.Probabilidad de que una mujer sea correísta.
M = 0;
for i=1:n_training
    if genero_train(i)==1 %Valida si es mujer
        if y2_train(i) == 1 %Valida si es correista
          M = M + 1;
        end
    end
end
PMcorreista = M / total_mujeres; %P(C=1∣M=1)

% 7. Probabilidad de que un hombre sea correísta.
H = 0;
for i=1:n_training
    if genero_train(i)==0 %Valida si es hombre
        if y2_train(i) == 1 %Valida si es correista
          H = H + 1;
        end
    end
end
PHcorreista = H/(total_hombres); %P(C=1∣M=0)

% Naive Bayes.
% Crear un vector para almacenar los resultados de los posteriors
posteriors = zeros(size(X_test)); % 1.) CREAR UNA MATRIZ PARA ALMACERNAR LOS VALORES DE LOS POSTERIORS
for i = 1:size(X_test)
    % 2.)Extraer el vector de características de X_test 
    x_new = X_test(i, :);
    % Calcular la likelihood P(xnew|C=1) usando la asunción ingenua de NaiveBayes
    i1 = y2_train == 1;
    x1 = x(i1, :);
    P_Y1 = sum(x1) / size(x1, 1);
    p1 = size(x1, 1) / size(y2_train, 1);
    Pxnew1 = 1;
    for j = 1:length(x_new)
        if x_new(j) == 1
            Pxnew1 = Pxnew1 * P_Y1(j);
        else
            Pxnew1 = Pxnew1 * (1 - P_Y1(j));
        end
    end

    % Calcular la likelihood P(xnew|C=0) usando la asunción ingenua de NaiveBayes
    i2 = y2_train == 0;
    x2 = x(i2, :);
    P_Y2 = sum(x2) / size(x2, 1);
    p2 = size(x2, 1) / size(y2_train, 1);
    Pxnew2 = 1;
    for j = 1:length(x_new)
        if x_new(j) == 1
            Pxnew2 = Pxnew2 * P_Y2(j);
        else
            Pxnew2 = Pxnew2 * (1 - P_Y2(j));
        end
    end

    % Calcular la evidence P(xnew)
    evidence = Pxnew2 * p2 + Pxnew1 * p1;

    % Calcular el posterior probability
    posterior = Pxnew1 * p1 / evidence;

    % Almacenar el resultado en el vector de posteriors
    posteriors(i) = posterior;
    % Calcular yhat basado en el posterior
    if posterior >= 0.5
        yhat(i) = 1;
    else
        yhat(i) = 0;
    end
% Mostrar los resultados
fprintf('%2d  %10.4f  %10d  %10d\n', i, posterior, yhat(i), y2_test(i));
end
