P3dALL=importdata('D:/du/2dsegment/personCAO/kinectCAO.xyz');
P3dALL=P3dALL';
pointSIZE=132365;%%%%ÿһ��Ҫ����һ��pointSIZE!!!!!!
P3d= reshape(P3dALL,pointSIZE*3,1);
A2d=importdata('D:/du/2dsegment/personCAO/3d2d-pairs-2d.txt');
% A3d=importdata('D:/du/3d2d-pairs-3d.txt');
B2d=A2d';

Index=importdata('D:/du/2dsegment/personCAO/3dIndex.txt');
[R,t,s]=estimatePose_MMedges( P3d,B2d,Index );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tem1=R*P3dALL;
% tem2=tem1(:,1:2);  %tem2: N*2ά��
tem2=tem1(1:2,:);  %tem2: 2*Nά��

TT=zeros(2,pointSIZE);
for iii = 1:pointSIZE
    TT(:,iii)=t;  %TT: 2*53490ά��
end 
RES0=tem2+TT;    %RES0: 2*53490ά��

MYres=s*RES0;
MYres=MYres';     %MYres: 53490*2ά��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�������ֱ��淽ʽ�����ԣ�ע�ͣ�dlmwrite����С�����nλ��
dlmwrite('D:/du/2dsegment/personCAO/project2d-KINECT.txt',MYres,'delimiter', '\t','precision','%6.5f') 
% save d:/du/project2d-person1.txt -ascii R 