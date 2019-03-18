P3dALL=importdata('F:\matlab\mypos\data\data1\PMatrix.txt');% 输入：三维模型，3448个点的XYZ坐标  n*3
P3dALL=P3dALL';%3*n
[m,n]=size(P3dALL);
P3d= reshape(P3dALL,n*3,1);%x1,y1,z1,x2,y2,z2...

A2d=importdata('F:\matlab\mypos\data\data1\A2d.txt');% 输入：二维模型对应点坐标 m*2
% A3d=importdata('D:/du/3d2d-pairs-3d.txt');
B2d=A2d';%2*m  

Index=importdata('F:\matlab\mypos\data\data1\index.txt');% 输入：三维模型对应点索引号（规则是从1开始计数）
[R,t,s]=estimatePose_MMedges( P3d,B2d,Index );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tem1=R*P3dALL;
% tem2=tem1(:,1:2);  %tem2: N*2维数
tem2=tem1(1:2,:);  %tem2: 2*N维数

TT=zeros(2,n);
for iii = 1:n
    TT(:,iii)=t;  %TT: 2*3448维数
end 
RES0=tem2+TT;    %RES0: 2*3448维数

MYres=s*RES0;
MYres=MYres';     %MYres: 3448*2维数
MYres=round(MYres);%new code 把像素坐标取整

% load 'F:\matlab\mypos\data\data1\face.mat'
face=imread('F:\matlab\mypos\data\data1\face1.png');
faceHdrColor=zeros(n,3);
for i=1:n
    faceHdrColor(i,:)=face(MYres(i,2),MYres(i,1),:);
end

%把faceHdrColor保存到txt文件中
fid=fopen('F:\matlab\mypos\result\result1\faceRGB.txt','w');
for i=1:n
    for j=1:3
        if j==3
            fprintf(fid,'%.6f\n',faceHdrColor(i,j));%如果是最后一个，就换行
        else
            fprintf(fid,'%.6f,',faceHdrColor(i,j));%如果不是最后一个，就tab
        end
    end
end
fclose(fid);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%下面两种保存方式都可以（注释：dlmwrite保存小数点后n位）
% dlmwrite('F:\matlab\mypos\data\project2d.txt',MYres,'delimiter', '\t','precision','%6.5f') 
% save d:/du/project2d-person1.txt -ascii R 