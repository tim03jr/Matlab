

s = tf('s');

G = (s+10)/(s^3 + 6*s +1);

bode(G)