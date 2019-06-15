% Adapted by Bingsen @2018-06-04  @2018-6-15
% Adapted by Zhaomuen for is data @2019/5/24
% ls    /brain/iCAN/home/xiongbingsen/MDD/Data/2018/*MDD/fmri/
% ls -1 /brain/iCAN/home/xiongbingsen/MDD/Data/2018/*MDD/fmri/*/fieldmap
% ls -1 /brain/iCAN/home/xiongbingsen/MDD/Data/2018/*MDD/fmri/*/unnormalized
% ls -1 /brain/iCAN/home/xiongbingsen/MDD/Data/2018/*MDD/mri/FM_CBD1
% ls -1 /brain/iCAN/home/xiongbingsen/MDD/Data/2018/*MDD/mri/FM_CBD2
% ls -1 /brain/iCAN/home/xiongbingsen/MDD/Data/2018/*MDD/mri/anatomy

% written by hao (2017/06/14)
% rock3.hao@gmail.com
% qinlab.BNU

clear all;
restoredefaultpath;

%% ------------------------------ Setting Up ------------------------------- %%
% Function Switch
session_name = 2; %1=CBD1,2=CBD2,3=MRA
data_convert=  0;   % [1]-> Log YLM.txt & Check M.txt & Delete .nii -> [0][0]
data_arrange = 1;   % [1][1][1]
data_numbers = 7;   % [6][6][7]

% Basic Configure
scripts_dir = '.../preproc_spm12';
newdata_dir = '.../Data_CBD_noFM';
database    = '.../WM.xlsx';
[~,newsub_id,~] = xlsread(database,'WM','H:H');

proj_name = 'MDD';
if session_name == 1   % CBD1{RS1/EM/NB/ANT1/ANT2/BART}
    rawdata_dir     = '.../CBD1';
    [~,rawsub_id,~] = xlsread(database,'WM','H:H');
    fmri_name       = {'RS1' };   
    fmri_keyword    = {'rest'};
    fmri_voldelete  = {'5'   };
    fmri_volremain  = {'235' };
    fmap_name       = {'FM_CBD1'     };
    fmap_keyword    = {'fieldmapping'};
elseif session_name == 2   % CBD2{RS2/ER1/ER2} %no this session!!!!!!!
    rawdata_dir     = '.../CBD2';
    [~,rawsub_id,~] = xlsread(database,'WM','H:H');
    fmri_name       = {'RS2'   };
    fmri_keyword    = {'rest'  };
    fmri_voldelete  = {'5'     };
    fmri_volremain  = {'235'   };
    mri_name        = {'anatomy'};
    mri_keyword     = {'co*t1'  };
    fmap_name       = {'FM_CBD2'     };
    fmap_keyword    = {'fieldmappings'};   % fieldmapping for DTI
elseif session_name == 3   % MRA{MRA_RS1/MRA_React/MRA_RS2} %no this session!!!!!!!
    rawdata_dir     = '.../MDD_MRA';
    [~,rawsub_id,~] = xlsread(database,'WM','E:E');
    fmri_name       = {'MRA_RS1';'MRA_React';'MRA_RS2'};
    fmri_keyword    = {};
    fmri_voldelete  = {};
    fmri_volremain  = {};
    fmap_name       = {'FM_MRA'      };
    fmap_keyword    = {'fieldmapping'};
end

%% ----------------------------------------------------------- Data Convert
if data_convert == 1
    for i =4:length(rawsub_id)
        a = [rawsub_id{i,1},'*'];
        rawsub_dir0 = fullfile(rawdata_dir,   a);
        tmpsub_dir = fullfile(rawdata_dir,'/Temp/',rawsub_id);
        if exist(tmpsub_dir{i},'dir') == 7   % 
            unix(['rm -r ',tmpsub_dir{i}]);
        end
        mkdir(tmpsub_dir{i});
        unix(sprintf(['dcm2nii -g n -x y -o ',tmpsub_dir{i},' ',rawsub_dir0]));   % 
    end
end

%% ----------------------------------------------------------- Data Arrange
if data_arrange == 1


    for i = 1:length(newsub_id)
       %year_id    = ['20',newsub_id{i,1}(1:2)];
        tmpsub_dir = fullfile(rawdata_dir,'/Temp/',rawsub_id{i,1});
        
        % Arrange fmap
        for j = 1:length(fmap_name)   % 1by1
            tmpfmap_dirf = dir([tmpsub_dir,'/*',fmap_keyword{j,1},'*']);
            fmap_dir     = fullfile(newdata_dir,newsub_id{i,1},'/mri/',fmap_name{j,1});
            if length(tmpfmap_dirf) == 3
                if exist(fmap_dir,'dir') == 7   % 
                    unix(['rm -r ',fmap_dir]);
                end
                mkdir(fmap_dir);
                % Rename
                cd(tmpsub_dir)% changed!!
                orgfmap_name = {tmpfmap_dirf.name};
                unix(['mv ',orgfmap_name{1,1},' fmap_mag_shortTE.nii']);
                unix(['mv ',orgfmap_name{1,2},' fmap_mag_longTE.nii']);
                unix(['mv ',orgfmap_name{1,3},' fmap_phase.nii']);
                % Move
                unix(['mv ',tmpsub_dir,'/fmap*.nii',' ',fmap_dir]);
                unix(['echo ',newsub_id{i,1},' >> ',scripts_dir,'/',proj_name,'_Sublist_Y_',fmap_name{j,1},'.txt']);
            elseif length(tmpfmap_dirf) < 3
                unix(['echo ',newsub_id{i,1},' >> ',scripts_dir,'/',proj_name,'_Sublist_L_',fmap_name{j,1},'.txt']);
            elseif length(tmpfmap_dirf) > 3
                unix(['echo ',newsub_id{i,1},' >> ',scripts_dir,'/',proj_name,'_Sublist_M_',fmap_name{j,1},'.txt']);
            end
        end
        
        % Arrange fmri              
        for j = 1:length(fmri_name)
            tmpfmri_dirf = dir([tmpsub_dir,'/*',fmri_keyword{j,1},'*']); 
            fmriun_dir   = fullfile(newdata_dir,newsub_id{i,1},'fmri',fmri_name{j,1},'unnormalized');
            fmrifm_dir   = fullfile(newdata_dir,newsub_id{i,1},'fmri',fmri_name{j,1},'fieldmap');
            if length(tmpfmri_dirf) == data_numbers   % HLG  6 or 7
                if exist(fmriun_dir,'dir') == 7   % 
                    unix(['rm -r ',fmriun_dir]);
                end
                mkdir(fmriun_dir);
                if exist(fmrifm_dir,'dir') == 7   % 
                    unix(['rm -r ',fmrifm_dir]);
                end
                mkdir(fmrifm_dir);
                % Move
                unix(['mv ',[tmpsub_dir,'/',tmpfmri_dirf(1,1).name],' ',fmriun_dir,'/I.nii']);
                unix(['mv ',[fmriun_dir,'/I.nii'],' ',fmriun_dir,'/I_all.nii']);
                unix(['fslroi ',fmriun_dir,'/I_all.nii ',fmriun_dir,'/I.nii ',fmri_voldelete{j,1},' ',fmri_volremain{j,1}]);
                unix(['gunzip ',fmriun_dir,'/I.nii.gz']);
                unix(['echo ',newsub_id{i,1},' >> ',scripts_dir,'/',proj_name,'_Sublist_Y_',fmri_name{j,1},'.txt']);
                unix(['cp ',fmap_dir,'/fmap*.nii',' ',fmrifm_dir]);         
            elseif length(tmpfmri_dirf) < data_numbers
                unix(['echo ',newsub_id{i,1},' >> ',scripts_dir,'/',proj_name,'_Sublist_L_',fmri_name{j,1},'.txt']);
            elseif length(tmpfmri_dirf) > data_numbers
                unix(['echo ',newsub_id{i,1},' >> ',scripts_dir,'/',proj_name,'_Sublist_M_',fmri_name{j,1},'.txt']);
            end                                            
        end
                        
        % Arrange mri
        if session_name == 2   % 
            for j = 1:length(mri_name)
                tmpmri_dirf = dir([tmpsub_dir,'/*',mri_keyword{j,1},'*']);
                mri_dir     = fullfile(newdata_dir,newsub_id{i,1},'mri',mri_name{j,1});
                if length(tmpmri_dirf) == 1
                    if exist(mri_dir,'dir') == 7   % 
                        unix(['rm -r ',mri_dir]);
                    end
                    mkdir(mri_dir);
                    % Move
                    unix(['mv ',tmpsub_dir,'/',tmpmri_dirf(1,1).name,' ',mri_dir,'/I.nii']);
                    unix(['echo ',newsub_id{i,1},' >> ',scripts_dir,'/',proj_name,'_Sublist_Y_T1.txt']);   % mri_name{j,1}
                elseif length(tmpmri_dirf) < 1
                    unix(['echo ',newsub_id{i,1},' >> ',scripts_dir,'/',proj_name,'_Sublist_L_T1.txt']);
                elseif length(tmpmri_dirf) > 1
                    unix(['echo ',newsub_id{i,1},' >> ',scripts_dir,'/',proj_name,'_Sublist_M_T1.txt']);
                end
            end 
        end
    end
end

%% All Done
cd (scripts_dir)
disp ('All Done');