# Seguidor-de-linea
Daniel Camilo Amaya Rodriguez --- 2420191010
Oscar Rojas Caicedo  ------------ 24020191009
Este  Repositorio es para un proyecto de un seguidor de linea el cual se realizó en lenguaje ensamblador , en la versión de Mplab 5.40
y  con el compilador Pic-as en la versión 2.31.
el  seguidor de linea consiste en 5 sensores  y 7 salidas las cuales son los dos motores que van con el sentido de las manecillas del reloj  y otros 2 motores 
que van en contra de las manecillas del reloj , con 3 leds uno para el giro a la izquierda, el otro para giro a la derecha y  el de detenerse.
Se trabajo haciendo una tabla de verdad en la cual se desarrollaron los karnaughs para asi simplificar las opciones  de combinación .

En el codigo  lo que se hizo fue declarar en que puertos se iba a trabajar las entradas y salidas, luego  se registro  las entradas , se opero los registros de las 
entradas con las funciones que se sacaron de los karnaughs, para terminar indicando en que salidas iban cada operación de karnough.

Ya teniendo el codigo se comprobó su funcionamiento en el proteus  con el archivo .hex que genera mplab, este proceso se desarrollo paso por paso cumpliendo
cada combinación de la tabla de verdad y de esta manera se comprobó el funcionamiento del codigo.

