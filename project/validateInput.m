function out =  validateInput(f)
    try
        numbers =  randi(10,1,10);
        for i = 1:size(numbers)
             integer = subs(f,numbers(i));
        end
    catch ME
        out = 'not valid function';
        return;
    end
    out = 'valid function';
    return;
end
