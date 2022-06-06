%=========================================================================%
% Function: lognornals
% Author: Daniel Galvis
%
% 03/03/2021
% code generation
%
%
% This function creates an array of size shape with lognormal distribution
% of random numbers 
% 
% Parameters
% ==========
% means : mean value to draw from
% stds : standard deviation to draw from
% shape : shape of the array to return of random numbers
% 
% Returns
% =======
% out : random number array of size shape
%=========================================================================%


function out = lognormals(means, stds, shape)
    % Define lognormal distribution parameters
    mu         = log(means^2 / sqrt(stds^2 + means^2));
    sig        = sqrt(log(stds^2 / means^2 + 1));

    % Draw random numbers
    if means > 0
        
        out        = lognrnd(mu, sig, shape);
    else
        out        = zeros(shape);
    end
end 