USE practica2bda;

SELECT p.firstName, p.lastName, p.edad, p.goles, p.media_goles, SUM(ps.assists) AS Total_Asistencias, AVG(ps.assists) AS Media_Asistencias
FROM player p
	INNER JOIN player_stats ps ON p.player_id = ps.player_id
WHERE p.edad BETWEEN 25 AND 33
GROUP BY p.firstName, p.lastName, p.edad, p.goles, p.media_goles;
