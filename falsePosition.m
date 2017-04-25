function [table] = falsePosition(funcStr,xl,xu,tolerance,maxIterations)
    tStart = tic;
    xLower = xl;
    xUpper = xu;
    converter='@(x)';
    fallStr=strcat(converter,funcStr);
    func = str2func(fallStr);
    fXu = func(xUpper);
    fXl = func(xLower);
    flag = 1;
    if (fXu*fXl>0)
        table='False position can not solve this problem.';
    else
          previous=(xLower*fXu-xUpper*fXl)/(fXu-fXl); 
          iterations=1;
          timeElapsed = toc(tStart);
          matrix=[iterations,timeElapsed,xLower,xUpper,previous,fXl,fXu,func(previous),previous,1000];
    
    error=1000;
    while(abs(error)>tolerance&&iterations<maxIterations&&flag==1)
         tStart = tic;
        if (func(previous)*fXu<0)
            xLower=previous;
            fXl=func(xLower);
        else
            xUpper=previous;
            fXu=func(xUpper);
        end
        if (fXu-fXl==0)
            flag=0;
            table='False position can not solve this problem.';
        else
         xr=(xLower*fXu-xUpper*fXl)/(fXu-fXl);
         error = xr - previous;
         previous = xr;
         iterations = iterations+1;
         %number of iterations, execution time, all iterations,approximate root, and precision
         timeElapsed = toc(tStart);
         help=[iterations,timeElapsed,xLower,xUpper,previous,fXl,fXu,func(previous),previous,error];
         matrix = [matrix ; help];
        end
         
    end
    if (flag==1)
        table=matrix;
    end
    
    end
end
