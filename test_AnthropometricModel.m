% test_AnthropometricModel.m
% Basic tests for the AnthropometricModel class

disp('Running tests for AnthropometricModel...');

% Test parameters
testHeight = 1.80; % meters
testMass = 75;     % kg

% Create the model
try
    model = AnthropometricModel(testHeight, testMass);
    disp('Class instantiation: PASS');
catch ME
    error('Class instantiation: FAIL\n%s', ME.message);
end

% Test: Segment data structure exists
if isstruct(model.SegmentData)
    disp('SegmentData structure: PASS');
else
    error('SegmentData structure: FAIL');
end

% Test: Thigh segment parameters
try
    thigh = model.getSegmentParameters('Thigh');
    assert(isfield(thigh, 'Length') && isfield(thigh, 'Mass'), 'Missing fields in Thigh');
    assert(thigh.Length > 0, 'Thigh length not positive');
    assert(thigh.Mass > 0, 'Thigh mass not positive');
    disp('Thigh segment parameters: PASS');
catch ME
    error('Thigh segment parameters: FAIL\n%s', ME.message);
end

% Test: All segment lengths are positive
segments = fieldnames(model.SegmentData);
allLengthsPositive = true;
for i = 1:length(segments)
    seg = model.SegmentData.(segments{i});
    if isfield(seg, 'Length')
        if seg.Length <= 0
            fprintf('Segment %s has non-positive length!\n', segments{i});
            allLengthsPositive = false;
        end
    end
end
if allLengthsPositive
    disp('All segment lengths positive: PASS');
else
    error('All segment lengths positive: FAIL');
end

% Test: All segment masses are positive
allMassesPositive = true;
for i = 1:length(segments)
    seg = model.SegmentData.(segments{i});
    if isfield(seg, 'Mass')
        if seg.Mass <= 0
            fprintf('Segment %s has non-positive mass!\n', segments{i});
            allMassesPositive = false;
        end
    end
end
if allMassesPositive
    disp('All segment masses positive: PASS');
else
    error('All segment masses positive: FAIL');
end

% Test: Display method
try
    model.displaySegmentParameters('Thigh');
    disp('Display method: PASS');
catch ME
    error('Display method: FAIL\n%s', ME.message);
end

% Test: Get all parameters
try
    allParams = model.getAllParameters();
    assert(isstruct(allParams), 'getAllParameters did not return a struct');
    disp('getAllParameters method: PASS');
catch ME
    error('getAllParameters method: FAIL\n%s', ME.message);
end

disp('All basic tests completed successfully.');
