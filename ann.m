%membaca dataset
a = xlsread('Compound.csv');
[m n] = size(a);

%scatter plot data
for i=1: length(a(:,1));
    if a(i,3)==1
        scatter(a(i,1),a(i,2),'.b');hold on;
    elseif a(i,3)==2
        scatter(a(i,1),a(i,2),'.g');hold on;
    elseif a(i,3)==3
        scatter(a(i,1),a(i,2),'.r');hold on;
    elseif a(i,3)==4
        scatter(a(i,1),a(i,2),'.c');hold on;
    elseif a(i,3)==5
        scatter(a(i,1),a(i,2),'.m');hold on;
    elseif a(i,3)==6
        scatter(a(i,1),a(i,2),'.y');hold on;
    end
end



%forward propagation

%target
target = zeros(m,6);
for i=1:m 
    target(i,a(i,3)) = 1;
end

%inisialisasi bobot dan bias dengan nilai random
w1 = randn(n-1,6);
w2 = randn(6,6);
b1 = randn(1,6);
b2 = randn(1,6);
dw1 = zeros(n-1,6);
dw2 = zeros(6,6);
db1 = zeros(1,6);
db2 = zeros(1,6);
mse = 10;
result = a;
akurasi = zeros(100,1);

for j=1:1000
    %update bobot
    w1 = w1 +dw1;
    w2 = w2+dw2;
    b1 = b1+db1;
    b2 = b2+db2;
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
    
    [ dw1 dw2 db1 db2 ] = backpro(a,output1,output2,w2,error);
    
    [val idx] = max(a,[],2);
    
    
    for i=1:399
        if (output2(i,:) ~= target(i,:))
                result(i,3) = 0;
        end
    end
    
               
    
    [fmi fma s] = performansi(a,result);
    akurasi(j,1) = s;
    
end

% %scatter plot data
% for i=1: length(result(:,1));
%     if result(i,3)==1
%         scatter(result(i,1),result(i,2),'.b');hold on;
%     elseif result(i,3)==2
%         scatter(result(i,1),result(i,2),'.g');hold on;
%     elseif result(i,3)==3
%         scatter(result(i,1),result(i,2),'.r');hold on;
%     elseif result(i,3)==4
%         scatter(result(i,1),result(i,2),'.c');hold on;
%     elseif result(i,3)==5
%         scatter(result(i,1),result(i,2),'.m');hold on;
%     elseif result(i,3)==6
%         scatter(result(i,1),result(i,2),'.y');hold on;
%     end
% end
