[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-2e0aaae1b6195c2367325f4f02e2d04e9abb55f0b24a779b69b11b9e10269abc.svg)](https://classroom.github.com/online_ide?assignment_repo_id=19699376&assignment_repo_type=AssignmentRepo)
# Lab03: Decodificador BCD a 7segmentos


## Integrantes 
- [José Luis Pulido Fonseca](https://github.com/jpulidof)  
- [Nicolle Stefannie Ospina Pérez](https://github.com/stefannie4)
- [Ana María Orozco Reyes](https://github.com/anaor17)

## Informe

Indice:

1. [Diseño implementado](#1-diseño-implementado)
2. [Simulaciones](#2-descripción)
3. [Implementación](#3-diagramas)
4. [Simulaciones](#4-simulaciones)
5. [Implementación](#5-implementación)
6. [Conclusiones](#conclusiones)

## 1. Diseño implementado
### Decodificador BCD a 7 segmentos
#### Descripción estrcutural
El sistema completo está compuesto por dos módulos:
- BCD: Convierte un número binario de 9 bits (valor entre 0 y 511) en tres dígitos BCD de 4 bits cada uno.
- BCDtoSSeg: Convierte un valor BCD de 4 bits (0–15) al código correspondiente para controlar un display de 7 segmentos.
Las salidas BCD0, BCD1 y BCD2 del módulo BCD se conectan como entradas (una a la vez) al módulo BCDtoSSeg para mostrarlas en un display (mediante multiplexación).
#### Descripción comportamental
Este módulo se encarga de traducir un dígito BCD (4 bits) en una señal de control para un display de 7 segmentos común anodo. El comportamiento se describe con una estructura case.

El módulo BCD realiza la conversión de binario puro a BCD usando el algoritmo de doble desplazamiento y suma de 3, también conocido como “Double Dabble”.
- Se inicializa un registro de desplazamiento (shift_reg) de 21 bits y se cargan los 9 bits binarios en las posiciones más bajas.

- Se repite 9 veces:
Si las secciones que representan centenas, decenas o unidades son mayores o iguales a 5, se les suma 3 (requisito del algoritmo).
Se realiza un desplazamiento a la izquierda de todo el registro.

-Finalmente, se extraen los valores BCD desde las posiciones correspondientes:
BCD0 = shift_reg[11:8]
BCD1 = shift_reg[15:12]
BCD2 = shift_reg[19:16]


#### Diagramas
### Visualización Dinámica 4 Displays de 7 Segmentos
#### Descripción

#### Diagramas
### Representación decimal de números negativos
#### Descripción

#### Diagramas


## 4. Simulaciones 


## 5. Implementación
Para la descripción del convertidor BCD en FPGA, finalmente optamos por implementar el algoritmo Double Dabble en lugar del método visto en clase. La principal razón es que, aunque era la manera más rápida, al intentar pasarlo a la FPGA nos percatamos de que consumía demasiados recursos por usar operaciones complejas. El Double Dabble, en cambio, nos permitió hacer la conversión usando solo desplazamientos de bits y algunas comparaciones, lo que lo hace ideal para hardware. La implementación resultó mucho más eficiente además de que ocupa menos espacio en la FPGA, el tiempo de conversión es constante y además podemos adaptarlo fácilmente si necesitamos trabajar con números más grandes. Al final, aunque el método de clase era ideal para tener mayor entendimiento del funcionamiento práctico del BCD, para un proyecto real en FPGA el Double Dabble demostró ser la solución más práctica y eficiente

## Conclusiones
- l algoritmo Double Dabble demostró ser ideal para implementar el convertidor BCD en FPGA por su eficiencia al usar solo desplazamientos y comparaciones. Logramos un diseño que consume pocos recursos,  consistentes y es fácil de implementar posiblemente en nuestro proyecto final, además Los resultados mostraron en todas las pruebas realizadas buenos resultados, confirmando su efectividad para este tipo de aplicaciones en hardware programable.




