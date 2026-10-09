% L0125105_Lazuardi Akbar Imani
x = linspace(-2, 2);
f = @(x) exp(x) + 2*x - 3;
y = f(x);
plot(x, y)
line([-2, 2], [0, 0], 'color', 'k') 
line([0, 0], [-5, 5], 'color', 'k') 
gtext('y = e^x + 2x - 3')
gtext('Akar')