using Printf

# Definir la función f(x)
function f(x)
    return 10 + x^3 - 2*x - 5 * exp(x)
end

# Generar los números de Fibonacci hasta el n-ésimo término
function fibonacci(n)
    fib_seq = [1, 1]  # Empezamos con F1 = 1, F2 = 1
    for i in 3:n
        push!(fib_seq, fib_seq[i-1] + fib_seq[i-2])  # Generamos los números de Fibonacci
    end
    return fib_seq
end

# Implementación del método de búsqueda de Fibonacci
function busqueda_fibonacci(a, b, n)
    fib_seq = fibonacci(n + 1)  # Generamos hasta F(n+1) para evitar índice 0
    k = 2
    L = b - a  # Longitud inicial del intervalo

    iteraciones = 0

    println("Iteración |        a        |        b        |      L")
    println("---------------------------------------------------------")

    while k ≤ n
        iteraciones += 1

        # Corrección del índice: n-k+1 en lugar de n-k
        L_k = (fib_seq[n-k+1] / fib_seq[n+1]) * L

        # Definir los puntos de evaluación
        x1 = a + L_k
        x2 = b - L_k

        # Evaluación de la función
        if f(x1) > f(x2)
            a = x1
        else
            b = x2
        end

        # Actualizar k y longitud del intervalo
        k += 1
        L = b - a

        @printf "%8d | %12.6f | %12.6f | %12.6f\n" iteraciones a b L
    end

    return (a, b, iteraciones)
end

# Parámetros del problema
a = -5
b = 5
n = 20  # Número de iteraciones basado en Fibonacci

# Llamamos a la función
resultado_a, resultado_b, iteraciones = busqueda_fibonacci(a, b, n)

# Imprimir el resultado final
println("\nEl mínimo se encuentra en el intervalo: (", resultado_a, ", ", resultado_b, ")")
println("Número de iteraciones realizadas: ", iteraciones)
