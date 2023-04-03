/*
Los bebedores que no les gusta la colombiana.
Solucion del punto 1 */

select nombre_bebedor, nombre_bebida from gustos inner join bebida on gustos.codigo_bebida = bebida.codigo_bebida
inner join bebedor on gustos.cedula = bebedor.cedula where bebida.nombre_bebida != 'Colombiana';

/*
Las fuentes de soda que no son frecuentadas por Andres Camilo Restrepo.
Solucion del punto 2*/

SELECT *
FROM tienda
WHERE codigo_tienda NOT IN (SELECT codigo_tienda FROM cliente_frecuentes WHERE cedula = (SELECT cedula FROM bebedor WHERE bebedor.nombre_bebedor = 'Andres Camilo Restrepo'));

/*
Los bebedores que les gusta al menos una bebida y que frecuentan al menos una tienda.
Solucion del punto 3*/

SELECT *
FROM bebedor
WHERE bebedor.cedula IN (SELECT cedula FROM gustos)
  AND bebedor.cedula IN (SELECT cedula FROM cliente_frecuentes);

/*
Para cada bebedor, las bebidas que no le gustan.
Solucion del punto 4 */

SELECT nombre_bebedor, nombre_bebida
FROM bebedor
  CROSS JOIN bebida
WHERE bebedor.cedula NOT IN (SELECT cedula FROM cliente_frecuentes WHERE codigo_bebida = bebida.codigo_bebida);

/*Solucion del punto 5*/

SELECT cedula
FROM cliente_frecuentes
WHERE cliente_frecuentes.codigo_tienda IN (SELECT codigo_tienda FROM cliente_frecuentes WHERE cedula = (SELECT cedula FROM bebedor WHERE bebedor.nombre_bebedor = 'Luis Perez'))
GROUP BY cliente_frecuentes.cedula
HAVING COUNT(*) = (SELECT COUNT(*) FROM cliente_frecuentes WHERE cedula = (SELECT cedula FROM bebedor WHERE bebedor.nombre_bebedor = 'Luis Perez'));

/*Solucion del punto 6*/

SELECT b.cedula, b.nombre_bebedor, t1.nombre_tienda
FROM bebedor b 
JOIN gustos g ON b.cedula = g.cedula 
JOIN ventas v ON g.codigo_bebida = v.codigo_bebida
JOIN cliente_frecuentes f ON b.cedula = f.cedula OR v.codigo_tienda = f.codigo_tienda
JOIN tienda t1 ON f.codigo_tienda = t1.codigo_tienda 
GROUP BY b.cedula, b.nombre_bebedor, t1.nombre_tienda 
HAVING COUNT(DISTINCT v.codigo_tienda) = 1
AND COUNT(DISTINCT v.codigo_bebida) = 1
AND COUNT(DISTINCT f.codigo_tienda) = 1
