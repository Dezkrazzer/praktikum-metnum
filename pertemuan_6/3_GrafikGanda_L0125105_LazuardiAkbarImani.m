% L0125105_Lazuardi Akbar Imani
x = linspace(-2, 3);
f1 = @(x) log10(x + 3);
f2 = @(x) -1.5*x + 2.5;
y1 = f1(x);
y2 = f2(x);
plot(x, y1, x, y2)
line([-2, 3], [0, 0], 'color', 'k') 
line([0, 0], [-5, 5], 'color', 'k') 
gtext('y_1 = log10(x+3)')
gtext('y_2 = -1.5x + 2.5')
gtext('Akar')