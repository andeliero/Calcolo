
function v = interLagrange(x,y,u)
% interpolazione polinomiale
% v = interLagrange(x,y,u) calcola v(j) = P(u(j)) ove P è
% polinomio di grado d = length(x)-1 con P(x(i)) = y(i).
% Utilizza la rappresentazione di Lagrange
n = length(x);
v = zeros(size(u));
for k = 1:n
    w = ones(size(u));
    for j = [1:k-1 k+1:n]
        w = (u-x(j))./(x(k)-x(j)).*w;
    end
v = v + w*y(k);
end
