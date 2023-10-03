function result = finalizeStress(stress,vars)
% input:
% stress:   raw stress

% output:
% saved finalized stresses, averaged across yvals

nx = 300;
% ny = 101;
% nz = 1;

y = linspace(-5,5,101);
y1 = find(y>=0); y2 = find(y<=0);
result = zeros(nx,length(y1));
posY = stress(:,y1); negY = stress(:,y2);
negY = flip(negY,2);
if vars == "uv"
    posY = stress(:,y1); negY = -1.*stress(:,y2);
    negY = flip(negY,2);
end

% raw values until x = 4
result((1:40),:) = posY(1:40,:);

% start averaging at x = 4, assume self similarity afterwards
for i = 40:nx
        for j = 1:length(y1)
            posVal = posY(i,j,:); negVal = negY(i,j,:);
            avg = mean([posVal,negVal]);
            result(i,j) = avg;
        end
end

end

