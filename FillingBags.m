function [outputObjects, possible, out] = FillingBags(inputObjects, inputBags)
i = 1;possible = 1;limit = 0;
for j=1:numel(inputObjects)
    if inputObjects(j).state == 0
        limit = limit + 1;
    end
end
j = 1;
counter = 1;
while i <= limit
    r = randi([1, numel(inputBags)]);
    if inputObjects(j).state ~= 0
        j = j+1;
        continue;
    elseif inputBags(r) > inputObjects(j).weight
        inputObjects(j).state = r;
        inputBags(r) = inputBags(r) - inputObjects(j).weight;
        i = i + 1;
        j = j + 1;
        
    else
        counter = counter + 1;
    end
    if counter > 200
        possible = 0;
        break;
    end
end
outputObjects = inputObjects;
out = inputBags;
end 

