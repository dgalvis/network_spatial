%% Setup
clear;clc;
%% Choose the Excitable Region
% Note
%r1(i) < x < r2(i) for i = 1...N - have excitability G(1)
% otherwise excitability G(2)
% See next section for G

% Example 1 (1 ball )
%r1 = 0;
%r2 = 1;

% Example 2 (2 ball - close)
%r1 = [0.0,0.8];
%r2 = [0.5,1.3];

% Example 2 (2 ball  - far)
r1 = [0.0,9.5];
r2 = [0.5,10];

%% Choose other parameters
I = 0.21; % drive level
G = [2, 1]; % excitability of pop1 and pop2
D = 0.1; % diffusion coefficient



%% PDE Domain
x = linspace(0, 10, 1000);
t = linspace(0, 200, 1001);
Glist = zeros(size(x));
for i = 1:length(x)
    Glist(i) = Gfun(x(i), r1, r2, G);
end
figure();
plot(x, Glist, 'linewidth', 2);
ylabel('G');
xlabel('x');

%% PDE parameterisation
pars.a = 0.7;
pars.b = 0.8;
pars.tau = 0.08;
pars.D = D;
pars.I = I;
pars.G = @(x)Gfun(x, r1, r2, G);
m = 0;
sol = pdepe(m,@(x,t,u,dudx)pdefun(x,t,u,dudx, pars),@icfun,@bcfun,x,t);

%% Plot
figure();hold all;
[X, T] = meshgrid(x, t);
surf(T, X, sol(:,:,1));
shading interp;
xlabel('time');
ylabel('space');
colorbar;caxis([-3,3]);
%% Functions
function Gout = Gfun(x, r1, r2, G)
    Gout = G(2);
    for i = 1:length(r1)
        if x > r1(i) && x < r2(i)
            Gout = G(1);
        end
    end

end
function [c,f,s] = pdefun(x,t,u,dudx, pars)

tau = pars.tau;
D = pars.D;
a = pars.a;
b = pars.b;
G = pars.G(x);
I = pars.I;

V = u(1);
W = u(2);

c = [1;1];
f = [D;0] .* dudx;
s = [V - V.^3/3 - W + G * I; tau *(V + a - b * W)];
end
function u0 = icfun(x)
u0 = [-1;0];
end
function [pl,ql,pr,qr] = bcfun(xl,ul,xr,ur,t)
pl = [0; 0];
ql = [1; 1];
pr = [0; 0];
qr = [1; 1];
end