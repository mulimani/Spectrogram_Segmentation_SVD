clear all
data_dir='All_files/monoevents/'; %this is where the monophonic sounds are stored
directory=dir(data_dir);
nclass=12;
failedFiles = {};

for class=1:nclass

    sub_d=dir([data_dir,directory(class+2).name]);
    nfile=length(sub_d)-2;
    
    temp=exist(['/home/manjunath/svd-features/',directory(class+2).name]);
   
    if temp==0
        mkdir(['/home/manjunath/svd-features/',directory(class+2).name])
    end
    
    for file=1:nfile
        
        [x,fs]=audioread([data_dir,directory(class+2).name,'/',sub_d(file+2).name]);
        x = (sum(x,2)/2);%stereo to mono
        try
            seg_sound=svd_segmentation(x,fs);%segmented sound event
        catch exception
            failedFiles = [failedFiles; {file}];
            continue
        end
        save(['/home/manjunath/svd-features/',directory(class+2).name,'/',num2str(file)], 'seg_sound')
        fprintf('Done %d extraction\n',file);
    end
    
end
fprintf('Done reading %d class training files\n',class);
