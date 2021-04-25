function sound_seg=svd_segmentation(x,fs)
%% spectogram
%% 
  %[x,fs]=audioread('SVD/monoevents/plates/take102.wav');
  % x = (sum(x,2)/2);
 
 % Adding Noise
%  load factory1.mat
%  noisy1=factory1(1:length(x));
%  x=addnoise(x,noisy1,5);
 

 %%

 %x=noisy;
[B,f,t]=specgram(x,256,fs,256,128);
S=abs(B);%Linear Spectrogram
S=log(S);%Logarithmic Spectrogram
RS=imresize(S,[50 50]);%Resized spectrogram
RRS=RS;
 for ii=1:50
 RS(ii,:)=(RS(ii,:)).^2;
 end

 [rr, cc]=size(RS);  
 ind=find(RS);
 tind=length(ind);
 [II,JJ]=ind2sub([rr,cc],ind);




% vectoring the spectral components
for i=1:tind
       V1(i)=double(RS(ind(i)));
end

% normalizing to [0-1] scale
V=(V1./max(V1(:)));   

% w is the weight matrix (similarity matrix or adjacency matrix)
W=zeros(tind,tind);

ra=5;
sigI=.1;
sigX=.3;

% weight matrix computation
for i=1:tind
    x1=II(i,1);
    y1=JJ(i,1);
    
    for j=1:tind
         if (i==j)
                 W(i,j)=1;
         else
          
                 x2=II(j,1);
                 y2=JJ(j,1);

            dist_spec=((x1-x2)^2 + (y1-y2)^2);  
            if sqrt(dist_spec)>=ra
                dx=0;            
            else
                dx=exp(-((dist_spec)/(sigX^2)));
            end
  
            pdiff_spec=(V(i)-V(j))^2;
            di=exp(-((pdiff_spec)/(sigI)^2));  
            W(i,j)=di*dx;
        end
    
    end
end
% diagonal matrix
d=zeros(tind,tind);
s=sum(W,2);

% laplacian matrix from diagonal matrix
for i=1:tind
     d(i,i)=s(i);
end

A=zeros(tind,tind);
A=(d-W); % A is the laplacian matrix

%  st has the singular vectors

[st,sl,ut]=svd(full(A+A'));

% se has the smallest singular vectors
sst=st(:,2:4);
id(:,:)=sst;
id(:,4)=ind(1:length(ind));
idk=id;

%% Threshold Identification for spectrogram segmentation
et=treeesh(sst);

%%

g1=find(idk(:,1)>et);
gp1=idk(g1,:);
split1=zeros(rr,cc);
split1(gp1(:,4))=RS(gp1(:,4));



g100=find(idk(:,1)<et);
gp100=idk(g100,:);
split2=zeros(rr,cc);
split2(gp100(:,4))=RS(gp100(:,4));


g101=find(idk(:,1)<-et);
gp101=idk(g101,:);
split3=zeros(rr,cc);
split3(gp101(:,4))=RS(gp101(:,4));

%% new method
% [m,n]=size(idk(:,1));
% x=idk(:,1);
% zoom=0;
% %V=V';
% qfe=[];
% emax=zeros(m,1);
% eindex=zeros(m,1);
% for i=1:m
%     for k=-6:6
%         if((i+k)>0 && (i+k)<=m)
%             s=(x(i+k,1));
%             qfe=[qfe s];
%         end
%     end
%     zoom=zoom+1;
%     emax(zoom,1)=max(qfe);
%     eindex(zoom,1)=find(x==max(qfe));
%     qfe=[];
% end


%%

ms=idk(:,4);
cdiff=setdiff(ms,g1);
g2=setdiff(cdiff,g101);
gp2=idk(g2,:);
split4=zeros(rr,cc);
split4(gp2(:,4))=RS(gp2(:,4));





specnew=split1+split3;
specnew=sqrt(specnew);
sound_seg=zeros(50,50);
non_sound_seg=zeros(50,50);
th=size(g1);




%%
event=evenoneve(gp2,et);

if event==0
    for ik=1:50
        for jk=1:50
            if specnew(ik,jk) ~= 0
                sound_seg(ik,jk)=RRS(ik,jk);
            else sound_seg(ik,jk)=0;
            end
        end
    end
end
% elseif and(length(g1) > length(g2),length(cont) > (length(original)/1.5))
%         
%      for ik=1:50
%         for jk=1:50
%             if impnew(ik,jk) ~= 0
%                 tok(ik,jk)=newcim(ik,jk);
%             else tok(ik,jk)=0;
%             end
%         end
%      end
  

if event==1

%if th > 500
    for ik=1:50
        for jk=1:50
            if split4(ik,jk) ~= 0
                sound_seg(ik,jk)=RRS(ik,jk);
            else sound_seg(ik,jk)=0;
            end
        end
    end
end

for ik=1:50
        for jk=1:50
            if split4(ik,jk) ~= 0
                non_sound_seg(ik,jk)=RRS(ik,jk);
            else non_sound_seg(ik,jk)=0;
            end
        end
end


