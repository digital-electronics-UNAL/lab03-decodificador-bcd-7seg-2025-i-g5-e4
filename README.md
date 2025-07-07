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
#### Descripción

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




