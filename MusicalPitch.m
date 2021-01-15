function [note, octave, actual] = MusicalPitch(f)
%% function [note, octave, actual] = MusicalPitch(f)
%
% Calculates the nearest musical note for a given frequency
%
% Inputs:
%       f       - Vector of frequencies, Hz
%
% Outputs:
%       note    - Cell array of strings of nearest musical notes to f
%       octave  - Integer octave of note
%       actual  - Actual frequency of note, Hz
%

%% Pitches
A1 = 55;
PitchNames = {'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#'};
PitchValues = 2.^((0:11)/12);
%% Find Nearest Note
for i=1:length(f)
    thisf = f(i);
    thisoct = 1;
    while thisf > A1*2^thisoct
        thisoct = thisoct + 1;
    end
    [~,inearest] = min(abs((A1*2^(thisoct-1)*PitchValues)-thisf));
    note{i} = PitchNames{inearest}; %#ok<*AGROW>
    octave(i) = thisoct;
    actual(i) = A1*2^(thisoct-1)*PitchValues(inearest);
end
