/*
	CONECTOR PARA PYTHON
	En la terminal del IDE, ejecutar le siguiente comando:
	Nota: Se recomienda usarlo despues de activar el entorno virtual.
		python -m pip install mysql-connector-python
	
	Actualizar pip con el siguiente comando:
		python -m pip install --upgrade pip
*/

/*
import mysql.connector

personas_db=mysql.connector.connect(
	host='localhost', --127.0.0.1
	user='root',
	password='admin',
	database='personas_db'
)
*/

/*
--ejecutar la sentencia SELECT

cursor=personas_db.cursor()
cursor.execute('SELECT * FROM personas');
resultado=cursor.fetchall()

for persona in resultado:
	print(persona)
	
cursor.close()
personas_db.close()
*/

/*
--ejecutar la sentencia INSERT

cursor=personas_db.cursor()
sentencia_sql='INSERT INTO personas(nombre, apellido, edad) VALUES(%s, %s, %s)'
valores=('Victor', 'Rivera', 20) --Tupla
cursor.execute(sentencia_sql, valores);
personas_db.commit() --Guardar los cambios en la bd
print(f'Se ha agregado el nuevo registro a la bd: {valores}')

cursor.close()
personas_db.close()
*/

/*
--ejecutar la sentencia UPDATE

cursor=personas_db.cursor()
sentencia_sql='UPDATE personas SET nombre=%s, apellido=%s, edad=%s WHERE id=%s)'
valores=('Victor', 'Rivera', 20, 1) --Tupla
cursor.execute(sentencia_sql, valores);
personas_db.commit() --Guardar los cambios en la bd
print(f'Se ha actualizado el registro a la bd: {valores}')

cursor.close()
personas_db.close()
*/

/*
--ejecutar la sentencia DELETE

cursor=personas_db.cursor()
sentencia_sql='DELETE FROM personas WHERE id=%s'
valores=(1,) --Tupla
cursor.execute(sentencia_sql, valores);
personas_db.commit() --Guardar los cambios en la bd
print(f'Se ha eliminado el registro a la bd: {valores}')

cursor.close()
personas_db.close()
*/