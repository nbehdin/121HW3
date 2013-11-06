function [N] = rateless(k,encoding,decoding,numTrials)
%RATELESS simulates rateless codes for different distributions
%   k is the number of bits of the input message
%   encoding is the distribution chosen for encoding symbols
        % ('u')niform, ('i')deal (soliton), or ('r')obust (soliton)
%   decoding is the method chosen for decoding symbols
        % ('l')insolve (row reduce) or ('s')ubsolve (substitution cipher)
%   output N is the number of equations needed to solve for the message

% Generate message of k bits
message = randi([0 1],1,k);

% Set distrb=1 for uniform, 2 for ideal soliton, 3 for robust soliton
distrb = 0;
% Set eqnslv=1 for linear eqn solver, 2 for subsitution cipher
eqnslv = 0;
% THIS WHILE LOOP IS ONLY FOR CODE FOLDING PURPOSES
while ~distrb
    strsencode = {'uniform','ideal','robust'};
    strsdecode = {'linsolve','subsolve'};
    distrb = find(strncmpi(encoding,strsencode,length(encoding)));
    eqnslv = find(strncmpi(decoding,strsdecode,length(decoding)));
    if isempty(distrb),
      error(message('rateless:InvalidEncoding'));
    elseif length(distrb)>1,
      error(message('rateless:AmbiguousEncoding'));
    end
    if isempty(eqnslv),
      error(message('rateless:InvalidDecoding'));
    elseif length(eqnslv)>1,
      error(message('rateless:AmbiguousDecoding'));
    end
    encoding = strsencode{distrb};
    decoding = strsdecode{eqnslv};
end


%numTrials = 10;
N = zeros(1,numTrials);
for i = 1:numTrials
    %Initialize generator matrix for efficiency
    G = zeros(k+200,k);
    row = 0;
    solved = false;
    decoded = NaN(1, k);
    parity = [];
    count = [];
    while ~solved %cannot solve for message
        row = row + 1;
        G(row,:) = generateRow(k,distrb);
        [solved, G, decoded, parity, count] = eqnsolv(G,message,eqnslv,row,decoded, parity, count);
    end
    if (sum(decoded ~= message) ~= 0)
        error('incorrect decoding');
    end
    N(i) = row;
end

histnorm(N);
end

