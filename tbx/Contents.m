% Anthropometric Model Toolbox
% Version 1.0 (May 2025)
%
% This toolbox provides a MATLAB class for calculating human body segment
% parameters (lengths, masses, centers of mass, radii of gyration, and more)
% using basic anthropometric data (height and mass) based on the work of
% David A. Winter.
%
% Main Class:
%   AnthropometricModel   - Create an anthropometric model and compute segment parameters.
%
% Example Usage:
%   model = AnthropometricModel(1.75, 70);    % height in meters, mass in kg
%   params = model.getAllParameters();        % get all segment parameters
%   model.displaySegmentParameters('Thigh');  % display thigh parameters
%   model.SegmentData.Trunk.Length            % or access directly.
%
% Additional Files:
%   test_AnthropometricModel.m   - Basic test script for the class.
%   README.md                    - Project description and usage guide.
%
% References:
%   Winter, D.A. (2009). Biomechanics and Motor Control of Human Movement. 4th Edition. Wiley.
%
% Disclaimer:
%   This class was developed with significant assistance from AI tools to accelerate research.
%   It has not undergone extensive testing. Use at your own risk.
