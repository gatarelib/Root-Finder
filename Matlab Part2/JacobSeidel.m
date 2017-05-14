function [table] = JacobSeidel(A, b, x0, iterations, error)
time = tic;
num_of_variables = size(A,2);
for j = 1 : num_of_variables
    res = 0;
    for k = 1 : num_of_variables
        if(k > j)
            res = res + A(j, k) * x0(k);
        elseif(k < j)
            res = res + A(j, k) * x(1,k);
        end
    end
    %error 
    size(x(1,j))
    size((b(j)-res)/A(j,j))
    
    x(1,j) = (b(j) - res)/A(j,j);
    er(1,j) = 0;
end
table(1, 1) = 1;
for j = 1 : num_of_variables
    table(1,j + 1) = x0(j);
end
for j = 1 : num_of_variables
    table(1,j + num_of_variables + 1) = x(1,j);
end
for j = 1 : num_of_variables
    table(1,j + 2*num_of_variables + 1) = er(1,j);
end
table(1, 3*num_of_variables + 2) = toc(time);
for i = 2 : iterations
    time = tic;
    for j = 1 : num_of_variables
    res = 0;
    for k = 1 : num_of_variables
        if(k > j)
            res = res + A(j, k) * x(i-1,k);
        elseif(k < j)
            res = res + A(j, k) * x(i,k);
        end
    end
    x(i,j) = (b(j) - res)/A(j,j);
    er(i,j) = abs(x(i,j) - x(i - 1,j));
    end
    table(i, 1) = i;
    for j = 1 : num_of_variables
    table(i,j + 1) = x(i-1, j);
    end
    for j = 1 : num_of_variables
        table(i,j + num_of_variables + 1) = x(i,j);
    end
    for j = 1 : num_of_variables
        table(i,j + 2*num_of_variables + 1) = er(i,j);
    end
    table(i, 3*num_of_variables + 2) = toc(time);
    flag = true;
    for j = 1 : num_of_variables
        if(er(i,j) > error)
            flag = false;
            break
        end
    end
    if (flag)
       disp('Finished');
       break;
    end
end