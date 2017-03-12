function [objects2] = Mutation(objects1, mu, Bags)
r = rand();
objects2 = objects1;

if r < mu
   
    r = rand();
    
    bags = [];
    for i=1:numel(objects2)
        bags = [bags objects2(i).state];
    end
    bags = unique(bags);
    bags = bags(2:end);
    
    if r > 0.8
        
        emp_bags = [];
        for i=1:numel(Bags)
            if isempty(find(bags ==  i))
                emp_bags = [emp_bags i];
            end
        end
        rBags = randi([emp_bags(1) emp_bags(end)]);
        for i=1:50
            rM = randi([1, numel(objects2)]);
            objects2(rM).state = rBags;
        end
        
        if Checker(objects2, Bags(1), numel(Bags))
            objects2 = objects1;
        end
        
    else
        
        rBag = randi([1, numel(Bags)]);
        
        for i=1:numel(objects2)
            if objects2(i).state == rBag;
                objects2(i).state = 0;
            end
        end
        
        Bags(rBag) = 0;
        for i=1:numel(objects2)
            if objects2(i).state ~= 0
                Bags(objects2(i).state) =  Bags(objects2(i).state) - objects2(i).weight;
            end
        end
        
        for i=1 : numel(Bags)
            if isempty(find(bags==i))
                Bags(i) = 0;
            end
        end
        
        [objects2, possible, b] = FillingBags(objects2, Bags);
        if ~possible
            objects2 = objects1;
        end
    end
end
end



