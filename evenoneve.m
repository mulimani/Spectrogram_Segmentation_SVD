function event=evenoneve(gp2,et)
eve=[];ecount=0;ncount=0;k=et*1e-1;temp56=[];temp57=[];
for i=1:length(gp2)
    if and(i+2 < length(gp2), i-1 > 0)
        if and(and(and( gp2(i,1) >= k, gp2(i+1,1) <= -k), ~(or((gp2(i-1,1) >= k), (gp2(i-1,1) <= -k)))),~(or((gp2(i+2,1) >= k), (gp2(i+2,1) <= -k))))
            
            aa1=gp2(i,1);
            aa2=-1*gp2(i+1,1);
            temp56=[temp56;gp2(i,1);gp2(i+1,1)];
            display(i);
              display(i+1);
            if aa1 > aa2
                
                ecount=ecount+1;
            else
                ncount=ncount+1;
            end
                
        end
    end
end


for j=1:length(gp2)
    if and(j+2 < length(gp2), j-1 > 0)
        if and(and(and( gp2(j,1) <= -k, gp2(j+1,1) >= k ), ~(or((gp2(j-1,1) >= k), (gp2(j-1,1) <= -k)))),~(or((gp2(j+2,1) >= k), (gp2(j+2,1) <= -k))))
            
            bb1=-1*gp2(j,1);
            bb2=gp2(j+1,1);
            temp57=[temp57;gp2(j,1);gp2(j+1,1)];
             display(j);
             display(j+1);
            if bb1 > bb2
                ecount=ecount+1;
            else
                ncount=ncount+1;
            end
        end
    end
end

if and(ecount < ncount, or(ecount~=0,ncount~=0))
    event=1;
else
    %display('non event');
    event=0;
end

%end   
