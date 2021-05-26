function hat_y=omp(s,T,N)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
Size=size(T);                                     %  观测矩阵大小
M=Size(1);                                        %  测量
hat_y=zeros(1,N);                                 %  待重构的谱域(变换域)向量                     
Aug_t=[];                                         %  增量矩阵(初始值为空矩阵)
r_n=s;                                            %  残差值

for times=1:M/4;                                  %  迭代次数(稀疏度是测量的1/4)
    for col=1:N;                                  %  恢复矩阵的所有列向量
        product(col)=abs(T(:,col)'*r_n);          %  恢复矩阵的列向量和残差的投影系数(内积值) 
    end
    [val,pos]=max(product);                       %  最大投影系数对应的位置
    Aug_t=[Aug_t,T(:,pos)];                       %  矩阵扩充
    T(:,pos)=zeros(M,1);                          %  选中的列置零（实质上应该去掉，为了简单我把它置零）
    aug_y=(Aug_t'*Aug_t)^(-1)*Aug_t'*s;           %  最小二乘,使残差最小
    r_n=s-Aug_t*aug_y;                            %  残差
    pos_array(times)=pos;                         %  纪录最大投影系数的位置
    
    if (norm(r_n)<9)                              %  残差足够小
        break;
    end
end
hat_y(pos_array)=aug_y;  

end

