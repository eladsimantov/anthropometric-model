classdef AnthropometricModel
    % AnthropometricModel - Based on David Winter's Biomechanics and Motor 
    % Control of Human Movement Anthropometric Data (Table 4.1)
    % Input height and mass to calculate segment parameters
    
    properties
        Height  % Total body height (m)
        Mass    % Total body mass (kg)
        SegmentData % Structure for all segment parameters
    end
    
    methods
        function obj = AnthropometricModel(height, mass)
            % Constructor - initialize with height and mass
            if nargin > 0
                obj.Height = height;  % meters
                obj.Mass = mass;      % kg
                obj = obj.calculateParameters();
            end
        end
        
        function obj = calculateParameters(obj)
            % Calculate all segment parameters
            obj.SegmentData = struct();
            obj = obj.calculateSegmentLengths();
            obj = obj.calculateSegmentMasses();
            obj = obj.calculateCentersOfMass();
            obj = obj.calculateRadiiOfGyration();
            obj = obj.calculateDensities();
        end
        
        function obj = calculateSegmentLengths(obj)
            % Calculate segment lengths using Figure 4.1
            H = obj.Height;
            
            % Head and neck
            obj.SegmentData.Head.Length = 0.130 * H;
            
            % Arms
            obj.SegmentData.UpperArm.Length = 0.186 * H;
            obj.SegmentData.Forearm.Length = 0.146 * H;
            obj.SegmentData.Hand.Length = 0.108 * H;
            
            % Trunk
            obj.SegmentData.Trunk.Length = 0.520 * H;
            
            % Legs
            obj.SegmentData.Thigh.Length = 0.245 * H;
            obj.SegmentData.Leg.Length = 0.246 * H;
            obj.SegmentData.Foot.Length = 0.152 * H;
            obj.SegmentData.Foot.Height = 0.039 * H;
            obj.SegmentData.Foot.Width = 0.055 * H;
            
            % Combined segments
            obj.SegmentData.ForearmHand.Length = obj.SegmentData.Forearm.Length + ...
                                               obj.SegmentData.Hand.Length;
            obj.SegmentData.TotalArm.Length = obj.SegmentData.UpperArm.Length + ...
                                            obj.SegmentData.Forearm.Length + ...
                                            obj.SegmentData.Hand.Length;
            obj.SegmentData.FootLeg.Length = obj.SegmentData.Leg.Length + ...
                                           obj.SegmentData.Foot.Height;
            obj.SegmentData.TotalLeg.Length = obj.SegmentData.Thigh.Length + ...
                                            obj.SegmentData.Leg.Length + ...
                                            obj.SegmentData.Foot.Height;
            obj.SegmentData.HAT.Length = 0.530 * H;  % Head, Arms, Trunk
        end
        
        function obj = calculateSegmentMasses(obj)
            % Calculate segment masses from Table 4.1
            M = obj.Mass;
            
            % Values from Segment Weight/Total Body Weight column
            obj.SegmentData.Hand.Mass = 0.006 * M;
            obj.SegmentData.Forearm.Mass = 0.016 * M;
            obj.SegmentData.UpperArm.Mass = 0.028 * M;
            obj.SegmentData.ForearmHand.Mass = 0.022 * M;
            obj.SegmentData.TotalArm.Mass = 0.050 * M;
            obj.SegmentData.Foot.Mass = 0.0145 * M;
            obj.SegmentData.Leg.Mass = 0.0465 * M;
            obj.SegmentData.Thigh.Mass = 0.100 * M;
            obj.SegmentData.FootLeg.Mass = 0.061 * M;
            obj.SegmentData.TotalLeg.Mass = 0.161 * M;
            obj.SegmentData.HeadNeck.Mass = 0.081 * M;
            obj.SegmentData.Thorax.Mass = 0.216 * M;
            obj.SegmentData.Abdomen.Mass = 0.139 * M;
            obj.SegmentData.Pelvis.Mass = 0.142 * M;
            obj.SegmentData.ThoraxAbdomen.Mass = 0.355 * M;
            obj.SegmentData.AbdomenPelvis.Mass = 0.281 * M;
            obj.SegmentData.Trunk.Mass = 0.497 * M;
            obj.SegmentData.TrunkHeadNeck.Mass = 0.578 * M;
            obj.SegmentData.HAT.Mass = 0.678 * M;
        end
        
        function obj = calculateCentersOfMass(obj)
            % Set center of mass values from Table 4.1
            % Format: [proximal, distal] as fraction of segment length
            
            obj.SegmentData.Hand.CenterOfMass = [0.506, 0.494];
            obj.SegmentData.Forearm.CenterOfMass = [0.430, 0.570];
            obj.SegmentData.UpperArm.CenterOfMass = [0.436, 0.564];
            obj.SegmentData.ForearmHand.CenterOfMass = [0.682, 0.318];
            obj.SegmentData.TotalArm.CenterOfMass = [0.530, 0.470];
            obj.SegmentData.Foot.CenterOfMass = [0.50, 0.50];
            obj.SegmentData.Leg.CenterOfMass = [0.433, 0.567];
            obj.SegmentData.Thigh.CenterOfMass = [0.433, 0.567];
            obj.SegmentData.FootLeg.CenterOfMass = [0.606, 0.394];
            obj.SegmentData.TotalLeg.CenterOfMass = [0.447, 0.553];
            obj.SegmentData.HeadNeck.CenterOfMass = [1.000, NaN]; % distal marked as "— PC"
            obj.SegmentData.Thorax.CenterOfMass = [0.82, 0.18];
            obj.SegmentData.Abdomen.CenterOfMass = [0.44, 0.56];
            obj.SegmentData.Pelvis.CenterOfMass = [0.105, 0.895];
            obj.SegmentData.ThoraxAbdomen.CenterOfMass = [0.63, 0.37];
            obj.SegmentData.AbdomenPelvis.CenterOfMass = [0.27, 0.73];
            obj.SegmentData.Trunk.CenterOfMass = [0.50, 0.50];
            obj.SegmentData.TrunkHeadNeck.CenterOfMass = [0.66, 0.34];
            obj.SegmentData.HAT.CenterOfMass = [0.626, 0.374];
        end
        
        function obj = calculateRadiiOfGyration(obj)
            % Set radii of gyration from Table 4.1
            % Format: [C of G, Proximal, Distal] as fraction of segment length
            
            obj.SegmentData.Hand.RadiusOfGyration = [0.297, 0.587, 0.577];
            obj.SegmentData.Forearm.RadiusOfGyration = [0.303, 0.526, 0.647];
            obj.SegmentData.UpperArm.RadiusOfGyration = [0.322, 0.542, 0.645];
            obj.SegmentData.ForearmHand.RadiusOfGyration = [0.468, 0.827, 0.565];
            obj.SegmentData.TotalArm.RadiusOfGyration = [0.368, 0.645, 0.596];
            obj.SegmentData.Foot.RadiusOfGyration = [0.475, 0.690, 0.690];
            obj.SegmentData.Leg.RadiusOfGyration = [0.302, 0.528, 0.643];
            obj.SegmentData.Thigh.RadiusOfGyration = [0.323, 0.540, 0.653];
            obj.SegmentData.FootLeg.RadiusOfGyration = [0.416, 0.735, 0.572];
            obj.SegmentData.TotalLeg.RadiusOfGyration = [0.326, 0.560, 0.650];
            obj.SegmentData.HeadNeck.RadiusOfGyration = [0.495, 0.116, NaN];
            obj.SegmentData.TrunkHeadNeck.RadiusOfGyration = [0.503, 0.830, 0.607];
            obj.SegmentData.HAT.RadiusOfGyration = [0.496, 0.798, 0.621];
        end
        
        function obj = calculateDensities(obj)
            % Set density values from Table 4.1
            
            obj.SegmentData.Hand.Density = 1.16;
            obj.SegmentData.Forearm.Density = 1.13;
            obj.SegmentData.UpperArm.Density = 1.07;
            obj.SegmentData.ForearmHand.Density = 1.14;
            obj.SegmentData.TotalArm.Density = 1.11;
            obj.SegmentData.Foot.Density = 1.10;
            obj.SegmentData.Leg.Density = 1.09;
            obj.SegmentData.Thigh.Density = 1.05;
            obj.SegmentData.FootLeg.Density = 1.09;
            obj.SegmentData.TotalLeg.Density = 1.06;
            obj.SegmentData.HeadNeck.Density = 1.11;
            obj.SegmentData.Thorax.Density = 0.92;
            obj.SegmentData.AbdomenPelvis.Density = 1.01;
            obj.SegmentData.Trunk.Density = 1.03;
        end
        
        function segmentData = getAllParameters(obj)
            % Return all calculated parameters
            segmentData = obj.SegmentData;
        end
        
        function segmentData = getSegmentParameters(obj, segmentName)
            % Return parameters for a specific segment
            if isfield(obj.SegmentData, segmentName)
                segmentData = obj.SegmentData.(segmentName);
            else
                error('Segment "%s" not found.', segmentName);
            end
        end
        
        function moments = calculateMomentsOfInertia(obj)
            % Calculate moments of inertia for segments
            segments = fieldnames(obj.SegmentData);
            moments = struct();
            
            for i = 1:length(segments)
                segName = segments{i};
                if isfield(obj.SegmentData.(segName), 'Length') && ...
                   isfield(obj.SegmentData.(segName), 'Mass') && ...
                   isfield(obj.SegmentData.(segName), 'RadiusOfGyration')
                   
                    % Get segment data
                    seg = obj.SegmentData.(segName);
                    
                    % Calculate moment of inertia about center of mass
                    if ~isnan(seg.RadiusOfGyration(1))
                        moments.(segName).CoG = seg.Mass * (seg.Length * seg.RadiusOfGyration(1))^2;
                    end
                    
                    % Calculate moment of inertia about proximal end
                    if ~isnan(seg.RadiusOfGyration(2))
                        moments.(segName).Proximal = seg.Mass * (seg.Length * seg.RadiusOfGyration(2))^2;
                    end
                    
                    % Calculate moment of inertia about distal end
                    if length(seg.RadiusOfGyration) >= 3 && ~isnan(seg.RadiusOfGyration(3))
                        moments.(segName).Distal = seg.Mass * (seg.Length * seg.RadiusOfGyration(3))^2;
                    end
                end
            end
            
            obj.SegmentData.MomentsOfInertia = moments;
        end
        
        function displaySegmentParameters(obj, segmentName)
            % Display parameters for a specific segment or all segments
            if nargin < 2
                disp('Anthropometric Parameters:');
                disp(obj.SegmentData);
            else
                if isfield(obj.SegmentData, segmentName)
                    fprintf('Parameters for %s segment:\n', segmentName);
                    disp(obj.SegmentData.(segmentName));
                else
                    error('Segment "%s" not found.', segmentName);
                end
            end
        end
    end
end
