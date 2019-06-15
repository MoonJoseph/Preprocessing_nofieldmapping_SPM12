paralist.ServerPath = '/brain/iCAN_admin/home/zhaomuen/Data_CBD_noFM';
paralist.PreprocessedFolder = 'smoothed_spm12';
paralist.ServerPath = '/brain/iCAN_admin/home/zhaomuen/Data_CBD_noFM';
paralist.PreprocessedFolder = 'smoothed_spm12';
paralist.ServerPath = '/brain/iCAN_admin/home/zhaomuen/Data_CBD_noFM';
paralist.PreprocessedFolder = 'smoothed_spm12';
paralist.ServerPath = '/brain/iCAN_admin/home/zhaomuen/Data_CBD_noFM';
paralist.PreprocessedFolder = 'smoothed_spm12';
paralist.ServerPath = '/brain/iCAN_admin/home/zhaomuen/Data_CBD_noFM';
paralist.PreprocessedFolder = 'smoothed_spm12';
fid = fopen('/brain/iCAN_admin/home/zhaomuen/SPM/spm_scripts/preproc_spm12/WM.txt');
paralist.ServerPath = '/brain/iCAN_admin/home/zhaomuen/Data_CBD_noFM';
paralist.PreprocessedFolder = 'smoothed_spm12';
fid = fopen('/brain/iCAN_admin/home/zhaomuen/SPM/spm_scripts/preproc_spm12/WM.txt');
ID_List = {};
Cnt_List = 1;
while ~feof(fid)
linedata = textscan(fgetl(fid), '%s', 'Delimiter', '\t');
ID_List(Cnt_List,:) = linedata{1};
Cnt_List = Cnt_List + 1;
end
fclose(fid);
paralist.SubjectList = ID_List;
paralist.SessionList = {'NB'};
paralist.ScanToScanCrit = 0.5;
paralist.ServerPath = '/brain/iCAN_admin/home/zhaomuen/Data_CBD_noFM';
paralist.PreprocessedFolder = 'smoothed_spm12';
fid = fopen('/brain/iCAN_admin/home/zhaomuen/SPM/spm_scripts/preproc_spm12/WM.txt');
ID_List = {};
Cnt_List = 1;
while ~feof(fid)
linedata = textscan(fgetl(fid), '%s', 'Delimiter', '\t');
ID_List(Cnt_List,:) = linedata{1};
Cnt_List = Cnt_List + 1;
end
fclose(fid);
paralist.SubjectList = ID_List;
paralist.SessionList = {'NB'};
paralist.ScanToScanCrit = 0.5;
paralist.ServerPath = '/brain/iCAN_admin/home/zhaomuen/Data_CBD_noFM';
paralist.PreprocessedFolder = 'smoothed_spm12';
fid = fopen('/brain/iCAN_admin/home/zhaomuen/SPM/spm_scripts/preproc_spm12/WM.txt');
ID_List = {};
Cnt_List = 1;
while ~feof(fid)
linedata = textscan(fgetl(fid), '%s', 'Delimiter', '\t');
ID_List(Cnt_List,:) = linedata{1};
Cnt_List = Cnt_List + 1;
end
fclose(fid);
paralist.SubjectList = ID_List;
paralist.SessionList = {'NB'};
paralist.ScanToScanCrit = 0.5;
paralist.ServerPath = '/brain/iCAN_admin/home/zhaomuen/Data_CBD_noFM';
paralist.PreprocessedFolder = 'smoothed_spm12';
fid = fopen('/brain/iCAN_admin/home/zhaomuen/SPM/spm_scripts/preproc_spm12/WM.txt');
ID_List = {};
Cnt_List = 1;
while ~feof(fid)
linedata = textscan(fgetl(fid), '%s', 'Delimiter', '\t');
ID_List(Cnt_List,:) = linedata{1};
Cnt_List = Cnt_List + 1;
end
fclose(fid);
paralist.SubjectList = ID_List;
paralist.SessionList = {'NB'};
paralist.ScanToScanCrit = 0.5;
paralist.ServerPath = '/brain/iCAN_admin/home/zhaomuen/Data_CBD_noFM';
paralist.PreprocessedFolder = 'smoothed_spm12';
fid = fopen('/brain/iCAN_admin/home/zhaomuen/SPM/spm_scripts/preproc_spm12/WM.txt');
ID_List = {};
Cnt_List = 1;
while ~feof(fid)
linedata = textscan(fgetl(fid), '%s', 'Delimiter', '\t');
ID_List(Cnt_List,:) = linedata{1};
Cnt_List = Cnt_List + 1;
end
fclose(fid);
paralist.SubjectList = ID_List;
paralist.SessionList = {'NB'};
paralist.ScanToScanCrit = 0.5;
