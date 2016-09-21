function step

t = -10:0.001:10;

y = heaviside(t);

plot(t,y.^2);

axis([-10 10 -2 2]);

