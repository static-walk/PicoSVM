function _init()
 -- points
 -- belong to [-64,63]x[-64,63]
 x={
 {-10,-40},
 {-10,-10},
 {-10,10},
 {10,-50},
 {5,5},
 {40,50},
 {30,30},
 {10,60}
 }
 -- labels
 y={
 -1,
 -1,
 -1,
 -1,
 1,
 1,
 1,
 1
 }
 -- svm parameters
 w={rnd(),rnd()}
 rate=1
 epoch=1
end

function dot(a,b)
 return a[1]*b[1]+a[2]*b[2]
end

function _update()
 for i=1,#x do
  if y[i]*dot(x[i],w)<1 then
   for j=1,2 do
    w[j]+=rate*(x[i][j]*y[i]-2*w[j]/epoch)
   end
  else
   for j=1,2 do
    w[j]+=rate*(-2*w[j]/epoch)
   end
  end
 end
 epoch+=1
end

function draw_axes()
 for i=0,127 do
  pset(i,64,6)
  pset(64,i,6)
 end
end

function draw_point(x1,x2,c)
 pset(64+x1,64-x2,c)
end

function draw_line(w1,w2)
 if w1!=0 then
  for y=-64,63 do
   draw_point(-w[2]/w[1]*y,y,14)
  end
 elseif w2!=0 then
  for x=-64,63 do
   draw_point(x,-w[1]/w[2]*x,14)
  end
 end
end

function _draw()
 cls(7)
 draw_axes()
 for i=1,#x do
  if y[i]==1 then
   draw_point(x[i][1],x[i][2],11)
  else
   draw_point(x[i][1],x[i][2],8)
  end
 end
 draw_line(w[1],w[2])
 color(2)
 print("epoch: "..epoch)
 print("w1: "..w[1])
 print("w2: "..w[2])
end
