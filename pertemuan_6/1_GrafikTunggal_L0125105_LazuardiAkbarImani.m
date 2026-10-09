% L0125105_Lazuardi Akbar Imani
x = linspace(-2, 2);
f = @(x) 2*x.^3 + x.^2 + 2*x - 4;
y = f(x);
plot(x, y)
line([-2, 2], [0, 0], 'color', 'k') 
line([0, 0], [-10, 10], 'color', 'k') 
gtext('y = 2x^3 + x^2 + 2x - 4')
gtext('Akar')