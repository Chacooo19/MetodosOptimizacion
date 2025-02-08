using Printf

# Definir la función f(x)
function f(x)
    return 10 + x^3 - 2*x - 5 * exp(x)
end

# Implementación del método de la Sección Dorada
function seccion_dorada(a, b, epsilon)
    φ = 0.618  # Proporción áurea
    aw = 0
    bw = 1
    Lw = 1  # Longitud normalizada del intervalo

    iteraciones = 0

    println("Iteración |       aw        |       bw        |      Lw")
    println("----------------------------------------------------------")

    while Lw > epsilon / (b - a)
        iteraciones += 1

        # Calcular los nuevos puntos de evaluación
        w1 = aw + φ * Lw
        w2 = bw - φ * Lw

        # Convertir los valores normalizados a escala real
        x1 = a + w1 * (b - a)
        x2 = a + w2 * (b - a)

        # Evaluamos la función en esos puntos
        if f(x1) < f(x2)
            aw = w2  # Actualizar aw hacia la derecha
        else
            bw = w1  # Actualizar bw hacia la izquierda
        end

        Lw = bw - aw  # Actualizar la longitud del intervalo

        @printf "%8d | %12.6f | %12.6f | %12.6f\n" iteraciones aw bw Lw
    end

    # Convertir el intervalo normalizado de regreso a la escala real
    a_opt = a + aw * (b - a)
    b_opt = a + bw * (b - a)

    return (a_opt, b_opt, iteraciones)
end

# Parámetros del problema
a = -5
b = 5
epsilon = 0.0001  # Precisión dada en el enunciado

# Llamamos a la función
resultado_a, resultado_b, iteraciones = seccion_dorada(a, b, epsilon)

# Imprimir el resultado final
println("\nEl mínimo se encuentra en el intervalo: (", resultado_a, ", ", resultado_b, ")")
println("Número de iteraciones realizadas (seccion_dorada): ", iteraciones)
