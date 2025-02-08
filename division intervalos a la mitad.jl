using Plots, Printf

gr()  # Activa el backend gráfico en VS Code

# Definir la función f(x)
function f(x)
    return 10 + x^3 - 2*x - 5 * exp(x)
end

# Implementación corregida del método de División de Intervalos por la Mitad
function division_intervalos_final(a, b, epsilon)
    xm = (a + b) / 2  # Punto medio del intervalo
    L = b - a  # Longitud del intervalo
    iteraciones = 0  # Contador de iteraciones

    println("Iteración |        a        |        b        |      L")
    println("---------------------------------------------------------")

    anim = @animate for _ in 1:100  # Máximo de 100 iteraciones para evitar bucle infinito
        if abs(L) <= epsilon
            break  # Detenemos si ya alcanzamos la tolerancia
        end

        iteraciones += 1  # Contamos la iteración
        
        x1 = a + L / 4  # Punto 1 en el primer cuarto
        x2 = b - L / 4  # Punto 2 en el último cuarto

        f_x1 = f(x1)
        f_x2 = f(x2)
        f_xm = f(xm)

        # 🔹 Corrección clave: Forzar la búsqueda en la dirección del mínimo global
        if f_x1 < f_xm && x1 > xm  # Buscar en la derecha si x1 es mejor y mayor
            a = xm
            xm = x1
        elseif f_x2 < f_xm && x2 > xm  # Buscar en la derecha si x2 es mejor y mayor
            a = xm
            xm = x2
        elseif f_x1 < f_xm  # Buscar en la izquierda si x1 es menor
            b = xm
            xm = x1
        elseif f_x2 < f_xm  # Buscar en la izquierda si x2 es menor
            b = xm
            xm = x2
        else  # Si no hay mejor opción, reducimos simétricamente
            a = x1
            b = x2
        end

        L = b - a  # Actualizamos la longitud del intervalo

        @printf "%8d | %12.6f | %12.6f | %12.6f\n" iteraciones a b L

        # 🔹 Graficamos la función en cada iteración
        x_vals = range(-5, stop=5, length=1000)
        y_vals = f.(x_vals)

        p = plot(x_vals, y_vals, label="f(x)", linewidth=2, color=:blue)
        scatter!([a, b], [f(a), f(b)], label="Intervalo actual", color=:red, markersize=6)
        title!("Iteración $iteraciones - Intervalo: ($a, $b)")
    end

    gif(anim, "division_intervalos_final.gif", fps=5)  # Crear animación

    return (a, b, iteraciones)
end

# Parámetros del problema
a = -5
b = 5
epsilon = 0.0001  # Precisión dada en el enunciado

# Llamamos a la función con animación
resultado_a, resultado_b, iteraciones = division_intervalos_final(a, b, epsilon)

# Imprimir el resultado final
println("\nEl mínimo se encuentra en el intervalo: (", resultado_a, ", ", resultado_b, ")")
println("Número de iteraciones realizadas: ", iteraciones)
