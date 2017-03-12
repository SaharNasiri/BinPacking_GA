function [c1, c2] = BinaryCrossoverNPoint(objects1, objects2)
c1 = objects1;
c2 = objects2;

temp = randperm(numel(objects1));
indx1 = min(temp(1), temp(2));
indx2 = max(temp(1), temp(2));
c1 = Filling(indx1, indx2, objects2, c1);
c2 = Filling(indx1, indx2, objects1, c2);
end

function [to] = Filling(indx1, indx2, from, objects)
to = objects;
for i=indx1:indx2
    to(i).state = from(i).state;
end
end

    