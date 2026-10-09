% L0125105_Lazuardi Akbar Imani
x = linspace(-2, 2);
f1 = @(x) exp(x);
f2 = @(x) -2*x + 3;
y1 = f1(x);
y2 = f2(x);
plot(x, y1, x, y2)
line([-2, 2], [0, 0], 'color', 'k') 
line([0, 0], [-5, 5], 'color', 'k') 
gtext('y_1 = e^x')
gtext('y_2 = -2x + 3')
gtext('Akar')