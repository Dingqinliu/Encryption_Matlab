function hat_y=omp(s,T,N)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
Size=size(T);                                     %  �۲�����С
M=Size(1);                                        %  ����
hat_y=zeros(1,N);                                 %  ���ع�������(�任��)����                     
Aug_t=[];                                         %  ��������(��ʼֵΪ�վ���)
r_n=s;                                            %  �в�ֵ

for times=1:M/4;                                  %  ��������(ϡ����ǲ�����1/4)
    for col=1:N;                                  %  �ָ����������������
        product(col)=abs(T(:,col)'*r_n);          %  �ָ�������������Ͳв��ͶӰϵ��(�ڻ�ֵ) 
    end
    [val,pos]=max(product);                       %  ���ͶӰϵ����Ӧ��λ��
    Aug_t=[Aug_t,T(:,pos)];                       %  ��������
    T(:,pos)=zeros(M,1);                          %  ѡ�е������㣨ʵ����Ӧ��ȥ����Ϊ�˼��Ұ������㣩
    aug_y=(Aug_t'*Aug_t)^(-1)*Aug_t'*s;           %  ��С����,ʹ�в���С
    r_n=s-Aug_t*aug_y;                            %  �в�
    pos_array(times)=pos;                         %  ��¼���ͶӰϵ����λ��
    
    if (norm(r_n)<9)                              %  �в��㹻С
        break;
    end
end
hat_y(pos_array)=aug_y;  

end

