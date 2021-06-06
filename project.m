clc;
v = VideoReader('video4.mp4');  % Function for reading video file
px_m = 1000; %how_many_px_equal_to_1_meter
frame1st = 1;
frame2nd = 30;
see_frame = 30; % see any frame in blackwhite

speed=calculatespeed(v,frame1st, frame2nd, see_frame);

disp(['speed is: ' num2str(speed) ' pixels per sec']);
disp(['speed is: ' num2str(speed/px_m) ' meters per sec']);


﻿function speed = calculatespeed(obj,frame1stframe2nd, see_frame)

%this loop is to get two frames from video
i=1;
while hasFrame(obj)     
  this_frame = readFrame(obj);
  if(i==frame1st)
    frame1=this_frame;
  end
  if (i==frame2nd)
    frame2=this_frame;
  end
  if (i==see_frame)
    imshow(im2bw(this_frame,0.7));
    [rows,cols] = size(this_frame)
  end
  i=i+1;
end

%convert frames/images to black white
bwframe1 = im2bw(frame1,0.7);
bwframe2=im2bw(frame2,0.7);

%get left most pixels
[x1,y1] = left_most_pixel(bwframe1);
[x2,y2] = left_most_pixel(bwframe2);
distance= sqrt((x2-x1)^2 + (y2-y1)^2);

%video is of 30 fps (frames per second)
% so calculating time from frames. for example 30 frames = 1 sec or 15 frames = 0.5 sec
frames = abs(frame2nd - frame1st);
time =  frames * 1/30;
speed = distance/time;
end
﻿function (x,y) = left_most_pixel(img)

[rows,cols] = size(img);

min_col = 999999999999999;
min_row = 999999999999999;
for row=1:rows
    for col=1:cols
        if img(row,col) == 1 && col < min_col
            min_col = col;
            min_row = row;
        end
    end
end

x = min_row;
y = min_col;
end
