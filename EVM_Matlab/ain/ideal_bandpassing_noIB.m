% FILTERED = ideal_bandpassing(INPUT,DIM,WL,WH,SAMPLINGRATE)
% 
% Apply ideal band pass filter on INPUT along dimension DIM.
% 
% WL: lower cutoff frequency of ideal band pass filter
% WH: higher cutoff frequency of ideal band pass filter
% SAMPLINGRATE: sampling rate of INPUT
% 
% Copyright (c) 2011-2012 Massachusetts Institute of Technology, 
% Quanta Research Cambridge, Inc.
%
% Authors: Hao-yu Wu, Michael Rubinstein, Eugene Shih, 
% License: Please refer to the LICENCE file
% Date: June 2012
%
function filtered = ideal_bandpassing_noIB(input, dim, wl, wh, samplingRate)

    if (dim > size(size(input),2))
        error('Exceed maximum dimension');
    end

    input_shifted = shiftdim(input,dim-1);
    Dimensions = size(input_shifted);
    
    n = Dimensions(1);
    dn = size(Dimensions,2);
    
    
    Freq = 1:n;
    Freq = (Freq-1)/n*samplingRate;
    mask = Freq;
  %  mask(1)= .05;   %not 0 in order to not have ideal bandpass at all
 %there's still some magic here!
 
    Dimensions(1) = 1;
    mask = mask(:);
    mask = repmat(mask, Dimensions);

    
    F = fft(input_shifted,[],1);
    
    F(~mask) = 0;
    
    filtered = real(ifft(F,[],1));
    
    filtered = shiftdim(filtered,dn-(dim-1));
    
end
