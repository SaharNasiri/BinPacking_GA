function [cost] = TotalCost(objects)
bags = [];
for i=1:numel(objects)
    bags = [bags objects(i).state];
end
bags = unique(bags);
cost = numel(bags);
end

