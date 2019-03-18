function [R,t,s] = estimatePose_MMedges(vertex,x_landmarks,landmarks)

xp = x_landmarks;%2*m
%xp(2,:) = size(im,1)+1 - x_landmarks(2,:);    %y�ָ�
% Make sure xp is 2 by n landmarks
if size(xp,1)>size(xp,2)
    xp = xp';
end

nverts = size(vertex,1)/3;%vertex:(3*n)*1   ��nverts=n  nΪ��ĸ���
% ��ģ���н�ȡ�����㲿��
sortedfps = reshape(1:nverts*3,3,nverts)';  %��1��nverts*3�������sortedfps��  ��Ϊlabel
fps_sel = sortedfps(landmarks,1:3)';            %��sortedfps��ȡlandmarks��Ӧ���У�ÿ��ÿ���д�ŵ���index
fps_sel = fps_sel(:);   %תΪ������
sortedfps = fps_sel;
V_landmark = double(vertex(sortedfps,:));  %����sortedfps�д�ŵ���Ž�ȡ������
disp('Initialising camera parameters...')
x = reshape(V_landmark,3,size(V_landmark,1)/3);
[ R,t,s ] = EstimateSOPwithRefinement( xp,x );