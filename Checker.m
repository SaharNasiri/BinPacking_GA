function [ result ] = Checker(c1, bag_size, bag_num)

bag = zeros(1, bag_num);
result = 0;
for i=1:numel(c1)
    if c1(i).state == 0 
        continue;
    end
    bag(c1(i).state) =  bag(c1(i).state) + c1(i).weight;
    if bag(c1(i).state) > bag_size
        result = 1;
        break;
    end
end

end

