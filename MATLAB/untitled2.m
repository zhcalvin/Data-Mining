x = [-0.3,-0.2,1.9,0.35,0.25,0.15,2.5,1.6,1.8,0.6]
y = [-0.1,-0.5,1,-0.5,-1.2,-2.3,-1.7,1.15,0.3,0]

mx = mean(x)
my = mean(y)

sx = std(x)
sy = std(y)

vx = sx * sx
vy = sy * sy

vxy = 0
for i = 1:10
    vxy = vxy + (x(i) - mx) * (y(i) - my);
end

vxy = vxy / 10