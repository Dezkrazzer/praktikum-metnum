% L0125105_Lazuardi Akbar Imani
x = linspace(-2, 3);
f = @(x) log10(x + 3) + 1.5*x - 2.5;
y = f(x);
plot(x, y)
line([-2, 3], [0, 0], 'color', 'k') 
line([0, 0], [-5, 5], 'color', 'k') 
gtext('y = log10(x+3) + 1.5x - 2.5')
gtext('Akar')