Seguidor de Línea

Autores

Daniel Camilo Amaya Rodríguez - 2420191010

Oscar Rojas Caicedo - 24020191009

Descripción del Proyecto

Este repositorio contiene el código de un seguidor de línea desarrollado en lenguaje ensamblador, utilizando MPLAB 5.40 y el compilador PIC-AS 2.31.

El seguidor de línea se basa en 5 sensores y 7 salidas, distribuidas de la siguiente manera:

Motores:

2 motores giran en el sentido de las manecillas del reloj.

2 motores giran en sentido contrario a las manecillas del reloj.

LEDs indicadores:

Giro a la izquierda.

Giro a la derecha.

Detención.

Lógica de Funcionamiento

Para el desarrollo de este sistema:

Se diseñó una tabla de verdad con todas las combinaciones posibles de los sensores.

Se aplicó mapas de Karnaugh para simplificar la lógica de control.

Se programaron las ecuaciones simplificadas en lenguaje ensamblador.

Implementación en Código

Se declararon los puertos de entrada y salida en el microcontrolador.

Se registraron las entradas provenientes de los sensores.

Se aplicaron las operaciones lógicas derivadas de los mapas de Karnaugh.

Se definieron las salidas correspondientes para controlar motores y LEDs.

Simulación y Pruebas

El código fue verificado mediante Proteus, utilizando el archivo .hex generado en MPLAB.
Se validó el correcto funcionamiento para cada combinación de la tabla de verdad, asegurando la precisión del comportamiento del seguidor de línea.

