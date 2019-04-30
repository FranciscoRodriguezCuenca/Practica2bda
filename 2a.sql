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
