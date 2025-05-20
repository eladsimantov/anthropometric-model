% example_compare_subjects.m
% Compare anthropometric parameters for two different subjects

% Subject 1: average adult
height1 = 1.70;
mass1 = 65;
model1 = AnthropometricModel(height1, mass1);

% Subject 2: taller and heavier
height2 = 1.85;
mass2 = 85;
model2 = AnthropometricModel(height2, mass2);

% Compare thigh lengths and masses
thigh1 = model1.getSegmentParameters('Thigh');
thigh2 = model2.getSegmentParameters('Thigh');

fprintf('Subject 1 - Thigh length: %.3f m, mass: %.2f kg\n', thigh1.Length, thigh1.Mass);
fprintf('Subject 2 - Thigh length: %.3f m, mass: %.2f kg\n', thigh2.Length, thigh2.Mass);

% Compare total leg lengths
fprintf('Subject 1 - Total leg length: %.3f m\n', model1.SegmentData.TotalLeg.Length);
fprintf('Subject 2 - Total leg length: %.3f m\n', model2.SegmentData.TotalLeg.Length);
