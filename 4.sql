USE practica2BDA;
 /* 4a*/
DROP INDEX fecha_idx ON game;

ALTER TABLE player_stats
ADD puntuacion integer;
/*4b*/
UPDATE player_stats
SET puntuacion=(assists)+(goals)+(shots);
/*4c*/
UPDATE player_stats
SET puntuacion=NULL;
/*4d*/
CREATE INDEX player_stats_idx ON player_stats( goals, shots, game_id, assists, player_id,puntuacion);
/*4e*/
UPDATE player_stats
SET puntuacion=(assists)+(goals)+(shots);


/*Tarda casi el doble en cuanto a tiempo de ejecución, porque no es recomendable utilziar índices en cuanto a la actualización
de un atributo cuyos valores dependan de la tabla, se tiene que actualizar pues en el índice y en la misma tabla.*/
