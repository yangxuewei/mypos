P3dALL=importdata('F:\matlab\mypos\data\data1\PMatrix.txt');% ���룺��άģ�ͣ�3448�����XYZ����  n*3
P3dALL=P3dALL';%3*n
[m,n]=size(P3dALL);
P3d= reshape(P3dALL,n*3,1);%x1,y1,z1,x2,y2,z2...

A2d=importdata('F:\matlab\mypos\data\data1\A2d.txt');% ���룺��άģ�Ͷ�Ӧ������ m*2
% A3d=importdata('D:/du/3d2d-pairs-3d.txt');
B2d=A2d';%2*m  

Index=importdata('F:\matlab\mypos\data\data1\index.txt');% ���룺��άģ�Ͷ�Ӧ�������ţ������Ǵ�1��ʼ������
[R,t,s]=estimatePose_MMedges( P3d,B2d,Index );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tem1=R*P3dALL;
% tem2=tem1(:,1:2);  %tem2: N*2ά��
tem2=tem1(1:2,:);  %tem2: 2*Nά��

TT=zeros(2,n);
for iii = 1:n
    TT(:,iii)=t;  %TT: 2*3448ά��
end 
RES0=tem2+TT;    %RES0: 2*3448ά��

MYres=s*RES0;
MYres=MYres';     %MYres: 3448*2ά��
MYres=round(MYres);%new code ����������ȡ��

% load 'F:\matlab\mypos\data\data1\face.mat'
face=imread('F:\matlab\mypos\data\data1\face1.png');
faceHdrColor=zeros(n,3);
for i=1:n
    faceHdrColor(i,:)=face(MYres(i,2),MYres(i,1),:);
end

%��faceHdrColor���浽txt�ļ���
fid=fopen('F:\matlab\mypos\result\result1\faceRGB.txt','w');
for i=1:n
    for j=1:3
        if j==3
            fprintf(fid,'%.6f\n',faceHdrColor(i,j));%��������һ�����ͻ���
        else
            fprintf(fid,'%.6f,',faceHdrColor(i,j));%����������һ������tab
        end
    end
end
fclose(fid);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�������ֱ��淽ʽ�����ԣ�ע�ͣ�dlmwrite����С�����nλ��
% dlmwrite('F:\matlab\mypos\data\project2d.txt',MYres,'delimiter', '\t','precision','%6.5f') 
% save d:/du/project2d-person1.txt -ascii R 