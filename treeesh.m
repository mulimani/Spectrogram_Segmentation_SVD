function et=treeesh(se)

 sb=[];
% for i=1:(m*n)
%     abz(i)=double(dc(i));
% end
mn=length(se(:,1));
abz=se(:,1);%figure(1);plot(abz);ylabel('u_2')
    for j=1:(mn)
       
        if abz(j) < -1e-3
            sb=[sb abz(j)];
        elseif (abz(j) > 1e-3)
            sb=[sb abz(j)];
         end
            
        
    end

 sb=sb'; %figure(5);plot(sb,'r');%plot(sb,'r*','MarkerSize',10);ylabel('A')  
 cb=setdiff(abz,sb);%figure(2);plot(cb,'r*','MarkerSize',10);ylabel('B')
 negb=[];
 for i=1:length(cb)
     if cb(i) < 0
         negb=[negb cb(i)];
     end
 end
 negb=negb';%figure(3);plot(negb,'r*','MarkerSize',10);ylabel('C')
 
 e17b=[];
 for i=1:length(negb)
     if negb(i) < -1e-17
         e17b=[e17b negb(i)];
     end
 end
 
 e17b=e17b';%figure(4);plot(e17b);ylabel('D')
 
 
 temp=e17b;
 temp=abs(temp);
 %% e-04
 temp1=[];
 for i=1:length(temp)
     if temp(i) > 10^-04
         temp1=[temp1 temp(i)];
     end
 end
 temp1=floor(temp1'/1e-04);
%  temp1=unique(temp1);
%  temp1=sort(temp1,'descend');
 %%
 th=[]; flag=0;
 if temp1(1)~=9
     th=[th e17b(1)];
     flag=1;
 else
    diffb=0;
    for i=1:length(temp1)-1
        abc=temp1(i)-temp1(i+1);
        diffb(i)=abc;
        if abc > 1
            th=[th e17b(i+1)];
            flag=1;
        end
            
    end
    diffb=sum(diffb)+1;
 end
 %% First phase
 %temp2=[];
% if sum(th) ~= 0
 
     for i=5:17
         temp2=find(temp > 10^-i);
         temp3=find(temp > 10^-(i-1));
         temp4=setdiff(temp2,temp3);
          temp5=temp(temp4,:);
         temp5=floor(temp5/10^-i);
         for j=1:length(temp5)
% %              if temp(j) > 10^-i
% %                 temp2=[temp2 temp(j)];
% %              end
%              
%             
              if temp5(1) ~= 9
                  th=[th e17b(temp4(1))];
              end
             if j+1 < length(temp5)
                 abcd=temp5(j)-temp5(j+1);
             end
             if and(abcd > 1 ,j+1<=length(temp4)) 
                th=[th e17b(temp4(j+1))];
             end
% %             temp2=[];clear temp3;
         end
%          prev=temp2;
     end
 %end
 %%
  th=(th');   
  if flag==1
      et=abs(th(end));
  else
      et=abs(th(1));
  end
  display(et);
%end