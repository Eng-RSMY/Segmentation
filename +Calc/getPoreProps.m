% The aim of this function is to calculate the pore size and other properties 
% of pores based on a pre-segmented image.

%INPUT:
%       IM: A binary image or binary volume
%       IMScaled: IM where the sampling in X,Y and Z is the same (processed
%                 within mainPoreSizeCalc(only needed for 3D)
%       dim: '2D', '3D' and 'both' user option to run the analysis only in
%       a specific dimension (2D analyze z-slice independently, 3D analyze
%       considering the data as a coherent volume. 'both' will run the two
%       types
%             
%OUTPUT:
%       pores2D: A strutcture containing different poreProperties:
%                inner and external radii, throats, connectivity, equiv
%                diameter, center position
%                return empty if 2D analysis is not run
%       pores3D: A structure containing the 3D equivalent of the pores2D
%                properties
%                return empty if 2D analysis is not run
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% AUTHOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Boris Louis (https://github.com/BorisLouis)                             %
% Rafael Camacho Dejay (https://github.com/CamachoDejay)                  %
% Susana Rocha (https://github.com/SusanaRocha)                           %                                                                        %
% Website : Boris Louis: https://borislouis.github.io/                    %
%           Rafael Camacho Dejay: https://camachodejay.github.io/         %                               
%           Susana Rocha: https://susanarocha.github.io/                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function [pores2D,pores3D] = getPoreProps(IM,IMScaled,dim)
%check number of input provided
switch nargin
    case 1
        dim = '2D'; %if IM is not scaled 3D should not be used
    case 2
        dim = 'both';
    case 3
    otherwise
        error('Wrong number of input argument, expect [1 3]');
end
% act depending on the dimension requested by the user
switch dim
    case '2D'
        an2D = true;
        an3D = false;
        pores3D =[];
    case '3D'
        an2D = false;
        an3D = true;
        pores2D = [];
    case 'both'
        an2D = true;
        an3D = true;
    otherwise
        error('Please provided the type of analysis you want to perform (2D, 3D or both)');
end

if an2D
    [pores2D] = Calc.getPoreProps2D(IM);
end

if an3D
    [pores3D] = Calc.getPoreProps3D(IMScaled);
end


