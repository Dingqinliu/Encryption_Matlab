function R =DMMCP(r,x0,x1,x2,x3,M,N) %���� ͼX ��ʼ���� ��Ҫ��һ��x3 ѹ����

%����������һ��logistic-tentӳ�����ɻ������� ���忴��֮ǰ���ϴ�
X1=LT(r,x0,n);
Y1=LT(r,x1,n);
Z1=LT(r,x2,n);
W1=LT(r,x3,n);

fai=floor((X1+Y1+Z1+W1)/4);
R=reshape(fai,M,N);
end
