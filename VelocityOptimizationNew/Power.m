% Yukai Qian, Gerry Chen
% Duke Electric Vehicles
%
% Power  Total power and power components.
%
%   PTOT = Power(V)
%   [PTOT, PCOMPNT] = Power(___)
%
%   V       (m/s)   1-by-N vector of horizontal velocities.
%   PTOT    (W)     1-by-N vector of total powers.
%   PCOMPNT (W)     7-by-N vector of power consumed by acceleration, 
%                   rolling resistance, air drag, cornering loss, wheel 
%                   drag, elevation change and motor loss.

function [PTOT, PCOMPNT] = Power(V)

global r u d cEddy regen pMax

%% Output power

% Tractive force
f = Tract(V);

% Output power
PCOMPNT = f.*V;
POUT    = sum(PCOMPNT);

%% Eddy current loss

% Angular velocity in rpm
rpm = 60/(2*pi) * V/(d/2);

% Eddy current loss
pEddy = -polyval(cEddy, rpm);

%% Total power

% Current = total power / voltage:
%   i = PTOT/u;
% Motor power loss = eddy current loss + resistance loss:
%   pLoss = pEddy + r*i^2;
% Total power = output power + motor power loss:
%   PTOT = POUT + pLoss;
% Therefore, we have equation:
%   PTOT^2 - u^2/r * PTOT + u^2/r * (POUT + pEddy) = 0.
% It can be solved as follows.

b   = -u^2/r;
c   = -b * (POUT + pEddy);
det = b^2 - 4*c;

% Total power
PTOT = (-b - sqrt(det))/2;

% Disable re-gen if regen == 0 (false).
if strcmp(regen, 'off')
    PTOT = PTOT .* (POUT > 0);
elseif ~strcmp(regen, 'on')
    pRegenMax = regen*pMax;
    PTOT = PTOT .* (PTOT > -pRegenMax) - pRegenMax * (PTOT <= -pRegenMax);
end

%% Motor power loss

if nargout == 2
    PCOMPNT = [PCOMPNT; PMOTOR];
end