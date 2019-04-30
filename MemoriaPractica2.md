# Práctica 2 Bases de Datos

Francisco Rodríguez Cuenca y Alejandro Lozano Morales

## 2. Estudio de planes de consulta e índices.

### **a. Crear una consulta SQL que permita obtener el número de partidos jugados por cada jugador para aquellos jugadores de nacionalidad estadounidense (USA) o canadiense (CAN) que hayan jugado más partidos que la media del número de partidos jugados por todos los jugadores. La consulta devolverá el nombre y apellido del jugador y su edad actual, así como el número de partidos jugados, pero el resultado estará ordenado descendentemente por edad e a igual edad por apellido seguido de nombre pero ascendentemente.**

````sql
USE practica2bda;

SELECT p.firstName, p.lastName, p.edad, COUNT(ps.game_id) AS numPartidos
FROM player p INNER JOIN player_stats ps ON p.player_id = ps.player_id
WHERE nationality = 'CAN' OR nationality = 'USA'
GROUP BY p.firstName, p.lastName, p.edad
HAVING COUNT(ps.game_id) > (
    SELECT AVG(a.numPartidos) AS media
    FROM (
            SELECT player_id ,COUNT(game_id) AS numPartidos
            FROM player_stats
            GROUP BY player_id
        )
    AS a
);
````

### **b. Estudiar el plan de consulta, tomando nota de los costes del mismo y comentarlo.**

<img src="2b.png"
     alt="2b"
     style="margin-right: 10px;"
     height = 300 />

>Se puede observar en la imagen que esta consulta es altamente ineficiente, ya que se realiza un producto cartesiano de dos tablas completas sin la ayuda de índices.

### **c. Crear las claves principales y foráneas mediante los ficheros script CrearClavesPrimarias.sql y CrearClavesForaneas.sql, y nuevamente estudiar el plan de consulta, comparando costes con el punto anterior.**

<img src="2c.png"
     alt="2c"
     style="margin-right: 10px;"
     height = 300 />

> En esta imagen se puede observar que una vez creadas las claves principales y foráneas, el sistema crea automáticamente índices que luego le ayudan a seleccionar únicamente las filas de player_stats que coinciden con la tabla player, sin tener que buscar por toda la tabla. 

> Esto se debe a que player_id es clave principal de player y player_stats, y foránea de player_stats. El sistema ha creado el índice player_stas_player_id, que ordena las filas de la tabla player_stats por la clave foránea player_id.

### **d. Crear los índices que se estimen necesarios para mejorar la consulta.**

````sql
USE practica2bda;

CREATE INDEX player_idx1
ON player (nationality, firstName, lastName, edad);

CREATE INDEX playerstats_idx1
ON player_stats (player_id);

````

### **e. Estudiar el plan de consulta con los nuevos índices y comparar resultados con los obtenidos en los puntos anteriores.**

#### Sin índices

<img src="2c.png"
     alt="2c"
     style="margin-right: 10px;"
     height = 300 />

#### Con el índice player_idx1

<img src="2da.png"
     alt="2da"
     style="margin-right: 10px;"
     height = 300 />

#### Con el índice playerstats_idx1

<img src="2dc.png"
     alt="2dc"
     style="margin-right: 10px;"
     height = 300 />

#### Con los dos índices

<img src="2db.png"
     alt="2db"
     style="margin-right: 10px;"
     height = 300 />

> Se puede observar que la creación de índices no siempre acelera las consultas, pues pese a que en todos estos casos los índices mejoren la cantidad de filas seleccionadas de cada tabla, únicamente el caso con solo el índice player_stats_idx1 mejora marginalmente la complejidad.

## 3. 
