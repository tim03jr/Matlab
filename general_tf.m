
%Tests the response of some transfer function.
%Just comment out the old transfer functions and enter your new one!


clf;
s = tf('s');

%%%%%%%%%%%%%%%%%GAIN%%%%%%%%%%%%%%%%%%%
K = [3 0.1 6 10];

%%%%%%%%%%%%%%%%%FEEDBACK%%%%%%%%%%%%%%%
fdbck = 1;

%%%%%%%%%%%%%%%%%TRANSFER FUNCTION%%%%%%
%G = (s-2)/((s+1)*(s^2 + 6*s + 25));
%G = 1/((s)*(s+1));
G = (s+2)/(s^2-3*s);


%%%%%%%%%%%%%%%%%STEP RESPONSE%%%%%%%%%
% figure(1);
% hold;
% for n = 1:5
% step(K(n)*G,0:0.001:10);
% end
% hold;

%%%%%%%%%%%%%%%%STEP RESPONSE W/ FEEDBACK
figure(2);
hold;
for n = 1:length(K)
step(feedback(K(n)*G,fdbck),0:0.001:20);
axis([0,20,-10,10]);
%legend('Gain = 10');
end
hold;

%%%%%%%%%%%%%%%%STEP RESPONSE W/ NO FEEDBACK AND NO GAIN
%step(G,0:0.001:10)

%%%%%%%%%%%%%%%STEP RESPONSE W/ FEEDBACK AND NO GAIN
%step(feedback(G,fdbck),0:0.001:10)


%Finds the roots of a second order system who's constants are a
%function of K.
for n = 1:length(K)
p = [1 (K(n)-3) 2*K(n)];
roots(p)
end

