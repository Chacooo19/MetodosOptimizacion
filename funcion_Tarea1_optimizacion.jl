using Plots

# Definir la función f(x)
function f(x)
    return 10 + x^3 - 2*x - 5 * exp(x)
end

# Definir el rango de valores para graficar
x = range(-5, 5, length=1000)  # 1000 puntos entre -5 y 5
y = f.(x)  # Evaluar la función en cada punto del rango

# Encontrar el mínimo dentro del intervalo
min_idx = argmin(y)  # Índice donde f(x) es mínimo
x_min = x[min_idx]   # Valor de x en el mínimo
y_min = y[min_idx]   # Valor de f(x) en el mínimo

p = plot(x, y, label="f(x) = 10 + x^3 - 2x - 5e^x", color=:blue, linewidth=2)
scatter!([x_min], [y_min], label="Mínimo en ($x_min, $y_min)", color=:red, markersize=6)
hline!([0], linestyle=:dash, color=:black, label="")
vline!([0], linestyle=:dash, color=:black, label="")

xlabel!("x")
ylabel!("f(x)")
title!("Gráfica de la función f(x)")

display(p)  # 🔹 Muestra la gráfica manualmente

