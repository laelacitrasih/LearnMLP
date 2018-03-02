%membaca dataset
a = xlsread('Compound.csv');
[m n] = size(a);


%forward propagation

%target
target = zeros(m,6);
for i=1:m 
    target(i,a(i,3)) = 1;
end

%inisialisasi bobot dan bias dari hasil training

data=load('sistemterbaik2.mat')
variables=fields(data);


w1 = data.(variables{8});
w2 = data.(variables{9});
b1 = data.(variables{10});
b2 = data.(variables{11});
result = a;


     sumfunc1 = a(:,1:n-1)*w1; %perkalian input dengan bobot 1 (w1)
 
     %menambahkan bias pada output1
     for i=1:length(sumfunc1(:,1))
         sumfunc1(i,:)=sumfunc1(i,:)+b1;
     end
     
     %output 1 (A1) y = sigmf(x,[a c])
     output1 = sigmf(sumfunc1,[1 0]);
     
     sumfunc2 = sumfunc1*w2 %perkalian input dengan bobot 2 (w2)
     
     %menambahkan bias pada output 2
     for i=1:length(sumfunc2(:,1))
         sumfunc2(i,:)=sumfunc2(i,1)+b2;
     end
     
     %output2 (A2)
     output2 = sigmf(sumfunc2,[1 0]);
     
     %menghitung error setiap neuron output
     error = target - output2;
     error = error.^2;
     errorj = sum(error,2);
     mse = (sum(errorj,1))/399;
     
     
    for i=1:399
        if (output2(i,:) ~= target(i,:))
                result(i,3) = 0;
        end
    end
     
%                
%     
     [fmi fma s] = performansi(a,result);
%     
%     
% 
% %scatter plot data
 for i=1: length(result(:,1));
     if result(i,3)==0
         scatter(result(i,1),result(i,2),'x');hold on;
     elseif result(i,3)==1
         scatter(result(i,1),result(i,2),'.b');hold on;
     elseif result(i,3)==2
         scatter(result(i,1),result(i,2),'.g');hold on;
     elseif result(i,3)==3
         scatter(result(i,1),result(i,2),'.r');hold on;
     elseif result(i,3)==4
         scatter(result(i,1),result(i,2),'.c');hold on;
     elseif result(i,3)==5
         scatter(result(i,1),result(i,2),'.m');hold on;
     elseif result(i,3)==6
         scatter(result(i,1),result(i,2),'.y');hold on;
     end
 end
 
 decbound2D(result(:,1),result(:,2),result);