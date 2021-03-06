function [flag,table] = newton2(fn, dfn, intialGuess, tolerance, iterations)
    fnc = inline(fn);
    dfnc = inline(dfn);
    iteration = 1;
    firstTime = tic;
    x(iteration) = intialGuess;
    f(iteration) = fnc(x(iteration));
    er(iteration) = 0;
    dfdx(iteration) = dfnc(x(iteration));
    table(iteration, 1) = iteration;
    table(iteration, 3) = x(iteration);
    table(iteration, 4) = f(iteration);
    table(iteration, 5) = dfdx(iteration);
    table(iteration, 2) = toc(firstTime);
    iteration = iteration + 1;
    flag = true;
    for i = 2 : iterations + 1
        firstTime = tic;
        x(i) = x(i - 1) - (f(i - 1) / dfdx(i - 1));
        f(i) = fnc(x(i));
        dfdx(i) = dfnc(x(i));
        er(i) = abs(x(i) - x(i - 1));
        table(i, 1) = i;
        table(i, 2) = toc(firstTime);
        table(i, 3) = x(iteration);
        if(isnan(table(i, 3)))
            flag = false;
            break;
        end
        table(i, 4) = f(iteration);
        table(i, 5) = dfdx(iteration);
        table(i, 6) = er(iteration);
        if er(i) < tolerance
           disp('Finished');
           break;
        end
        iteration = iteration + 1;
        if iteration > 50
           flag = false;
           break;
        end
    end
    iteration = iteration - 1;
    tem = sym(dfn);
    ddfn = diff(tem);
    ddfn = char(ddfn);
    ddfdx = inline(ddfn);
    erroFnc = abs(ddfdx(x(iteration))/(2*dfdx(iteration)));
    for i = 1 : iteration
        table(i, 7) = x(iteration) - x(i);
        table(i, 8) = abs((table(i,7))^2 * erroFnc);
    end
    %'step', 'execution time', 'x','f','df/dx', 'Absolute error', 'Sigma', 'Theoritical Error'
    fileName = strcat(pwd,'\outputNewton.txt');
    fileID = fopen(fileName,'wt');
    fprintf(fileID,'%6 %12s %12s %12s %12s %12s %12s %12s %12s\r\n','step', 'execution time', 'x','f','df/dx','Absolute error', 'Sigma', 'Theoritical Error', 'Approximate Error');
       for i = 1:size(table)
          fprintf(fileID,'%6f %16f %38f %12f %12f %12f %12f %12f %12f\r\n',table(i,:));
       end
    fclose(fileID);
    %disp('  step                    x                       f                    df/dx            Sigma        SigmaABS');
    %out = [k; x; f; dfdx; er*100];
    %fprintf('%5.0f      %20.14f     %21.15f     %21.15f     %20.14f \n',out);
    