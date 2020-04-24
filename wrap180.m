function out = wrap180(in)
out = mod(in,360);
out(out>180) = out(out>180) - 360;