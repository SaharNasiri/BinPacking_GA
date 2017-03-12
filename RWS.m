function [i] = RWS(p)
    r = rand;
    c = cumsum(p);
    RC = c./c(end);
    i = find(r<=RC, 1, 'first');
end

