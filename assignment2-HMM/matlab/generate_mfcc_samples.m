function generate_mfcc_samples(indir,in_filter,outdir,out_ext,outfile_format,frame_size_sec,frame_shift_sec,use_hamming,pre_emp,bank_no,cep_order,lifter,delta_win_weight)

if nargin==0 % the default value of the parameters
    indir='wav';
    in_filter='\.[Ww][Aa][Vv]';
    outdir='mfcc';
    out_ext='.mfc';
    outfile_format='htk';% htk format
    frame_size_sec = 0.025;
    frame_shift_sec= 0.010;
    use_hamming=1;
    pre_emp=0;
    bank_no=26;
    cep_order=12;
    lifter=22;
    delta_win=2;
    delta_win_weight = ones(1,2*delta_win+1);
end

if exist(outdir) ~=7
    mkdir(outdir);
end

filelist=dir(indir);
filelist_len=length(filelist);

% filelist(1)='.'        % filelist(2)='..'  should be excluded
for k=3:filelist_len
    [pathstr,filenamek,ext] = fileparts(filelist(k).name);
    if filelist(k).isdir
        generate_mfcc_samples([indir filesep filenamek],in_filter,[outdir filesep filenamek],out_ext,outfile_format,frame_size_sec,frame_shift_sec,use_hamming,pre_emp,bank_no,cep_order,lifter,delta_win_weight);
    else
        if regexp(filelist(k).name,in_filter)
            infilename=fullfile(indir, filelist(k).name);
            outfilename=[outdir filesep filenamek out_ext];
            fwav2mfcc(infilename,outfilename,outfile_format,frame_size_sec,frame_shift_sec,use_hamming,pre_emp,bank_no,cep_order,lifter,delta_win_weight);
        end
    end
end

end