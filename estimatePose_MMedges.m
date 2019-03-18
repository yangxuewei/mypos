function [R,t,s] = estimatePose_MMedges(vertex,x_landmarks,landmarks)

xp = x_landmarks;%2*m
%xp(2,:) = size(im,1)+1 - x_landmarks(2,:);    %y恢复
% Make sure xp is 2 by n landmarks
if size(xp,1)>size(xp,2)
    xp = xp';
end

nverts = size(vertex,1)/3;%vertex:(3*n)*1   即nverts=n  n为点的个数
% 从模型中截取特征点部分
sortedfps = reshape(1:nverts*3,3,nverts)';  %将1到nverts*3存入矩阵sortedfps，  作为label
fps_sel = sortedfps(landmarks,1:3)';            %从sortedfps截取landmarks对应的行，每行每列中存放的是index
fps_sel = fps_sel(:);   %转为列向量
sortedfps = fps_sel;
V_landmark = double(vertex(sortedfps,:));  %按照sortedfps中存放的序号截取特征点
disp('Initialising camera parameters...')
x = reshape(V_landmark,3,size(V_landmark,1)/3);
[ R,t,s ] = EstimateSOPwithRefinement( xp,x );