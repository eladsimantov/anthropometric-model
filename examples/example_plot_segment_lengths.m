% example_plot_segment_lengths.m
% Plot the lengths of major body segments for a given subject

% Subject parameters
height = 1.80;
mass = 75;
model = AnthropometricModel(height, mass);

% List of segments to plot
segments = {'Head', 'UpperArm', 'Forearm', 'Hand', 'Trunk', 'Thigh', 'Leg', 'Foot'};
lengths = zeros(size(segments));

% Gather lengths
for i = 1:numel(segments)
    seg = model.getSegmentParameters(segments{i});
    lengths(i) = seg.Length;
end

% Plot
figure;
bar(lengths);
set(gca, 'XTickLabel', segments, 'XTick', 1:numel(segments));
ylabel('Segment Length (m)');
title('Segment Lengths for Subject');
grid on;
