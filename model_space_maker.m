%  **** This script prepares the model space for Bayesian Model Selection ****


% Creating a model space, getting the relevant values from each participant's 3 different model files

% Create the empty struct with the field names as in chapter 38

subj = repmat(struct('sess', struct('model', repmat(struct('fname', '', 'F', 0, 'Ep', struct(), 'Cp', sparse(14,14)), 1, 3))),1,10);

% Model files' names

dcm_models = {'DCM_model_simplified_IMG','DCM_model_alternative_IMG_fb','DCM_model_alternative_IMG_ff'};



for subs = 1:10
    for m = 1:3
    data_path = sprintf('/Users/almila/Desktop/stats project copy 4/groupleveldcm/sub-%03d/sub-%03d_%s', subs, subs, dcm_models{m});
    data = load(data_path)
    subj(subs).sess.model(m).F = data.F
    subj(subs).sess.model(m).Ep = data.Ep
    subj(subs).sess.model(m).Cp = data.Cp
    subj(subs).sess.model(m).fname = data_path
    end
end

% Save the model space

output_dir = '/Users/almila/Desktop/stats project copy 4/bms1'
filename = fullfile(output_dir, 'model_space1.mat');
save(filename, 'subj');

