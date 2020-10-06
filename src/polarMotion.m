% (C) Copyright 2020 Remi Gau

function polarMotion(debug, direc, emul)
    % polar(debug, direc, stim, emul)
    %
    % Polar mapping: does the retinotopy with a rotating wedge
    %   direc : '+' or '-' for clockwise or anticlockwise
    %   stim :  Stimulus file name e.g. 'Checkerboard'
    %   emul :  0 = Triggered by scanner, 1 = Trigger by keypress
    %   debug : will play the experiment with PTB transparency

    if nargin < 3 || isempty(emul)
        emul = 1;
    end
    if nargin < 2 || isempty(dir)
        direc = '-';
    end
    if nargin < 1 || isempty(debug)
        debug = false;
    end

    initEnv();

    %% Experiment parameters

    cfg.task.name = 'motion direction prf';

    % Stimulus type
    cfg.aperture.type = 'none';
    % Width of wedge in degrees
    cfg.aperture.width = 70;
    % Direction of cycling
    cfg.direction = direc;

    %% Set defaults

    cfg.debug.do = debug;

        cfg.testingDevice = 'mri';
    if emul 
        cfg.testingDevice = 'pc';
    end

    cfg.extraColumns.angle = struct( ...
        'length', 1, ...
        'bids', struct( ...
        'LongName', 'position of the center of the wedge', ...
        'Units', 'degrees'));

    cfg.extraColumns.wedge_angle = struct( ...
        'length', 1, ...
        'bids', struct( ...
        'LongName', 'angular width of the wedge', ...
        'Units', 'degrees'));

    [cfg] = setParameters(cfg);

    %% Run the experiment
    [~, ~] = prfMotion(cfg);

    %     plotResults(data, expParameters);

end
