classdef moving_average < matlab.System
    % untitled Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a System object with discrete state.

    properties (PositiveInteger, Nontunable)
        % WindowLength Moving average filter length
        %   Specify the length of the moving average filter as a
        %   scalar positive integer value. The default value of this
        %   property is 5.
        WindowLength = 5
    end

    properties (DiscreteState)
        State;
    end

    properties (Access = private)
        % pNumChannels Property used to cache the number of input channels
        % (columns). Varying the number of channels during the streaming
        % operation is not allowed (since it modifes the number of required
        % states). The default of -1 means that the streaming operation has
        % not started yet (i.e. the number ofo channels is still unknown).
        pNumChannels = -1;
    end
    
    properties (Access = private, Nontunable)
        pCoefficients;
    end
    
    
    methods (Access = protected)
        % Constructor
        function obj = MovingAverageFilter(varargin)
            % Support name-value pair arguments when constructing the
            % object.
            setProperties(obj,nargin,varargin{:});
        end
        
        function setupImpl(obj,x)
                numChannels = size(x,2);
                obj.State = zeros(obj.WindowLength-1,numChannels,'like',x);
                % Cache the number of channels
                obj.pNumChannels = numChannels;
                obj.pCoefficients = ones(1,obj.WindowLength)/obj.WindowLength;
        end

        function Y = stepImpl(obj,X)
            % Compute output and update state
            [Y,obj.State] = filter(obj.pCoefficients,1,X,obj.State);
        end

        function resetImpl(obj)
            obj.State(:) = 0;
        end

        function validateInputsImpl(obj, u)
                validateattributes(u,{'double','single'}, {'2d',...
                    'nonsparse'},'','input');
                % The number of input channels is not allowed to change. If
                % pNumChannels = -1. This means that the streaming operation
                % has not started yet (i.e. setupImpl has not been invoked
                % yet). Do not perform the check in that case.
                coder.internal.errorIf(obj.pNumChannels~=-1 && obj.pNumChannels ~= size(u,2), 'dsp:system:varSizeChannelsNotSupported');
        end

        function s = saveObjectImpl(obj)
                s = saveObjectImpl@matlab.System(obj);
                if isLocked(obj)
                    s.pCoefficients  =  obj.pCoefficients;
                    s.pNumChannels  =  obj.pNumChannels;
                end
        end

        function loadObjectImpl(obj,s,wasLocked)
                if wasLocked
                    obj.pCoefficients = s.pCoefficients;
                    obj.pNumChannels = s.pNumChannels;
                end
                loadObjectImpl@matlab.System(obj,s,wasLocked);
        end

        function [sz,dt,cp] = getDiscreteStateSpecificationImpl(obj,~)
            inputSize = propagatedInputSize(obj,1);
            sz = [obj.WindowLength-1 inputSize(2)];
            dt =  propagatedInputDataType(obj,1);
            cp =  propagatedInputComplexity(obj,1);
        end
    end
    
end
