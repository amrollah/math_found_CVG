function [p_points, q_points] = get_points(img1)

p_points = []; 
q_points = [];
fig_handler{1} = figure;  imshow(img1); title('Select control points(P)')
fig_handler{2} = figure;  imshow(img1); title('Select deformed position of control points(q)')
curr_fig = 1;

% correspondance points
while(true)  
  figure(fig_handler{curr_fig}); hold on;
  [x, y, button] = ginput(1);
  
  if(button ~= 1)
      break;
  end
    if (curr_fig == 1)
        plot(x,y,'.b', 'MarkerSize',20);
        p_points = [p_points, [x y]'];
        curr_fig = 2;
    else
        plot(x,y,'.b', 'MarkerSize',20);
        q_points = [q_points, [x y]'];
        curr_fig = 1;
    end        
end
end