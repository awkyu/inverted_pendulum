sim('model_simulink.slx')

time = out.theta.time;
theta = out.theta.signals.values;
x_total = out.x.signals.values;

% Initialize video
myVideo = VideoWriter('invertedPendulumAnimation'); %open video file
myVideo.FrameRate = 30;  %can adjust this, 5 - 10 works well for me
open(myVideo)

%In each frame, you know the position of cart x and theta th; therefore you
%can put these code into function, e.g. function animation_pedulum(x,th)
%%Define the dimension of the cart; you can change based on the visual
%%needed.
W = 1; % cart width
H = 0.5; % cart height
wr = 0.3; % wheel radius
mr = 0.05; % mass radius; You can change these dimension
L = 0.3;
for i=1:length(time)
    th = theta(i) - pi;
    x = x_total(i);
    % Define positions of cart and two wheels
    y = wr/2+H/2; % cart vertical position
    w1x = x-.9*W/2; % Wheels position
    w1y = 0;
    w2x = x+.9*W/2-wr;
    w2y = 0;
    % pendulum position
    pendx = x + L*sin(th); % L is the length of inverted pendulum. Please define yourself
    pendy = y - L*cos(th);
    plot([-10 10],[0 0],'k','LineWidth',2), hold on
    time_txt = sprintf('Time=%0.2f seconds', time(i));
    text(0.5, 1, time_txt)
    rectangle('Position',[x-W/2,y-H/2,W,H],'Curvature',.1,'FaceColor',[1 0 0],'LineWidth',1.5); % Draw cart
    rectangle('Position',[x-.9*W/2,0,wr,wr],'Curvature',1,'FaceColor',[0 0 1],'LineWidth',1.5); % Draw wheel
    rectangle('Position',[x+.9*W/2-wr,0,wr,wr],'Curvature',1,'FaceColor',[0 0 1],'LineWidth',1.5); % Draw wheel
    plot([x pendx],[y pendy],'k','LineWidth',2); % Draw pendulum
    rectangle('Position',[pendx-mr/2,pendy-mr/2,mr,mr],'Curvature',1,'FaceColor',[0 1 0],'LineWidth',1.5);
    axis([-2 2 -1 1.5]);axis equal
    set(gcf,'Position',[100 100 1000 400])
    drawnow, hold off
    
    frame = getframe(gcf); %get frame
    writeVideo(myVideo, frame);
end
close(myVideo)