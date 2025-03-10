==========
1906220124
==========

  Re-gen on.
  All restarts returned "Local minimum possible". The solutions were almost 
identical, with a total energy of 4830.6 J (914 mi/kWh), so they could be 
confidently seen as possible global minimum. They suggested, somewhat 
predictably, to use re-gen and decelerate to as low as under 6 m/s around the 
corners, the overall lowest speed being just over 5.3 m/s. To meet the average 
speed requirement, the speed on the straights ranged mostly from 6.7 m/s to 
7 m/s, reaching over 7.2 m/s at a downhill.
  Overall, The maximum power output was about 60 W and the maximum re-gen power
was 45 W. The time-averaged power was 16.4 W, and the time-averaged output 
power was 18.7 W, treating re-gen as zero output.

---------
Constants
---------
    mu    = 0.0015;     %          Rolling resistance coefficient
    m     = 21+50;      % (kg)     Total mass
    mg    = m*9.809;    % (N)      Gravity
    rho   = 1.2;        % (kg/m^3) Air density at 20 C
    cdA   = 0.033;      % (m^2)    Drag coefficient times area
    cCor  = 120*180/pi; % (N/rad)  Tire cornering stiffness
    c1    = 3.4e-4;     % (kg/m)   Wheel drag quadratic coefficient
    c2    = 0.051;      % (N)      Wheel drag constant term
    r     = 0.14;       % (ohm)    Motor resistance
    u     = 12;         % (V)      Motor voltage
    d     = 0.475;      % (m)      Wheel diameter

    % Motor eddy current loss coefficients
    cEddy = [-5.370e-10 -4.653e-6 -5.972e-3 0]; 

    % State of motor re-gen function. 
    % 'on' for re-gen on with maximum power pMax. 'off' for completely off. 
    % Number r (0 < r < 1) for re-gen on with maximum power r*pMax.
    regen = 'on'; 

----------
Restraints
----------
    vAvg = 6.7;               % (m/s) Target average velocity
    tMax = track.s(end)/vAvg; % (s)   Maximum time
    pMax = 12*u;              % (W)   Maximum power to/from motor
    
    function [C, CEQ] = Constr(V)
        global tMax pMax

        C = [TimeTotal(V) - tMax; ...
             max(abs(Power(V))) - pMax];
        CEQ = [];
    end

--------------------
Optimization Options
--------------------
    options = optimoptions('fmincon', ...
                           'MaxFunctionEvaluations', 2e6, ...
                           'MaxIterations', 2e3, ...
                           'ObjectiveLimit', 0, ...
                           'Display', 'off');
                       
--------
Restarts
--------
    nRst   = 5;             % Number of random restarts
    v0     = cell(1, nRst); % Starting points
 
    % Generate random starting points
    vRand = cumsum(0.05*rand(1, n));
    vRand = vRand - (0:n-1)/(n-1) .* vRand(end);

    v0{rst} = 6.8 + vRand;
    v0{rst} = circshift(v0{rst}, randi(n));

    % Make starting points satisfy constraints
    if TimeTotal(v0{rst}) > tMax
        v0{rst} = TimeTotal(v0{rst})/tMax * v0{rst};
    end

==========
1906221037
==========

  Re-gen off.
  Restarts 1, 4, 6, 8 and 10 returned "Local minumum possible", but the 
solutions were different from each other. Further search for global optimum is
needed.
  The five results will be used to generate starting points for the next
optimization attempt.

---------
Constants
---------
    mu    = 0.0015;     %          Rolling resistance coefficient
    m     = 21+50;      % (kg)     Total mass
    mg    = m*9.809;    % (N)      Gravity
    rho   = 1.2;        % (kg/m^3) Air density at 20 C
    cdA   = 0.033;      % (m^2)    Drag coefficient times area
    cCor  = 120*180/pi; % (N/rad)  Tire cornering stiffness
    c1    = 3.4e-4;     % (kg/m)   Wheel drag quadratic coefficient
    c2    = 0.051;      % (N)      Wheel drag constant term
    r     = 0.14;       % (ohm)    Motor resistance
    u     = 12;         % (V)      Motor voltage
    d     = 0.475;      % (m)      Wheel diameter

    % Motor eddy current loss coefficients
    cEddy = [-5.370e-10 -4.653e-6 -5.972e-3 0]; 

    % State of motor re-gen function. 
    % 'on' for re-gen on with maximum power pMax. 'off' for completely off. 
    % Number r (0 < r < 1) for re-gen on with maximum power r*pMax.
    regen = 'on'; 

----------
Restraints
----------
    vAvg = 6.7;               % (m/s) Target average velocity
    tMax = track.s(end)/vAvg; % (s)   Maximum time
    pMax = 12*u;              % (W)   Maximum power to/from motor
    
    function [C, CEQ] = Constr(V)
        global tMax pMax

        C = [TimeTotal(V) - tMax; ...
             max(abs(Power(V))) - pMax];
        CEQ = [];
    end

--------------------
Optimization Options
--------------------
    options = optimoptions('fmincon', ...
                           'MaxFunctionEvaluations', 3e5, ...
                           'MaxIterations', 3e2, ...
                           'ObjectiveLimit', 0, ...
                           'Display', 'off');
                       
--------
Restarts
--------
    nRst   = 10;            % Number of random restarts
    v0     = cell(1, nRst); % Starting points
 
    % Generate random starting points
    vRand = cumsum(0.05*rand(1, n));
    vRand = vRand - (0:n-1)/(n-1) .* vRand(end);

    v0{rst} = 6.8 + vRand;
    v0{rst} = circshift(v0{rst}, randi(n));

    % Make starting points satisfy constraints
    if TimeTotal(v0{rst}) > tMax
        v0{rst} = TimeTotal(v0{rst})/tMax * v0{rst};
    end

==========
1906221218
==========

  Re-gen off.
  Restarts 3, 4, 7, 16, 19, 20, 22, and 24 are the best solutions with < 5650 J 
of total energy. They are similar to each other but still visibly different. 
More iteration steps are needed.
  The 8 best results will be used to generate starting points for the next
optimization attempt.

---------
Constants
---------
    mu    = 0.0015;     %          Rolling resistance coefficient
    m     = 21+50;      % (kg)     Total mass
    mg    = m*9.809;    % (N)      Gravity
    rho   = 1.2;        % (kg/m^3) Air density at 20 C
    cdA   = 0.033;      % (m^2)    Drag coefficient times area
    cCor  = 120*180/pi; % (N/rad)  Tire cornering stiffness
    c1    = 3.4e-4;     % (kg/m)   Wheel drag quadratic coefficient
    c2    = 0.051;      % (N)      Wheel drag constant term
    r     = 0.14;       % (ohm)    Motor resistance
    u     = 12;         % (V)      Motor voltage
    d     = 0.475;      % (m)      Wheel diameter

    % Motor eddy current loss coefficients
    cEddy = [-5.370e-10 -4.653e-6 -5.972e-3 0]; 

    % State of motor re-gen function. 
    % 'on' for re-gen on with maximum power pMax. 'off' for completely off. 
    % Number r (0 < r < 1) for re-gen on with maximum power r*pMax.
    regen = 'on'; 

----------
Restraints
----------
    vAvg = 6.7;               % (m/s) Target average velocity
    tMax = track.s(end)/vAvg; % (s)   Maximum time
    pMax = 12*u;              % (W)   Maximum power to/from motor
    
    function [C, CEQ] = Constr(V)
        global tMax pMax

        C = [TimeTotal(V) - tMax; ...
             max(abs(Power(V))) - pMax];
        CEQ = [];
    end

--------------------
Optimization Options
--------------------
    options = optimoptions('fmincon', ...
                           'MaxFunctionEvaluations', 4e4, ...
                           'MaxIterations', 4e1, ...
                           'ObjectiveLimit', 0, ...
                           'Display', 'off');
                       
--------
Restarts
--------
    prevSol = load('1906221037');
    vPrev   = cell2mat(prevSol.v([1 4 6 8 10])');

    nRst   = 30;            % Number of random restarts
    v0     = cell(1, nRst); % Starting points
 
    % Generate random starting points
    while 1
        randWeight = rand(1, 4);

        if sum(randWeight) < 1
            break
        end
    end

    vTmp = [randWeight 1-sum(randWeight)] * vPrev;

    vRand = cumsum(0.01*rand(1, n));
    vRand = vRand - (0:n-1)/(n-1) .* vRand(end);
    vRand = circshift(vRand, randi(n));

    v0{rst} = vTmp + vRand;

    % Make starting points satisfy constraints
    if TimeTotal(v0{rst}) > tMax
        v0{rst} = TimeTotal(v0{rst})/tMax * v0{rst};
    end

==========
1906221308
==========

  Re-gen off.
  Restarts 11, 14, 15 and 27 are the best solutions with < 5580 J 
of total energy. They are similar to each other but still visibly different. 
More iteration steps are needed.
  The 4 best results will be used to generate starting points for the next
optimization attempt.

---------
Constants
---------
    mu    = 0.0015;     %          Rolling resistance coefficient
    m     = 21+50;      % (kg)     Total mass
    mg    = m*9.809;    % (N)      Gravity
    rho   = 1.2;        % (kg/m^3) Air density at 20 C
    cdA   = 0.033;      % (m^2)    Drag coefficient times area
    cCor  = 120*180/pi; % (N/rad)  Tire cornering stiffness
    c1    = 3.4e-4;     % (kg/m)   Wheel drag quadratic coefficient
    c2    = 0.051;      % (N)      Wheel drag constant term
    r     = 0.14;       % (ohm)    Motor resistance
    u     = 12;         % (V)      Motor voltage
    d     = 0.475;      % (m)      Wheel diameter

    % Motor eddy current loss coefficients
    cEddy = [-5.370e-10 -4.653e-6 -5.972e-3 0]; 

    % State of motor re-gen function. 
    % 'on' for re-gen on with maximum power pMax. 'off' for completely off. 
    % Number r (0 < r < 1) for re-gen on with maximum power r*pMax.
    regen = 'on'; 

----------
Restraints
----------
    vAvg = 6.7;               % (m/s) Target average velocity
    tMax = track.s(end)/vAvg; % (s)   Maximum time
    pMax = 12*u;              % (W)   Maximum power to/from motor
    
    function [C, CEQ] = Constr(V)
        global tMax pMax

        C = [TimeTotal(V) - tMax; ...
             max(abs(Power(V))) - pMax];
        CEQ = [];
    end

--------------------
Optimization Options
--------------------
    options = optimoptions('fmincon', ...
                           'MaxFunctionEvaluations', 4e4, ...
                           'MaxIterations', 4e1, ...
                           'ObjectiveLimit', 0, ...
                           'Display', 'off');
                       
--------
Restarts
--------
    prevSol    = load('1906221218');
    nBest      = 8;
    [~, index] = mink(prevSol.eTotal, nBest);
    vPrev      = cell2mat(prevSol.v(index)');

    nRst   = 30;            % Number of random restarts
    v0     = cell(1, nRst); % Starting points
 
    % Generate random starting points
    while 1
        randWeight = rand(1, nBest-1);

        if sum(randWeight) < 1
            break
        end
    end

    vTmp = [randWeight 1-sum(randWeight)] * vPrev;

    vRand = cumsum(0.01*rand(1, n));
    vRand = vRand - (0:n-1)/(n-1) .* vRand(end);
    vRand = circshift(vRand, randi(n));

    v0{rst} = vTmp + vRand;

    % Make starting points satisfy constraints
    if TimeTotal(v0{rst}) > tMax
        v0{rst} = TimeTotal(v0{rst})/tMax * v0{rst};
    end

==========
1906221344
==========

  Re-gen off.
  Restarts 1 and 6 are the best solutions with < 5500 J of total energy. They 
are similar to each other but still visibly different. More iteration steps are 
needed.
  The 2 best results will be used to generate starting points for the next
optimization attempt.

---------
Constants
---------
    mu    = 0.0015;     %          Rolling resistance coefficient
    m     = 21+50;      % (kg)     Total mass
    mg    = m*9.809;    % (N)      Gravity
    rho   = 1.2;        % (kg/m^3) Air density at 20 C
    cdA   = 0.033;      % (m^2)    Drag coefficient times area
    cCor  = 120*180/pi; % (N/rad)  Tire cornering stiffness
    c1    = 3.4e-4;     % (kg/m)   Wheel drag quadratic coefficient
    c2    = 0.051;      % (N)      Wheel drag constant term
    r     = 0.14;       % (ohm)    Motor resistance
    u     = 12;         % (V)      Motor voltage
    d     = 0.475;      % (m)      Wheel diameter

    % Motor eddy current loss coefficients
    cEddy = [-5.370e-10 -4.653e-6 -5.972e-3 0]; 

    % State of motor re-gen function. 
    % 'on' for re-gen on with maximum power pMax. 'off' for completely off. 
    % Number r (0 < r < 1) for re-gen on with maximum power r*pMax.
    regen = 'on'; 

----------
Restraints
----------
    vAvg = 6.7;               % (m/s) Target average velocity
    tMax = track.s(end)/vAvg; % (s)   Maximum time
    pMax = 12*u;              % (W)   Maximum power to/from motor
    
    function [C, CEQ] = Constr(V)
        global tMax pMax

        C = [TimeTotal(V) - tMax; ...
             max(abs(Power(V))) - pMax];
        CEQ = [];
    end

--------------------
Optimization Options
--------------------
    options = optimoptions('fmincon', ...
                           'MaxFunctionEvaluations', 4e4, ...
                           'MaxIterations', 4e1, ...
                           'ObjectiveLimit', 0, ...
                           'Display', 'off');
                       
--------
Restarts
--------
    prevSol    = load('1906221308');
    nBest      = 4;
    [~, index] = mink(prevSol.eTotal, nBest);
    vPrev      = cell2mat(prevSol.v(index)');

    nRst   = 30;            % Number of random restarts
    v0     = cell(1, nRst); % Starting points
 
    % Generate random starting points
    while 1
        randWeight = rand(1, nBest-1);

        if sum(randWeight) < 1
            break
        end
    end

    vTmp = [randWeight 1-sum(randWeight)] * vPrev;

    vRand = cumsum(0.01*rand(1, n));
    vRand = vRand - (0:n-1)/(n-1) .* vRand(end);
    vRand = circshift(vRand, randi(n));

    v0{rst} = vTmp + vRand;

    % Make starting points satisfy constraints
    if TimeTotal(v0{rst}) > tMax
        v0{rst} = TimeTotal(v0{rst})/tMax * v0{rst};
    end

==========
1906221417
==========

  Re-gen off.
  Restarts 11 and 15 are the best solutions with < 5470 J of total energy. They 
are very similar to each other. One more iteration step should suffice.
  The 2 best results will be used to generate starting points for the next
optimization attempt.

---------
Constants
---------
    mu    = 0.0015;     %          Rolling resistance coefficient
    m     = 21+50;      % (kg)     Total mass
    mg    = m*9.809;    % (N)      Gravity
    rho   = 1.2;        % (kg/m^3) Air density at 20 C
    cdA   = 0.033;      % (m^2)    Drag coefficient times area
    cCor  = 120*180/pi; % (N/rad)  Tire cornering stiffness
    c1    = 3.4e-4;     % (kg/m)   Wheel drag quadratic coefficient
    c2    = 0.051;      % (N)      Wheel drag constant term
    r     = 0.14;       % (ohm)    Motor resistance
    u     = 12;         % (V)      Motor voltage
    d     = 0.475;      % (m)      Wheel diameter

    % Motor eddy current loss coefficients
    cEddy = [-5.370e-10 -4.653e-6 -5.972e-3 0]; 

    % State of motor re-gen function. 
    % 'on' for re-gen on with maximum power pMax. 'off' for completely off. 
    % Number r (0 < r < 1) for re-gen on with maximum power r*pMax.
    regen = 'on'; 

----------
Restraints
----------
    vAvg = 6.7;               % (m/s) Target average velocity
    tMax = track.s(end)/vAvg; % (s)   Maximum time
    pMax = 12*u;              % (W)   Maximum power to/from motor
    
    function [C, CEQ] = Constr(V)
        global tMax pMax

        C = [TimeTotal(V) - tMax; ...
             max(abs(Power(V))) - pMax];
        CEQ = [];
    end

--------------------
Optimization Options
--------------------
    options = optimoptions('fmincon', ...
                           'MaxFunctionEvaluations', 4e4, ...
                           'MaxIterations', 4e1, ...
                           'ObjectiveLimit', 0, ...
                           'Display', 'off');
                       
--------
Restarts
--------
    prevSol    = load('1906221344');
    nBest      = 2;
    [~, index] = mink(prevSol.eTotal, nBest);
    vPrev      = cell2mat(prevSol.v(index)');

    nRst   = 30;            % Number of random restarts
    v0     = cell(1, nRst); % Starting points
 
    % Generate random starting points
    while 1
        randWeight = rand(1, nBest-1);

        if sum(randWeight) < 1
            break
        end
    end

    vTmp = [randWeight 1-sum(randWeight)] * vPrev;

    vRand = cumsum(0.01*rand(1, n));
    vRand = vRand - (0:n-1)/(n-1) .* vRand(end);
    vRand = circshift(vRand, randi(n));

    v0{rst} = vTmp + vRand;

    % Make starting points satisfy constraints
    if TimeTotal(v0{rst}) > tMax
        v0{rst} = TimeTotal(v0{rst})/tMax * v0{rst};
    end

==========
1906221439
==========

  Re-gen off.
  Restart 22 gave the best result at 5434.2 J (812 mi/kWh). It suggests
maintaining the speed between 6.5 and 6.9 m/s, going slower around the corner
with higher elevation and faster around the lower one. On the downhill straight,
it suggests keeping the throttle idle most of the time, except when climbing up
the two large-scale bumps, so as the speed is maintained around 6.7 m/s.
  The average power output is 18.5 W.

---------
Constants
---------
    mu    = 0.0015;     %          Rolling resistance coefficient
    m     = 21+50;      % (kg)     Total mass
    mg    = m*9.809;    % (N)      Gravity
    rho   = 1.2;        % (kg/m^3) Air density at 20 C
    cdA   = 0.033;      % (m^2)    Drag coefficient times area
    cCor  = 120*180/pi; % (N/rad)  Tire cornering stiffness
    c1    = 3.4e-4;     % (kg/m)   Wheel drag quadratic coefficient
    c2    = 0.051;      % (N)      Wheel drag constant term
    r     = 0.14;       % (ohm)    Motor resistance
    u     = 12;         % (V)      Motor voltage
    d     = 0.475;      % (m)      Wheel diameter

    % Motor eddy current loss coefficients
    cEddy = [-5.370e-10 -4.653e-6 -5.972e-3 0]; 

    % State of motor re-gen function. 
    % 'on' for re-gen on with maximum power pMax. 'off' for completely off. 
    % Number r (0 < r < 1) for re-gen on with maximum power r*pMax.
    regen = 'on'; 

----------
Restraints
----------
    vAvg = 6.7;               % (m/s) Target average velocity
    tMax = track.s(end)/vAvg; % (s)   Maximum time
    pMax = 12*u;              % (W)   Maximum power to/from motor
    
    function [C, CEQ] = Constr(V)
        global tMax pMax

        C = [TimeTotal(V) - tMax; ...
             max(abs(Power(V))) - pMax];
        CEQ = [];
    end

--------------------
Optimization Options
--------------------
    options = optimoptions('fmincon', ...
                           'MaxFunctionEvaluations', 4e4, ...
                           'MaxIterations', 4e1, ...
                           'ObjectiveLimit', 0, ...
                           'Display', 'off');
                       
--------
Restarts
--------
    prevSol    = load('1906221344');
    nBest      = 2;
    [~, index] = mink(prevSol.eTotal, nBest);
    vPrev      = cell2mat(prevSol.v(index)');

    nRst   = 30;            % Number of random restarts
    v0     = cell(1, nRst); % Starting points
 
    % Generate random starting points
    while 1
        randWeight = rand(1, nBest-1);

        if sum(randWeight) < 1
            break
        end
    end

    vTmp = [randWeight 1-sum(randWeight)] * vPrev;

    vRand = cumsum(0.01*rand(1, n));
    vRand = vRand - (0:n-1)/(n-1) .* vRand(end);
    vRand = circshift(vRand, randi(n));

    v0{rst} = vTmp + vRand;

    % Make starting points satisfy constraints
    if TimeTotal(v0{rst}) > tMax
        v0{rst} = TimeTotal(v0{rst})/tMax * v0{rst};
    end

///////////////////////
OLD MOTOR MODEL RESULTS
///////////////////////

==========
1906190950
==========

  Re-gen on.
  Restarts 2, 3, 6, 8 and 10 returned "Local minimum possible". The solutions
were almost identical, with a total energy of 4834.8 J (913 mi/kWh), so they 
could be confidently seen as possible global minimum. They suggested, somewhat 
predictably, to use re-gen and decelerate to as low as under 6 m/s around the 
corners, the overall lowest speed being just over 5.3 m/s. To meet the average 
speed requirement, the speed on the straights ranged mostly from 6.7 m/s to 
7 m/s, reaching over 7.2 m/s at a downhill.
  Overall, The maximum power output was about 70 W and the maximum re-gen power
was 43 W. The time-averaged power was 16.6 W, and the time-averaged output 
power was 18.9 W, treating re-gen as zero output.

---------
Constants
---------
    mu    = 0.0015;     %          Rolling resistance coefficient
    m     = 21+50;      % (kg)     Total mass
    mg    = m*9.809;    % (N)      Gravity
    rho   = 1.2;        % (kg/m^3) Air density at 20 C
    cdA   = 0.037;      % (m^2)    Drag coefficient times area
    cCor  = 120*180/pi; % (N/rad)  Tire cornering stiffness
    c1    = 3.4e-4;     % (kg/m)   Wheel drag quadratic coefficient
    c2    = 0.051;      % (N)      Wheel drag constant term
    r     = 0.13;       % (ohm)    Motor resistance
    u     = 12;         % (V)      Motor voltage
    cEddy = 0.03;       % (kg/s)   Eddy current loss constant
    regen = 'on';       %          State of motor re-gen function. 'on' for
                        %            re-gen on with maximum power pMax. 'off'
                        %            for completely off. Number r (0 < r < 1)
                        %            for re-gen on with maximum power r*pMax.

----------
Restraints
----------
    vAvg = 6.7;               % (m/s) Target average velocity
    tMax = track.s(end)/vAvg; % (s)   Maximum time
    pMax = 12*u;              % (W)   Maximum power to/from motor
    
    function [C, CEQ] = Constr(V)
        global tMax pMax

        C = [TimeTotal(V) - tMax; ...
             max(abs(Power(V))) - pMax];
        CEQ = [];
    end

--------------------
Optimization Options
--------------------
    options = optimoptions('fmincon', ...
                           'MaxFunctionEvaluations', 2e6, ...
                           'MaxIterations', 2e3, ...
                           'ObjectiveLimit', 0, ...
                           'Display', 'off');
                       
--------
Restarts
--------
    nRst   = 10;            % Number of random restarts
    v0     = cell(1, nRst); % Starting points
 
    % Generate random starting points
    vRand = cumsum(0.1*rand(1, n));
    vRand = vRand - (0:n-1)/(n-1) .* vRand(end);

    v0{rst} = 6.8 + vRand;
    v0{rst} = circshift(v0{rst}, randi(n));

    % Make starting points satisfy constraints
    if TimeTotal(v0{rst}) > tMax
        v0{rst} = TimeTotal(v0{rst})/tMax * v0{rst};
    end

==========
1906192009
==========

  Re-gen off.
  Restarts 3~10 returned "Local minumum possible", but the solutions were
different from each other. Restarts 3 and 6~9 gave total energies less than
5700 J. They all suggested maintaining the speed between 6.5 and 7 m/s. 
They did not appear to be globally optimal, since there was negative traction
at times, which means breaking. However, it did seem that restart 7, the one
with the least total energy (5617.2 J), had the shortest periods of breaking.
It had a time-averaged power output of 19.1 W.
  The five best results will be used to generate starting points for the next
optimization attempt.

---------
Constants
---------
    mu    = 0.0015;     %          Rolling resistance coefficient
    m     = 21+50;      % (kg)     Total mass
    mg    = m*9.809;    % (N)      Gravity
    rho   = 1.2;        % (kg/m^3) Air density at 20 C
    cdA   = 0.037;      % (m^2)    Drag coefficient times area
    cCor  = 120*180/pi; % (N/rad)  Tire cornering stiffness
    c1    = 3.4e-4;     % (kg/m)   Wheel drag quadratic coefficient
    c2    = 0.051;      % (N)      Wheel drag constant term
    r     = 0.13;       % (ohm)    Motor resistance
    u     = 12;         % (V)      Motor voltage
    cEddy = 0.03;       % (kg/s)   Eddy current loss constant
    regen = 'off';      %          State of motor re-gen function. 'on' for
                        %            re-gen on with maximum power pMax. 'off'
                        %            for completely off. Number r (0 < r < 1)
                        %            for re-gen on with maximum power r*pMax.

----------
Restraints
----------
    vAvg = 6.7;               % (m/s) Target average velocity
    tMax = track.s(end)/vAvg; % (s)   Maximum time
    pMax = 12*u;              % (W)   Maximum power to/from motor
    
    function [C, CEQ] = Constr(V)
        global tMax pMax

        C = [TimeTotal(V) - tMax; ...
             max(abs(Power(V))) - pMax];
        CEQ = [];
    end

--------------------
Optimization Options
--------------------
    options = optimoptions('fmincon', ...
                           'MaxFunctionEvaluations', 3e6, ...
                           'MaxIterations', 3e3, ...
                           'ObjectiveLimit', 0, ...
                           'Display', 'off');
                       
--------
Restarts
--------
    nRst   = 10;            % Number of random restarts
    v0     = cell(1, nRst); % Starting points
 
    % Generate random starting points
    vRand = cumsum(0.05*rand(1, n));
    vRand = vRand - (0:n-1)/(n-1) .* vRand(end);

    v0{rst} = 6.8 + vRand;
    v0{rst} = circshift(v0{rst}, randi(n));

    % Make starting points satisfy constraints
    if TimeTotal(v0{rst}) > tMax
        v0{rst} = TimeTotal(v0{rst})/tMax * v0{rst};
    end

==========
1906201139
==========

  Re-gen off.
  Using the last run's best five results to generate starting points.
  All restarts returned "local minimum possible" within < 30 iterations.
Restarts 4~6 gave total energies under 5600 J, the best being restart 6 at only
5558.3 J. The three velocity profiles are visibly different, but they span a 
much smaller interval than the five best results from the previous run do.
  The three best results will be used to generate starting points for the next
optimization attempt.

---------
Constants
---------
    mu    = 0.0015;     %          Rolling resistance coefficient
    m     = 21+50;      % (kg)     Total mass
    mg    = m*9.809;    % (N)      Gravity
    rho   = 1.2;        % (kg/m^3) Air density at 20 C
    cdA   = 0.037;      % (m^2)    Drag coefficient times area
    cCor  = 120*180/pi; % (N/rad)  Tire cornering stiffness
    c1    = 3.4e-4;     % (kg/m)   Wheel drag quadratic coefficient
    c2    = 0.051;      % (N)      Wheel drag constant term
    r     = 0.13;       % (ohm)    Motor resistance
    u     = 12;         % (V)      Motor voltage
    cEddy = 0.03;       % (kg/s)   Eddy current loss constant
    regen = 'off';      %          State of motor re-gen function. 'on' for
                        %            re-gen on with maximum power pMax. 'off'
                        %            for completely off. Number r (0 < r < 1)
                        %            for re-gen on with maximum power r*pMax.

----------
Restraints
----------
    vAvg = 6.7;               % (m/s) Target average velocity
    tMax = track.s(end)/vAvg; % (s)   Maximum time
    pMax = 12*u;              % (W)   Maximum power to/from motor
    
    function [C, CEQ] = Constr(V)
        global tMax pMax

        C = [TimeTotal(V) - tMax; ...
             max(abs(Power(V))) - pMax];
        CEQ = [];
    end

--------------------
Optimization Options
--------------------
    options = optimoptions('fmincon', ...
                           'MaxFunctionEvaluations', 3e4, ...
                           'MaxIterations', 3e1, ...
                           'ObjectiveLimit', 0, ...
                           'Display', 'off');
                       
--------
Restarts
--------
    prevSol = load('1906192009');
    vPrev   = prevSol.v([3 6:9]);

    nRst   = 10;            % Number of random restarts
    v0     = cell(1, nRst); % Starting points
 
    % Generate random starting points
    if mod(rst, 2) == 1
        vTmp = vPrev{(rst+1)/2};
    else
        vPrevShift = circshift(vPrev, -1);
        vTmp = (vPrev{rst/2} + vPrevShift{rst/2})/2;
    end

    vRand = cumsum(0.005*rand(1, n));
    vRand = vRand - (0:n-1)/(n-1) .* vRand(end);
    vRand = circshift(vRand, randi(n));

    v0{rst} = vTmp + vRand;

    % Make starting points satisfy constraints
    if TimeTotal(v0{rst}) > tMax
        v0{rst} = TimeTotal(v0{rst})/tMax * v0{rst};
    end

==========
1906201230
==========

  Re-gen off.
  Using the last run's best three results to generate starting points.
  All restarts returned "local minimum possible" within < 30 iterations.
Restarts 3, 6, and 29 gave total energies under 5520 J, the best being restart 
3 at only 5504.9 J. The three velocity profiles are visibly almost
indistinguishable.
  The three best results will be used to generate starting points for the next
optimization attempt.

---------
Constants
---------
    mu    = 0.0015;     %          Rolling resistance coefficient
    m     = 21+50;      % (kg)     Total mass
    mg    = m*9.809;    % (N)      Gravity
    rho   = 1.2;        % (kg/m^3) Air density at 20 C
    cdA   = 0.037;      % (m^2)    Drag coefficient times area
    cCor  = 120*180/pi; % (N/rad)  Tire cornering stiffness
    c1    = 3.4e-4;     % (kg/m)   Wheel drag quadratic coefficient
    c2    = 0.051;      % (N)      Wheel drag constant term
    r     = 0.13;       % (ohm)    Motor resistance
    u     = 12;         % (V)      Motor voltage
    cEddy = 0.03;       % (kg/s)   Eddy current loss constant
    regen = 'off';      %          State of motor re-gen function. 'on' for
                        %            re-gen on with maximum power pMax. 'off'
                        %            for completely off. Number r (0 < r < 1)
                        %            for re-gen on with maximum power r*pMax.

----------
Restraints
----------
    vAvg = 6.7;               % (m/s) Target average velocity
    tMax = track.s(end)/vAvg; % (s)   Maximum time
    pMax = 12*u;              % (W)   Maximum power to/from motor
    
    function [C, CEQ] = Constr(V)
        global tMax pMax

        C = [TimeTotal(V) - tMax; ...
             max(abs(Power(V))) - pMax];
        CEQ = [];
    end

--------------------
Optimization Options
--------------------
    options = optimoptions('fmincon', ...
                           'MaxFunctionEvaluations', 3e4, ...
                           'MaxIterations', 3e1, ...
                           'ObjectiveLimit', 0, ...
                           'Display', 'off');
                       
--------
Restarts
--------
    prevSol = load('1906201139');
    vPrev   = cell2mat(prevSol.v(4:6)');

    nRst   = 30;            % Number of random restarts
    v0     = cell(1, nRst); % Starting points
 
    % Generate random starting points
    while 1
        a = rand;
        b = rand;

        if a+b < 1
            break
        end
    end

    c = 1-a-b;

    vTmp = [a b c] * vPrev;

    vRand = cumsum(0.003*rand(1, n));
    vRand = vRand - (0:n-1)/(n-1) .* vRand(end);
    vRand = circshift(vRand, randi(n));

    v0{rst} = vTmp + vRand;

    % Make starting points satisfy constraints
    if TimeTotal(v0{rst}) > tMax
        v0{rst} = TimeTotal(v0{rst})/tMax * v0{rst};
    end

==========
1906201258
==========

  Re-gen off.
  Using the last run's best three results to generate starting points.
  All restarts returned "local minimum possible" within < 30 iterations. Eight 
restarts resulted in total energies under 5500 J. The best result was restart
23 which gave 5495.8 J (803 mi/kWh). It can be conjectured that this 
approximates the global minimum to within 10 J. The corresponding average power 
output is 18.7 W.
  The result of restart 23 suggests to maintain a higher speed going uphill 
than downhill, using power between 15 and 40 W, so that during the downhill the 
throttle can be kept mostly at zero. Overall, the speed is between 6.9 m/s and
6.5 m/s.

---------
Constants
---------
    mu    = 0.0015;     %          Rolling resistance coefficient
    m     = 21+50;      % (kg)     Total mass
    mg    = m*9.809;    % (N)      Gravity
    rho   = 1.2;        % (kg/m^3) Air density at 20 C
    cdA   = 0.037;      % (m^2)    Drag coefficient times area
    cCor  = 120*180/pi; % (N/rad)  Tire cornering stiffness
    c1    = 3.4e-4;     % (kg/m)   Wheel drag quadratic coefficient
    c2    = 0.051;      % (N)      Wheel drag constant term
    r     = 0.13;       % (ohm)    Motor resistance
    u     = 12;         % (V)      Motor voltage
    cEddy = 0.03;       % (kg/s)   Eddy current loss constant
    regen = 'off';      %          State of motor re-gen function. 'on' for
                        %            re-gen on with maximum power pMax. 'off'
                        %            for completely off. Number r (0 < r < 1)
                        %            for re-gen on with maximum power r*pMax.

----------
Restraints
----------
    vAvg = 6.7;               % (m/s) Target average velocity
    tMax = track.s(end)/vAvg; % (s)   Maximum time
    pMax = 12*u;              % (W)   Maximum power to/from motor
    
    function [C, CEQ] = Constr(V)
        global tMax pMax

        C = [TimeTotal(V) - tMax; ...
             max(abs(Power(V))) - pMax];
        CEQ = [];
    end

--------------------
Optimization Options
--------------------
    options = optimoptions('fmincon', ...
                           'MaxFunctionEvaluations', 3e4, ...
                           'MaxIterations', 3e1, ...
                           'ObjectiveLimit', 0, ...
                           'Display', 'off');
                       
--------
Restarts
--------
    prevSol = load('1906201230');
    vPrev   = cell2mat(prevSol.v([3 6 29])');

    nRst   = 30;            % Number of random restarts
    v0     = cell(1, nRst); % Starting points
 
    % Generate random starting points
    while 1
        a = rand;
        b = rand;

        if a+b < 1
            break
        end
    end

    c = 1-a-b;

    vTmp = [a b c] * vPrev;

    vRand = cumsum(0.001*rand(1, n));
    vRand = vRand - (0:n-1)/(n-1) .* vRand(end);
    vRand = circshift(vRand, randi(n));

    v0{rst} = vTmp + vRand;

    % Make starting points satisfy constraints
    if TimeTotal(v0{rst}) > tMax
        v0{rst} = TimeTotal(v0{rst})/tMax * v0{rst};
    end