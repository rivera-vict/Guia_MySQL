https://app.sqldbm.com/

--comentarios
/*comentarios*/
#comentarios

/*Relacion de 1 a 1
Relacion de 1 a muchos
Relacion de muchos a muchos*/

/*
LENGUAJE DE DEFINICION DE DATOS (DDL)
	CREATE, se usa para crear una base de datos, tabla, vistas, etc
	ALTER, se utiliza para modificar la estructura, por ejemplo añadir o borrar columnas de una tabla.
	DROP, con esta sentencia, podemos eliminar los objetos de la estructura, por ejemplo un índice o una secuencia.
	RENAME,
	TRUNCATE,
	COMMENT,

LENGUAJE DE MANIPULACION DE DATOS (DML)
	INSERT, con esta instrucción podemos insertar los valores en una base de datos.
	UPDATE, sirve para modificar los valores de uno o varios registros.
	DELETE, se utiliza para eliminar las filas de una tabla.
	MERGE,
	CALL,

DQL
	SELECT, esta sentencia se utiliza para realizar consultas sobre los datos.


LENGUAJE DE CONTROL DE DATOS (DCL)
	GRANT, permite otorgar permisos.
	REVOKE, elimina los permisos que previamente se han concedido.
*/

--Ver todos los usuarios con los privilegios
SELECT * FROM USER;

--Para ver en especifico un usuario
SHOW GRANTS FOR hugo@'localhost';

--Crear un usuario con contraseña
CREATE USER 'hugo'@'localhost' IDENTIFIED BY '1234567';
CREATE USER 'hugo'@'%' IDENTIFIED BY '1234567';

--Cambiar contraseña de 'root' en consola
ALTER USER 'root'@'localhost' IDENTIFIED BY 'newPassword';
--Eliminar la clave, dejar sin clave para ingresar
ALTER USER 'root'@'localhost' IDENTIFIED BY '';
--Cambiar contraseña de 'pma' en consola
ALTER USER 'pm'@'localhost' IDENTIFIED BY 'newPassword';
--Eliminar la clave, dejar sin clave para ingresar
ALTER USER 'pma'@'localhost' IDENTIFIED BY '';


--Los privilegios son SELECT, INSERT, UPDATE, DELETE, CREATE, DROP
--Orimera opcion. Añadiendo todos los privilegios al usuario (*.* significa a todas las bases de datos y tablas)
GRANT ALL ON *.* TO 'victor'@'localhost' WITH GRANT OPTION;
--Segundo opcion. Añadiendo permisos y privilegios al usuario
GRANT ALL PRIVILEGES ON nombre_bd.* TO 'nombre_usuario'@'localhost'	--En vez del nombre_bd, puede ser el * para decir todas las bd
--Añadiendo privilegio personalizados basicos a usuario (db.* significa a una base de datos y todas las tablas)
GRANT SELECT, INSERT, UPDATE ON db_uno.* TO 'victor'@'localhost';

--Actualizar los privelegios despues de crear
FLUSH PRIVILEGES;


--Eliminar un usuario
DROP USER hugo;

--Muestra todos los campos de la tabla, descripcion y tipo
DESCRIBE tbl_uno; --es igual que un 'show columns from tbl_uno;'
DESC tbl_uno;

--Para guardar los cambios en el archivo
COMMIT;



--Crear una base de datos / schemas
CREATE DATABASE bd_nombre;		--Primera opcion
CHARACTER SET utf8 COLLATE utf8_spanish_ci;

CREATE SCHEMA bd_nombre;		--Segunda opcion



--Muestra todas las bases de datos
SHOW DATABASES;



--Seleccionar/Abrir la base de datos
USE bd_nombre;



--Eliminar la base de datos
DROP DATABASE bd_nombre;			--Primera opcion

DROP SCHEMA bd_nombre;				--Segunda opcion

DROP DATABASE IF EXISTS bd_nombre;	--Tercera opcion



--Para sacar una copia de la base de datos - esto se hace fuera del servidor de MySQL
mysqldump -u root -p nombreBD > nuevoNombreBD.sql



--Para cargar la base de datos desde cmd o powershell
--Primer ejemplo:
	mysql -uroot -p				--Enter
	****						--Digitar la clave, Enter
	CREATE DATABASE nombre_bd;	--Enter
	USE nombre_bd;				--Enter
	SOURCE C:\\Users\\victor\\Download\\archivo.sql;	o	SOURCE C:/Users/victor/Download/archivo.sql;	--Enter
--Segundo ejemplo:
	mysql -u root -p nombreDB < nuevoNombreBD.sql



--Crear tabla
/*UNSIGNED, solo acepta valores positivos (mayor a 0),
	se escribe despues del tipo de variable y
	si ingresa informacion pero le reemplaza el valor negativo con 0 en el campo*/
--UNIQUE, solo acepta valores unicos
--ZEROFILL CHECK() Sirve para dar un rango de valores de ingreso
--CURRENT_TIMESTAMP_, Para colocar fecha actual
CREATE TABLE tbl_empleados(
	idCedula INT UNSIGNED NOT NULL,
	nombre VARCHAR(20) NOT NULL,
	apellido VARCHAR(20) NULL,
	username VARCHAR(20) NOT NULL UNIQUE,
	correoElectronico VARCHAR(30) NOT NULL UNIQUE,
	edad INT UNSIGNED NOT NULL,
	edad TINYINT UNSIGNED NOT NULL,
	peso FLOAT NULL,
	sexo CHAR(1) NOT NULL,
	comentarios TEXT NULL,
	estado BIT, --Tipo de dato boolean
	fecha DATE DEFAULT 0000-00-00 NULL,
	genero ENUM("Masculino", "Femenino") NOT NULL,
	tipo_usuario ENUM("Gratis", "Pago") DEFAULT "Gratis",
	estCivil VARCHAR(10),
	sueldo DECIMAL (10.2),
	fechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP_,
	mes_caducidad TINYING(2) ZEROFILL CHECK(mes_caducidad >= 1 AND mes_caducidad <=12),
	anho_caducidad YEAR CHECK(anho_caducidad >= 2022)
	PRIMARY KEY(id_cedula))
	ENGINE = InnoDB
	DEFAULT CHARACTER SET =utf8;

--Debajo de PRIMARY KEY, puedo asignar desde que numero se incrementara
	AUTO_INCREMENT = 100



--Crear tabla referencia con dos id de tablas distintas
CREATE TABLE tablaCero(
	id_tablaUno INT (10),
	id_tablaDos INT (10),
	fecha DATE,
	pedido VARCHAR (10)
	PRIMARY KEY (id_tablaUno, id_tablaDos)
	);
--Para agregar el foreign key a la creacion de la tabla anterior
ALTER TABLE tablaCero ADD CONSTRAINT fk_tablaCero_tablaUno FOREIGN KEY (id_tablaUno) REFERENCES tablaUno(id_tablaUno);
ALTER TABLE tablaCero ADD CONSTRAINT fk_tablaCero_tablaDos FOREIGN KEY (id_tablaDos) REFERENCES tablaDos(id_tablaDos);



CREATE TABLE tbl_genero(
	idGenero INT NOT NULL AUTO INCREMENT,
	nombreGene VARCHAR(10) NULL,
	PRIMARY KEY (idGenero))
	ENGINE = InnoDB
	DEFAULT CHARACTER SET =utf8;



CREATE TABLE tbl_estCivil(
	idestCivil INT NOT NULL AUTO INCREMENT PRIMARY KEY,
	nombreEstCivil VARCHAR(10) NULL
	)
	ENGINE = InnoDB
	DEFAULT CHARACTER SET = utf8;



CREATE TABLE tbl_comments(
	id INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(50),
	user_id INT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES tbl_uno(id) ON DELETE CASCADE  
	);



--Muestra el queri de como se creo la tabla
SHOW CREATE TABLE tbl_uno;



--Muestra todas las tablas
SHOW TABLES;



--Muestra las columnas de la tabla, descripcion y tipo
SHOW COLUMNS FROM tbl_uno; --es igual que un describe tbl_uno;



--Eliminar tabla
DROP TABLE tbl_uno;				--Primera opcion

DROP TABLE IF EXISTS tbl_uno;	--Segunda opcion

--Eliminar usando la consola
mysqladmin -u usario_uno -p clave drop bd_uno;






--Insertar informacion a la tabla en todas las celdas
INSERT INTO tbl_uno VALUES ('1205959578','Victor','Rivera','115.50','Costeño','1986-04-03');
--Insertar informacion a la tabla en celdas especificas
INSERT INTO tbl_uno(nombre,apellido) VALUES ('Victor','Rivera');


--Cambiar el nombre de la tabla
RENAME TABLE tbl_empleados TO tbl_empl;
--Cambiar el nombre de dos tablas
RENAME TABLE tbl_dos TO tbl_two, tbl_tres TO tbl_three;

--Agregar columna a la tabla al final
ALTER TABLE tbl_uno ADD COLUMN impuestos INT NOT NULL;
--Agregar columna a la tabla donde quiero
ALTER TABLE tbl_uno ADD COLUMN nombre VARCHAR(20) AFTER id;
--Agrear una columna al inicio
ALTER TABLE tbl_uno ADD COLUMN codigo INT(3) FIRST;
--cambiar el nombre de la columna de una tabla
ALTER TABLE tbl_uno CHANGE ciudad ciudades VARCHAR(15) NOT NULL;
--Eliminar columna de la tabla
ALTER TABLE tbl_uno DROP COLUMN impuestos;
ALTER TABLE tbl_uno DROP COLUMN impuestos, DROP COLUMN color;
--Cambiar el nombre de la tabla
ALTER TABLE tbl_uno CHANGE impuestos impuesto DECIMAL (18.2) NOT NULL;
--Modificar las propiedades de la columna (El tamaño de caracteres y/o tipo)
ALTER TABLE tbl_uno ALTER COLUMN columnaUno VARCHAR(10) NULL;
ALTER TABLE tbl_uno MODIFY COLUMN columnaUno VARCHAR(1O) NULL;
--Cambiar el nombre de la tabla
ALTER TABLE tbl_uno RENAME tbl_dos;
--Eliminar una PRIMARY KEY
ALTER TABLE tbl_uno DROP PRIMARY KEY;
--Eliminar llave FORANEA
ALTER TABLE tbl_uno DROP FOREIGN KEY nombreForeign;


--Para consultas de listas de seleccion multiple 'IN'
SELECT * FROM tbl_uno WHERE id IN(1, 2, 3, 4);
SELECT * FROM tbl_uno WHERE nombre IN('Victor', 'Carlos', 'Martha');
SELECT * FROM tbl_uno WHERE nombre IN('Victor', 'Carlos', 'Martha') AND edad > 18;


--Para filtrar/consultar informacion de un rango de datos (BETWEEN y NOT BETWEEN) 
SELECT * FROM tbl_uno WHERE peso BETWEEN '100' AND '150';
SELECT * FROM tbl_uno WHERE peso BETWEEN 100 AND 150;
SELECT * FROM tbl_uno WHERE peso NOT BETWEEN '100' AND '150';
SELECT * FROM tbl_uno WHERE peso BETWEEN '100' AND '150' AND NOT nombre='Victor';
SELECT * FROM tbl_uno WHERE nombre BETWEEN 'Carlos' AND 'Victor';


/*BUSQUEDA DE PATRONES (REGEXP - NOT REGEXP)
Propiedades:*/
-- regexd '[abd]' -- Buscara en el campo nombre todos los datos que contenga una o varias caracteres abd
	SELECT * FROM tbl_uno WHERE nombre REGEXP '[abd]';
	SELECT * FROM tbl_uno WHERE mail REGEXP 'gmail';
	SELECT * FROM tbl_uno WHERE mail NOT REGEXP '[zg]'; -- Los correos que no contengan z ni g
-- regexp '[a-d]' -- Buscara en el campo nombre todos los datos que contenga una o varias caracteres en el rango de a-b
	SELECT * FROM tbl_uno WHERE nombre REGEXP '[a - d]';
	SELECT * FROM tbl_uno WHERE nombre REGEXP '[v - z]'; -- Que no tengan en el rango de v a z
-- regexp '^A' -- Buscara en el campo nombre todos los datos que empiecen con el caracter A
	SELECT * FROM tbl_uno WHERE nombre REGEXP '^A';
-- regexp 'HP$ -- Buscara en el campo nombre todos los datos que terminen con el caracter N
	SELECT * FROM tbl_uno WHERE nombre REGEXP 'N$';
	SELECT * FROM tbl_uno WHERE nombre REGEXP 'EZ$'; -- Los nombres que terminan en EZ
-- regexp 'a.e' -- Buscara en el campo nombre todos los datos que empieza con A y el tercero que sea E. El punto es la cantidad de caracteres que desconosco 
	SELECT * FROM tbl_uno WHERE nombre REGEXP 'a.e'; -- Desconozco el segundo caracter y uso el punto
	SELECT * FROM tbl_uno WHERE nombre REGEXP 'a..e'; -- Desconozco el segundo y tercer caracter y uso los puntos
-- regexp '^......$' -- Buscara en el campo nombre todos los datos que tengan seis caracteres
	SELECT * FROM tbl_uno WHERE nombre REGEXP '^......$';
	SELECT * FROM tbl_uno WHERE nombre REGEXP '^........$'; -- Buscara de ocho caracteres
-- regexp '......' -- Buscara en el campo nombre todos los datos que tengan un apoximado de nCaracteres (puntos)
	SELECT * FROM tbl_uno WHERE nombre REGEXP '......';
-- regexp 'a.*a' -- Buscara en el campo de nombre todos los datos que contengan dos caracteres a
	SELECT * FROM tbl_uno WHERE nombre REGEXP 'a.*a';
	SELECT * FROM tbl_uno WHERE nombre REGEXP 'i.*i'; --Buscara dos caracteres i


--LIMIT - RAND
--Muestra los primeros 5 registros, (0, 1, 2, 3, 4)
SELECT * FROM tbl_uno LIMIT(0, 5);
--Muestra los 4 registros empezando desde el registro 5, (5, 6, 7, 8)
SELECT * FROM tbl_uno LIMIT(5, 4);
--Ordena una columna al azar con 'RAND()' Y LIMITA PARA MOSTRAR LOS DOS PRIMEROS REGISTROS
SELECT * FROM tbl_uno ORDER BY RAND() LIMIT 2;
--Ordena una columna al azar con 'RAND()' Y LIMITA PARA MOSTRAR LOS TRES PRIMEROS REGISTROS
SELECT CAMPO1, CAMPO2 FROM tbl_uno ORDER BY RAND() LIMIT 3;

--Copiar la estructura de una tabla
--LIMIT 0, es para especificar que no quiero ningun registro en la tabla copiada
CREATE TABLE tbl_new SELECT * FROM tbl_old LIMIT 0;


--Actualizar unos datos de usuario
UPDATE tbl_uno SET nombre = 'Victor', apellido = 'Rivera' WHERE = '1';


--REEMPLAZA TODO EL REGISTRO DE SI ES QUE EXISTIERA UNO 'REPLACE'
REPLACE INTO tbl_uno VALUES(campo1, campo2, campo3);


--Muestra/Buscar la tabla empleados
SELECT * FROM tbl_uno;
SELECT * FROM bd_uno.tbl_uno;
SELECT * FROM tbl_uno\G; -- Para visualizar la informacion en formato CARTA

--Hacer consultas de algunos campos de la tabla
SELECT * FROM tbl_uno WHERE nombre='victor';
SELECT nombre FROM tbl_uno;
SELECT columnaUno, columnaDos FROM tbl_uno WHERE apellido='rivera';
SELECT * FROM tbl_uno WHERE edad IS NULL;		--Muestra la informacion que diga 'NULL'
SELECT * FROM tbl_uno WHERE edad IS NOT NULL;	--Opcion1. Muestra la informacion y oculta el campo que diga 'NULL'
SELECT * FROM tbl_uno WHERE NOT edad IS NULL;	--Opcion2. Muestra la informacion y oculta el campo que diga 'NULL'


/*OPERADORES LOGICOS
AND		&&		Significa	y
OR		||		Significa	y/0
XOR				Significa	O
NOT		!		Significa	no		-> invierte el resutaldo parecido al DISTINCT. Ubicacion en WHERE NOT(condicion) */
--Filtra de una convinacion de requerimientos
SELECT * FROM tbl_uno WHERE fecha='2018-01-03' OR fecha='2018-02-03';
SELECT * FROM tbl_uno WHERE nombre='Victor' OR peso>='120';
SELECT * FROM tbl_uno WHERE fecha='2018-01-03' AND peso='120.4';
SELECT * FROM tbl_uno WHERE nombre='Victor' AND peso>='120';
SELECT (1=1) && (4>5);		--Respuesta: 0
SELECT 0 || 1;				--Respuesta: 1
SELECT NOT (1=0);			--Respuesta: 1


/*
	OPERADORADOR DE COMPARACION: -> Devuelve:
		TRUE	= 1
		FALSE	= 0
*/
	SELECT 1 != 0;	-> Distinto. Respuesta: 1


--BUSQUEDA DE PATRONES (LIKE - NOT LIKE)
-- Filtra los nombres que empieza con la letra a
SELECT * FROM tbl_uno WHERE nombre LIKE 'a%';
SELECT nombre, apellido, telefono FROM tbl_uno WHERE telefono NOT LIKE '6%' AND telefono NOT LIKE '7%';
-- Filtra los nombres que termina con la letra a
SELECT * FROM tbl_uno WHERE nombre LIKE '%a';
-- Filtra el nombre victor
SELECT * FROM tbl_uno WHERE nombre LIKE '%victor%';
-- Filtra la columna nombre donde exista una cadena con 5 caracteres
SELECT * FROM tbl_uno WHERE nombre LIKE '_____'; -- Con 5 barras bajo

LIKE '[a-cf-i]%': busca cadenas que comiencen con a,b,c,f,g,h o i;
LIKE '[-acfi]%': busca cadenas que comiencen con -,a,c,f o i;
LIKE 'A[_]9%': busca cadenas que comiencen con 'A_9';
LIKE 'A[nm]%': busca cadenas que comiencen con 'An' o 'Am'.

--Para seleccionar los libros cuya editorial NO comienza con las letras "P" ni "N" tipeamos:
SELECT titulo,autor,editorial FROM libros WHERE editorial LIKE '[^PN]%';

--Queremos buscar todos los libros cuyo precio se encuentre entre 10.00 y 19.99:
SELECT titulo,precio FROM libros WHERE precio LIKE '1_.%';

--Queremos los libros que NO incluyen centavos en sus precios:
SELECT titulo,precio FROM libros WHERE precio LIKE '%.00';

--Para búsquedas de caracteres comodines como literales, debe incluirlo dentro de corchetes:
LIKE '%[%]%': busca cadenas que contengan el signo '%';
LIKE '%[_]%': busca cadenas que contengan el signo '_';
LIKE '%[[]%': busca cadenas que contengan el signo '[';


--Filtra de un listado quitando la informacion que le decimos
SELECT * FROM tbl_uno WHERE NOT nombre='victor';

--Filtra de un listado y ocultando las celdas vacias
SELECT * FROM tbl_uno WHERE comentarios <> '';

--Filtra las celdas vacias
SELECT * FROM tbl_uno WHERE nombre IS NULL;
--Filtra las celdas que no estan vacias
SELECT * FROM tbl_uno WHERE nombre IS NOT NULL;


-- REGISTROS CON DATOS IGUAL, SOLO NOS MUESTRA UNO 'DISTINCT'
--Filtra datos repetidos y deja a uno
SELECT DISTINCT nombre FROM tbl_uno;		--Se debe aplicar solo a una columna de busqueda
SELECT DISTINCT apellido FROM tbl_uno ORDER BY apellido DESC;
SELECT provincia, COUNT(DISTINCT ciudad) FROM tb_uno GROUP BY provincia;
SELECT EXTRACT(MOUNT FROM fechaHora), EXTRACT(DAY FROM fechaHora), COUNT(DISTINCT medico) FROM tbl_uno
	GROUP BY EXTRACT(MOUNT FROM fechaHora), EXTRACT(DAY FROM fechaHora);


--FUCIONES STRING
SELECT CONCAT('Victor ', 'Rivera ', 'Mora');		--Respuesta: Victor RIvera Mora
SELECT LEFT('Victor Rivera Mora', 4);				--Respuesta: Vict
SELECT RIGHT('Victor Rivera Mora', 4);				--Respuesta: Mora
SELECT LENGHT('Victor');							--Respuesta: 6
SELECT TRIM('    Victor    ');						--Respuesta: Victor
SELECT TRIM('    Victor    Rivera');				--Respuesta: Victor    Rivera
SELECT RTRIM('    Victor    ');						--Respuesta: '    Victor'
SELECT LTRIM('    Victor    ');						--Respuesta: 'Victor    '
SELECT UPPER('Victor Rivera Mora');					--Respuesta: VICTOR RIVERA MORA
SELECT LOWER('Victor Rivera Mora');					--Respuesta: victor rivera mora
SELECT SUBSTRING('Victor Rivera', 8,6);				--Respuesta: Rivera
SELECT LOCATE('r', 'Victor Rivera Mora');			--Respuesta: 6


--FUNCIONES NUMERICAS:
	SELECT MOD(5, 2);							--Respuesta: 1
	SELECT ROUND(125.456, 2);					--Respuesta: 125.46
	SELECT ROUND(125.456, 0);					--Respuesta: 125
	SELECT COUNT(Nombre) FROM tbl_clientes;		--Devuelve la cantidad de registros en la columna Nombre
	SELECT MAX(Sueldo) FROM tbl_clientes;		--Devuelve el sueldo mayor de la colunma de Sueldo de todos los registros
	SELECT MIN(Sueldo) FROM tbl_clientes;		--Devuelve el sueldo minimo de la colunma de Sueldo de todos los registros
	SELECT SUM(Sueldo) FROM tbl_clientes;		--Devuelve la suma de la colunma de Sueldo de todos los registros


--FUNCIONES FECHA:
	SELECT CURDATE();						--Devuelve la fecha del sistema. Respuesta: 2024-03-15
	SELECT YEAR(CURDATE());					--Devuelve el año. Respuesta: 2024
	SELECT MONTH(CURDATE());				--Devuelve el mes. Respuesta: 3
	SELECT DAY(CURDATE());					--Devuelve el dia. Respuesta: 15
	SELECT CURTIME();						--Devuelve la hora del sistema. Respuesta: 20:52:31
	SELECT CURRENT_TIMESTAMP();				--Devuelve fecha y hora. Respuesta: 2024-03-15 20:52:31
	SELECT DATE(CURRENT_TIMESTAMP());		--Devuelve fecha. Respuesta: 2024-03-15
	SELECT TIME(CURRENT_TIMESTAMP());		--Devuelve hora. Respuesta: 20:52:31


--FUNCIONES ADICIONALES O AVANZADAS
	--CON CAST()	-> INT, DECIMAL, CHAR, DATE
	SELECT CAST('2024-03-15' AS DATE);		--Respuesta: 2024-03-15
	SELECT CAST(123 AS INT);				--Respuesta: 123
	SELECT CAST(123 AS CHAR);				--Respuesta: 123
	--CON ISNULL()	->
	SELECT NULL;							--Respuesta: NULL
	SELECT ISNULL(NULL);					--Respuesta: 1
	SELECT ISNULL('Victor');				--Respuesta: 0
	--CON IF()		->
	SELECT IF(4=4, 'Datos iguales', 'Datos deferentes');	--Respuesta: Datos iguales
	--CON CONVERT()
	SELECT CONVERT('2024-03-15', DATE);		--Respuesta: 2024-03-15
	--CON CASE()
	SELECT (CASE 1
		WHEN 1 THEN 'UNO'
		WHEN 2 THEN 'DOS'
		WHEN 2 THEN 'TRES'
		ELSE 'Dato no registrado' END);		--Respuesta: UNO



--Filtrar dos columnas
SELECT * FROM tbl_uno WHERE CONCAT(nombre, '', apellido) LIKE '%Victor Rivera%'
--Filtrar dos columnas y en el resultado se concatenara la respuesta de las dos columnas
SELECT CONCAT(nombre, ' ', apellido) AS 'Nombre Completo', direccion, telefono FROM tbl_uno WHERE CONCAT(nombre, '', apellido) LIKE '%Victor Rivera%'


-- FUNCIONES DE AGRUPACION (COUNT, MAX, MIN, SUM, AVG)
-- Sumar todo lo de la columna precio
SELECT SUM(precio) FROM tbl_uno;
SELECT SUM(precio) FROM tbl_uno WHERE ciudad = 'Quito';
-- Contar cuantos registros hay en la tabla y dar un nombre "registro"
SELECT COUNT(*) AS registro FROM tbl_uno;
SELECT COUNT(idUno) AS registro FROM tbl_uno;
SELECT COUNT(*) FROM tbl_uno WHERE genero = 'M' AND edad >= 18;
SELECT COUNT(*) FROM tbl_uno WHERE nombre LIKE '%Hugo%'; -- Que cuente todos los registros que tengan el nombre Hugo
-- Ver quien tiene el mayor precio
SELECT MAX(precio) AS mayorPrecio FROM tbl_uno;
-- Ver quien tiene el menor precio
SELECT MIN(precio) AS 'Menor Precio' FROM tbl_uno;
SELECT nombre, marca, precio FROM tbl_uno WHERE precio = (SELECT MIN(precio) FROM tbl_uno);


--OPERADORES ARITMETICOS:
	SELECT 5 DIV 2; --Division. Devuelve un numero entero hacia abajo. Repuesta: 2
	SELECT 5 % 2; --Reciduo primera opcion. Devuelve el resto de una division. Respuesta: 1
	SELECT 5 MOD 2; --Reciduo, segunda opcio. Devuelve el resto de una division. Respuesta: 1
	SELECT MOD(5, 2); --Reciduo, tercer opcio. Devuelve el resto de una division. Respuesta: 1


-- Ver solo el mes de una tabla
SELECT SUBSTRING(fecha,6,2) AS mes FROM tbl_uno;


--ORDER BY - Se usa para ordenar los registros en un conjunto de resultados
--Ordena la columna de nombre en orden alfabetica
SELECT * FROM tbl_uno ORDER BY nombre;
SELECT * FROM tbl_uno ORDER BY nombre ASC;
SELECT * FROM tbl_uno ORDER BY nombre DESC;
SELECT * FROM tbl_uno ORDER BY 1 ASC;	--El 1 hace referencia a la primera columna de la tabla
--Ordena las columnas de nombre y apellido en orden alfabetica
SELECT * FROM tbl_uno ORDER BY nombre, ORDER BY apellido;
SELECT * FROM tbl_uno ORDER BY nombre ASC, ORDER BY apellido ASC;
SELECT * FROM tbl_uno ORDER BY nombre DESC, ORDER BY apellido ASC;
SELECT * FROM tbl_uno WHERE marca = 'iphone' ORDER BY id;
SELECT * FROM tbl_uno WHERE marca = 'iphone' ORDER BY id ASC;
SELECT * FROM tbl_uno WHERE marca = 'iphone' ORDER BY id DESC;
SELECT * FROM tbl_uno ORDER BY edad ASC LIMIT 1;
SELECT * FROM tbl_uno ORDER BY edad DESC LIMIT 1;
--Ordena la columna de nombre en orden alfabetica con la columna siguiente
SELECT * FROM tbl_uno GROUP BY nombre;
SELECT * FROM tbl_uno GROUP BY nombre ASC;
SELECT * FROM tbl_uno GROUP BY nombre DESC;
SELECT marcas, SUM(precio) FROM tbl_uno GROUP BY marcas;
SELECT marcas, COUNT(*) FROM tbl_uno GROUP BY marcas;
SELECT marcas, COUNT(*) FROM tbl_uno WHERE color = 'azul' GROUP BY marcas;
SELECT codigo_ca, COUNT(codigo_ar) FROM tb_articulos GROUP BY codigo_ca;
SELECT color, min(precio) FROM tbl_uno GROUP BY color;
SELECT color, max(precio) FROM tbl_uno GROUP BY color;


--HAVING
--Se utiliza en convinacion con clausula GROUP BY, para registrar los grupos de filas devueltas, solo a aquellos cuya condicion es VERDADERA.
--GROUP BY, HAVING, ORDER BY --> Orden de uso
SELECT marcas, SUM(precio) FROM tbl_uno GROUP BY marcas HAVING SUM(precio) > 500:
SELECT color, COUNT(*) FROM tbl_uno GROUP BY color HAVING COUNT(*) < 4;
SELECT color, MIN(precio) FROM tbl_uno GROUP BY color HAVING MIN(precio) < 200;


--Filtrar cantidad con IN (Multiples opciones), selecciona 17 y 25 años - y tres colores
SELECT * FROM tbl_uno WHERE edad IN (17, 25);
SELECT * FROM tbl_uno WHERE color IN ('Azul', 'Amarillo', 'Rojo');
--Filtrar cantidad con IN (Multiple opciones), entre 30 y 35 años
SELECT * FROM tbl_uno WHERE fechaNacimiento = '2020-04-03' AND edad IN (30, 35);


--Actualizar o modificar uno o varios campos
UPDATE tbl_empleados SET comentarios='no aplica' WHERE id_cedula=1;
UPDATE tbl_empleados SET comentarios='no aplica',fecha='2018-04-04',nombre='Miguel' WHERE id_cedula='1205959578';

--Colocar alias al nombre de columna o tabla
SELECT nombre AS Nomb FROM tbl_empleados;				--Alias a la columna
SELECT nombre AS 'Primer Nombre' FROM tbl_empleados;	--Alias a la columna
SELECT * FROM tbl_empleados AS Empleados;				--Alias a la tabla

--Para eliminar una fila
DELETE FROM tbl_empleados WHERE id_cedula='1205959578';
--Para eliminar los registros de las personas que se apellidan Rivera
DELETE FROM tbl_empleados WHERE apellido='Rivera';
--Esto eliminaria todos los registros de la tabla y no es recomendable
DELETE FROM tbl_empleados;

--Elimina toda la informacion de la tabla
TRUNCATE TABLE tbl_uno;
TRUNCATE tbl_uno;


--SUBCONSULTAS (SUBQUERY)
--Con SELECT
	SELECT columna, (SELECT subconsulta) AS alias FROM tabla;
	--Ejemplo:
		SELECT nombrePais,
			(SELECT lenguaje FROM countrylanguage WHERE CountryCode = country.Code ORDER BY Porcentaje DESC LIMIT 1) AS Idioma,
			(SELECT Porcentaje FROM countrylanguage WHERE CountryCode = country.Code ORDER BY Porcentaje DESC LIMIT 1) AS Porcentje
		FROM country;

--Con WHERE
	SELECT columna FROM tabla WHERE columna IN (SELECT subconsulta);
--Con HAVING
	SELECT columna FROM tabla GROUP BY columna HAVING columna IN (SELECT subconsulta);
--Con EXISTS
	SELECT columna FROM tabla WHERE EXISTS (SELECT subconsulta);


/*QUE ES UN INDICE
Para facilitar la atencion de informacion de una tabla se utilizan indices. El indice de una tabla 
desempeña la misma funcion que el indice de un libro: permite encontrar datos rapidamente; en el 
caso de las tablas, localiza registros.

+ El objetivo de un indice es acelerar la recuperacion de informacion.
+ La indexacion es una tecnica que optimiza el acceso a los datos , mejora el rendimiento acelerando 
las consultas y otras operaciones. Es util cuando la tabla contiene miles de registros.
+ Los indices se usan para buscar registros rapidamente.
+ Una tabla puede tener hasta 64 indices.

1) PRIMARY KEY, es el que definimos como clave primaria. Los valores indexados deben ser unicos y 
ademas no puede ser nulos. Una tabla solamente puede tener una 
clave primaria.
2) INDEX, crea un indice comun, los valores no necesariamente son unicos y aceptan valores 'null'.
Podemos darle un nombre, si no lo damos, se coloca uno por defecto 'KEY' es sinonimo de 'INDEX'.
Puede haber varios por tabla.
3) UNIQUE, crea un indice para los cuales los valores deben ser unicos y diferentes, aparece un 
mensajes de error si intentamos agregar un registro con un valor ya existente. Permite valores nulos 
y pueden definirse varios por tabla. Podemos darle un nombre, si no se lo damos, se coloca uno por 
defecto.
*/
-- Mostrar los indices de una tabla
SHOW INDEX FROM tbl_uno;

-- Crear un indice
CREATE TABLE tbl_uno(
codigo INT UNSIGNED AUTO_INCREMENT,
campo1 ...
campo2 ...
campoN ...
PRIMARY KEY(codigo), --Es el indice PRIMARY
INDEX i_nombreCampo (nombreCampo) --Es el indice INDEX
);

-- Crear indices
CREATE TABLE tbl_uno(
codigo INT UNSIGNED AUTO_INCREMENT,
modelo ...
documento ...
titulo editorial ...
ciudadProvincia ..
PRIMARY KEY(codigo, modelo), --Es el indice PRIMARY
UNIQUE i_documento (nombreCampo), --Es el indice UNIQUE.. Seria el nombre del campo documento
UNIQUE i_tituloEditorial (nombreCampo), --Seria el nombre del campo tituloEditorial
INDEX i_ciudadProvincia (nombreCampo) --Es el indice INDEX.. Seria el nombre del campo ciudadProvincia
);

--Eliminar un INDEX
DROP INDEX i_nombreCampo ON tbl_uno;


--(ALTER TABLE - ADD) - (ALTER TABLE - DROP) - (ALTER TABLE - MODIFY) - (ALTER TABLE - CHANGE)
--Agregar un campo(columna) en la tabla
ALTER TABLE tbl_uno ADD campoUno TINYINT UNSIGNED;
ALTER TABLE tbl_uno ADD campoUno VARCHAR(20);
--Eliminar un campo(columna) de la tabla. NOTA no se puede eliminar la ultima columna de la tabla
ALTER TABLE tbl_uno DROP campoUno; 
--Modifica el tipo/caracteristicas del campo
ALTER TABLE tbl_uno MODIFY campoUno TINYING UNSIGNED;
ALTER TABLE tbl_uno MODIFY campoUno VARCHAR(20) NOT NULL;
ALTER TABLE tbl_uno MODIFY campoUno <DECIMAL(9) UNSIGNED NOT NULL;
ALTER TABLE tbl_uno MODIFY campoUno UNSIGNED AUTO_INCREMENT; --Aparecera error porque no se puede editar a un PRYMARI 


--UNION
--Nos permite convinar dos o mas conjuntos de resultados de consultas en un solo
--conjunto de resultados.
--Cada instruccion debe tener el mismo numero de columnas.
--Las columnas tambien deben tener el mismo tipo de datos similares.
--Las columnas en cada instruccion tambien deben estar en el mismo orden.
SELECT * FROM tbl_uno UNION SELECT * FROM tbl_dos;
SELECT nombre, apellido FROM tbl_uno UNION SELECT nombre, apellido FROM tbl_dos;		-- Muestra informacion unica (sin repetir) de las dos tablas
SELECT nombre, apellido FROM tbl_uno UNION ALL SELECT nombre, apellido FROM tbl_dos;	-- Muestra informacion repetida de las dos tablas
SELECT codigo_um, descripcion_un, 'Medidas' AS Tipo FROM tb_unidad_medidad UNION SELECT codigo_ar, descripcion_ar, 'Articulos' AS Tipo FROM tb_articulos;



--EXCEPT
--Se usa para permitir busquedas en las tuplas que esten en una relacion y no
--en otra.
SELECT nombre, apellido FROM tbl_uno EXCEPT ALL SELECT nombre FROM tbl_dos;
SELECT nombre, apellido FROM tbl_uno WHERE nombre NOT IN (SELECT nombre FROM tbl_dos);



--Producto Cartesiano 
SELECT nombre, nacionalidad, genero FROM tbl_uno, tbl_dos WHERE tbl_uno.id = tbl_dos.id;
SELECT uno.nombre, uno.nacionalidad, dos.genero FROM tbl_uno uno, tbl_dos dos WHERE uno.id = dos.id;



--INNER JOIN o JOIN --> Es igual al escribir
--Permite emparejar filas de distintas tablas de forma mas eficiente que el producto cartesiano
SELECT	A.codigo_ar,
		A.descripcion_ar,
		A.marca_ar,
		A.codigo_um,
		A.codigo_ca,
		B.descripcion_ca
FROM tb_articulos A
INNER JOIN tb_categorias B ON A.codigo_ca=B.codigo_ca;

INNER JOIN tbl_uno ON tbl_uno.id = tbl_dos.idEstadoCivil;
SELECT COUNT (platillos.id), categoria.nombre FROM platillos INNER JOIN categoria ON platillos.categoriaId = categoriaId GROUP BY categoria.nombre;

SELECT uno.nombre, uno.nacionalidad, dos.genero 
FROM tbl_uno uno INNER JOIN tbl_dos dos 
ON uno.id = dos.id;

SELECT uno.nombre, uno.nacionalidad, dos.* 
FROM tbl_uno uno INNER JOIN tbl_dos dos 
ON uno.id = dos.id;

--INNER JOIN con 3 tablas
SELECT ar.id_artista, ar.alias, ca.titulo FROM artista ar
INNER JOIN album al ON ar.id_artista = al.id_artista
INNER JOIN cancion ca ON al.id_album = ca.id_album;

SELECT pel.titulo_original, pel.genero, pel.pais_origen, tr.codigo_emp, tr.nombre_personaje FROM pelicula pel
INNER JOIN trabaja tb ON pel.identificador = tr.identificador AND clasificacion = "Mayor a 15 años";

--INNER JOIN con 3 tablas
SELECT	A.codigo_ar,
		A.descripcion_ar,
		A.marca_ar,
		C.descripcion_um,
		A.codigo_ca,
		B.descripcion_ca
FROM tb_articulos A
INNER JOIN tb_categorias B ON A.codigo_ca = B.codigo_ca
INNER JOIN tb_unidades_medidas C ON A.codigo_um = C.codigo_um;

SELECT 	b.descripcion_ca AS Categoria,
		COUNT(a.codigo_ar) AS Total_Articulos
FROM tb_articulos a
INNER JOIN tb_categorias b ON a.codigo_ca = b.codigo_ca
GROUP BY a.codigo_ca;

--LEFT JOIN
--Damos prioridad a la tabla de la izquierda.
SELECT uno.nombre, uno.nacionalidad, dos.genero FROM tbl_uno uno LEFT JOIN tbl_dos dos ON uno.id = dos.id;
SELECT uno.nombre, uno.nacionalidad, dos.* FROM tbl_uno uno LEFT JOIN tbl_dos dos ON uno.id = dos.id;

SELECT	A.codigo_ca,
		A.descripcion_ca,
		B.descripcion_ar,
		B.marca_ar
FROM tb_categorias A
LEFT JOIN tb_articulos B ON A.codigo_ca = B.codigo_ca;


--RIGHT JOIN
--Damos prioridad a la tabla de la derecha.
SELECT uno.nombre, uno.nacionalidad, dos.genero FROM tbl_uno uno RIGHT JOIN tbl_dos dos ON uno.id = dos.id;
SELECT uno.nombre, uno.nacionalidad, dos.* FROM tbl_uno uno RIGHT JOIN tbl_dos dos ON uno.id = dos.id;

SELECT	A.codigo_ar,
		A.descripcion_ar,
		A.marca_ar,
		B.descripcion_um
FROM tb_articulos A
RIGHT JOIN tb_unidades_medidas B ON A.codigo_um = B.codigo_um;


--CROSS JOIN ¡


--IF
SELECT	codigo_ar,
		descripcion_ar,
		IF(estado = 1, 'Activo', 'Anulado') AS Estado
		FROM tb_articulos;


--CASE
SELECT	codigo_ar,
		(CASE descripcion_ar
			WHEN 'Escritorio' THEN CONCAT(descripcion_ar, ' (Nueva Oferta)')
			WHEN 'Cementos' THEN CONCAT(descripcion_ar, ' (Nueva Oferta)')
			WHEN 'Ladrillos' THEN CONCAT(descripcion_ar, ' (Nueva Oferta)')
			ELSE descripcion_ar
		END) AS Articulos
	FROM tb_articulos;


CREATE VIEW t_vista_A AS
SELECT id_cedula,nombre,fecha FROM tbl_empleados;
-- Se creara una tabla en view con los datos requeridos
SELECT * FROM t_vista_A;



--Crear un PROCEDURE, Ejemplo 1:
	DELIMITER $$ --El signo $$ puede ser cualquiera pero lo mas normal es usar ese signo
		CREATE PROCEDURE Listado_articulos()
		BEGIN
			SELECT * FROM tb_articulos;
		END;
	$$
--Llamar el PROCEDURE:
	CALL Listado_articulos();


--Crear un PROCEDURE, Ejemplo 2:
DROP PROCEDURE IF EXISTS Listado_Articulos_Consolidado;
DELIMITER $$
CREATE PROCEDURE Listado_Articulos_Consolidado()
	BEGIN
		SELECT a.codigo_ar,
			a.descripcion_ar,
			a.marca_ar,
			c.descripcion_um,
			b.descripcion_ca
		FROM tb_articulos a
		INNER JOIN tb_categorias b ON a.codigo_ca = b.codigo_ca
		INNER JOIN tb_unidades_medidas c ON a.codigo_um = c.codigo_um;
	END;
$$
--Llamar el PROCEDURE:
	CALL Listado_Articulos_Consolidado();



--Parametros en PROCEDURE. Existen 3 tipos:
--IN		Por defecto
--OUT
--INOUT
--Crear un PROCEDURE, Ejemplo 1:
	DELIMITER $$
		CREATE PROCEDURE Buscar_articulo(IN Xcodigo INT)	--Recibe un parametro de tipo INT
		BEGIN
			SELECT * FROM tb_articulos WHERE codigo_ar = Xcodigo;
		END;
	$$
--Llamar el PROCEDURE:
	CALL Buscar_articulo(4);	--Como parametro mandamos el 4


--Crear un PROCEDURE, Ejemplo 2:
	DELIMITER $$
		CREATE PROCEDURE Insertar_categoria(IN xDescripcion VARCHAR(20))	--Recibe un parametro de tipo INT
		BEGIN
			INSERT INTO tb_categorias(descripcion_ca, estado) VALUES(xDescripcion, 1);
		END;
	$$
--Llamar el PROCEDURE:
	CALL Insertar_categoria('Otros');	--Como parametro mandamos 'Otros'


--Crear un PROCEDURE, Ejemplo 3:
	DELIMITER $$
		CREATE PROCEDURE Total_articulos(OUT total INT)	--Recibe un parametro de tipo INT
		BEGIN
			SELECT COUNT(codigo_ar) INTO total FROM tb_articulos;
		END;
	$$
--Llamar el PROCEDURE:
	CALL Total_articulos('Otros');	--Como parametro mandamos 'Otros'
	SELECT @nTotal;


--Crear un PROCEDURE, Ejemplo 4:
	DELIMITER $$
		CREATE PROCEDURE Encontrar_articulos(IN cArticulo VARCHAR(100), OUT nRespuesta INT)	--Recibe un parametro de tipo INT
		BEGIN
			SELECT COUNT(codigo_ar) FROM tb_articulos WHERE UPPER(TRIM(descripcion_ar)) = UPPER(TRIM(cArticulo));
		END;
	$$
--Llamar el PROCEDURE:
	CALL Encontrar_articulos('sillas', @nResp);	--Como parametro mandamos 'Otros'
	SELECT @nResp;


--INOUT
--Crear un PROCEDURE, Ejemplo 1:
	DELIMITER $$
	CREATE PROCEDURE Mostrar_descripcion_ar(INOUT Contenido VARCHAR(30))
	BEGIN
		SELECT descripcion_ar INTO Contenido FROM tb_articulos WHERE TRIM(CAST(codigo_ar AS CHAR)) = TRIM(Contenido);
	END;
	$$
--Llamar el PROCEDURE con estas 3 lineas de codigo:
	SET @Texto = 1;
	CALL Mostrar_descripcion_ar(@Texto);
	SELECT @Texto;


--Crear un PROCEDURE, Ejemplo 2:
	DELIMITER $$
	CREATE PROCEDURE Saber_nombre(IN Nombre VARCHAR(20))
	BEGIN
		IF Nombre = 'VICTOR' THEN
			SELECT 'Tu eres Victor';
		ELSE
			SELECT 'Nombre desconocido';
		END IF;
	END;
	$$
--Llamar el PROCEDURE con estas 3 lineas de codigo:
	CALL Saber_nombre('VICTOR');


--Crear un PROCEDURE, Ejemplo 3:
	DELIMITER $$
	CREATE PROCEDURE Operacion_matematicas_full(IN Valor1 INT, IN Valor2 INT, IN Operacion VARCHAR(20))
	BEGIN
		IF Operaciones = 'SUMA' THEN
			SELECT Valor1 + Valor2;
		ELSEIF Operaciones = 'RESTA' THEN
			SELECT Valor1 - Valor2;
		ELSEIF Operaciones = 'MULTIPLICA' THEN
			SELECT Valor1 * Valor2;
		ELSEIF Operaciones = 'DIVISION' THEN
			SELECT Valor1 / Valor2;
		ELSE
			SELECT 'No tengo definido la operacion matematicas';
		END IF;
	END;
	$$
--Llamar el PROCEDURE con estas 3 lineas de codigo:
	CALL Operacion_matematicas_full(5, 10, 'RESTA');


--Crear un PROCEDURE, Ejemplo 4:
	DELIMITER $$
	CREATE PROCEDURE Mantenimiento_categoria(IN Codigo INT, IN Descripcion VARCHAR(30), IN EstadoGuarda INT)
	BEGIN
		IF EstadoGuarda = 1 THEN
			INSERT INTO tb_categorias(descripcion_ca, estado) VALUES(Descripcion, 1);
		ELSEIF EstadoGuarda = 2 THEN
			UPDATE tb_categorias SET descripcion_ca = Descripcion WHERE codigo_ca = Codigo;
		ELSE
			SELECT 'Accion de tarea no definida';
		END IF;
	END;
	$$
--Llamar el PROCEDURE con estas 3 lineas de codigo:
	CALL Mantenimiento_categoria(0, 'Nueva categoria', 1);



--FUNCTION
--Crear una FUNCTION, Ejemplo 1:
	DELIMITER $$
		CREATE FUNCTION Suma(Valor1 INT, Valor2 INT) RETURNS INT
		DETERMINISTIC
		BEGIN
			DECLARE Resultado INT;
			SET Resultado = Valor1 + Valor2;
			RETURN Resultado;
		END;
	$$
--Llamar a la FUNCTION de codigo:
SELECT Suma(10, 5);


--Crear una FUNCTION, Ejemplo 2:
	DELIMITER $$
		CREATE FUNCTION Operacion_full(Valor1 INT, Valor2 INT, Op VARCHAR(15)) RETURNS INT
		DETERMINISTIC
		BEGIN
			DECLARE Resultado INT;
			IF Op = 'Suma' THEN
				SET Resultado = Valor1 + Valor2;
			ELSEIF Op = 'Resta' THEN
				SET Resultado = Valor1 - Valor2;
			ELSEIF Op = 'Multiplica' THEN
				SET Resultado = Valor1 * Valor2;
			ELSE
				SET Resultado = 0;
			END IF;
			RETURN Resultado;
		END;
	$$
--Llamar a la FUNCTION de codigo:
SELECT Operacion_full(5, 10, 'Multiplica');



--TRIGGERS
/*Tambien conocido como disparador (por su traduccion al español), es un conjunto de sentencias SQL las cuales se ejecutan de forma
automatica cuando ocurre algun evento que modifique una tabla.
Lo interesante aqui es que podemos programar los triggers de tal manera que se ejecuten antes o despues, de dichas sentencias; Dando
como resultado seis combinaciones de eventos.

BEFORE INSERT	Acciones a realizar antes de insertar uno o mas registros en una tabla.
AFTER INSERT	Acciones a realizar despues de insertar uno o mas registros en una tabla.
BEFORE UPDATE	Acciones a realizar antes de actualizar uno o mas registros en una tabla.
AFTER UPDATE	Acciones a realizar despues de actualizar uno o mas registros en una tabla.
BEFORE DELETE	Acciones a realizar antes de eliminar uno o mas registros en una tabla.
AFTER DELETE	Acciones a realizar despues de eliminar uno o mas registros en una tabla.
*/

DELIMITER $$
	CREATE DEFINER = CURRENT_USER TRIGGER 'bd_nombre'.'tb_categorias' AFTER INSERT ON 'tb_categorias' FOR EACH ROW
	BREGIN
		INSERT INTO tb_auditoria(nombre_tb, usuario, fecha_actual, accion) VALUES('TB_CATEGORIAS', USER(), NOW(), 'INSERTADO DE REGISTRO');
	END$$
DELIMITER;

/*
	Verificamos en Workbench el trigger creado:
		Desplazar la base de datos
			Desplazar Tablas
				Desplazar tb_categocias
					Desplazar Triggers
					Ahi esta el trigger creado
				Desplazar tb_auditoria
				Ahi consultamos los datos que se guardan del trigger
*/


--Crear un PROCEDURE, Ejemplo 3:
DELIMITER $$
CREATE PROCEDURE Listado_ADE_Consolidado()
BEGIN
	SELECT E.estudiante_id AS id, E.nombre, E.apellido, E.correo_electronico, E.contrasena, R.nombre AS rol
    	FROM estudiante AS E INNER JOIN rol AS R ON E.rol_id=R.rol_id 
    UNION ALL
    SELECT D.docente_id, D.nombre, D.apellido, D.correo_electronico, D.contrasena, R.nombre
    	FROM docente AS D INNER JOIN rol AS R ON D.rol_id=R.rol_id 
    UNION ALL
    SELECT A.admin_id, A.nombre, A.apellido, A.correo_electronico, A.contrasena, R.nombre
        FROM administrativo AS A INNER JOIN rol AS R ON A.rol_id=R.rol_id;
END;
$$


CALL `Listado_ADE_Consolidado`();




