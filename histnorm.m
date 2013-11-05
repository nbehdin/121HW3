function varargout = histnorm(varargin)
% HISTNORM Histogram normalized
%   [...] = HISTNORM(...) works like HIST, but the frequency is normalized
%   so that area sum is 1.
%
%   Bonus usage!
%   [...] = HISTNORM(..., 'plot') plots and returns the output arguments. 
%   Be sure 'plot' is the last argument.
%
%   Example:
%       data = randn (10000, 1);
%       [xo,no] = histnorm(data, 101, 'plot');
%       hold on
%       plot (no, normpdf(no), 'r');
%       hold off
%
%   See also: HIST.

%   Copyright 2009 DWTFYW.

% check whether plot is done
doPlot = 0;
if ischar (varargin{end}) && strcmpi ('plot', varargin{end})
    doPlot = 1;
    varargin = varargin(1:end-1);
elseif nargout == 0
    doPlot = 1;    
end
[nelements,xcenters] = hist(varargin{:},100);
stem(xcenters, nelements./1000)

end
