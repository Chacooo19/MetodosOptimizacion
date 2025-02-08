using Plots, Printf

gr()  # Activa el backend gráfico en VS Code

# Definir la función f(x)
function f(x)
    return 10 + x^3 - 2*x - 5 * exp(x)
end

# Implementación de la Búsqueda Exhaustiva con contador de iteraciones
function busqueda_exhaustiva(a, b, n)
    Δx = (b - a) / n  # Tamaño del paso

    # Inicialización de los puntos
    x1 = a
    x2 = x1 + Δx
    x3 = x2 + Δx

    min_x = x2  # Inicializar con el primer valor interno
    min_f = f(x2)
    iteraciones = 0  # Contador de iteraciones

    while x3 < b  # Evitamos que x3 llegue exactamente a b
        iteraciones += 1  # Contamos la iteración
        
        if f(x2) < min_f
            min_x = x2
            min_f = f(x2)
        end
        
        # Desplazamos los valores
        x1 = x2
        x2 = x3
        x3 = x2 + Δx
    end

    return min_x, min_f, iteraciones  # Retornar el mínimo encontrado y el número de iteraciones
end

# Valores fijos de a y b
a = -5
b = 5

# Pedir el número de divisiones al usuario
println("Ingrese el número de divisiones n:")
n = parse(Int, readline())

# Llamamos a la función
min_x, min_f, iteraciones = busqueda_exhaustiva(a, b, n)

# Imprimir el resultado
@printf "El mínimo se encuentra en x = %.6f con f(x) = %.6f\n" min_x min_f
println("Número de iteraciones realizadas: ", iteraciones)

# Graficar la función
x_vals = range(a, stop=b, length=1000)  # 1000 puntos en el intervalo
y_vals = f.(x_vals)  # Evaluamos la función

# Crear la gráfica
p = plot(x_vals, y_vals, label="f(x) = 10 + x^3 - 2x - 5e^x", linewidth=2, color=:blue)
scatter!([min_x], [min_f], label="Mínimo en x = $(round(min_x, digits=6))", color=:red, markersize=6)
hline!([0], linestyle=:dash, color=:black, label="")
vline!([0], linestyle=:dash, color=:black, label="")

xlabel!("x")
ylabel!("f(x)")
title!("Gráfica de la función f(x)")

display(p)  # Mostrar la gráfica en VS Code
