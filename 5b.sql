USE practica2bda;

SELECT p.firstName,p.lastName,p.edad,MediaAsist.TotAsist,MediaAsist.mediaAsistPartido,MediaGoles.TotGoles,MediaGoles.mediaGolesPartido
FROM player p,(	SELECT ps.player_id,SUM(ps.assists) AS totalAsis
				FROM player_stats ps,player p 
                WHERE ps.player_id=p.player_id
                AND p.edad BETWEEN "25" AND "33"
                GROUP BY ps.player_id)AS TotAsist,
                
				  ( SELECT ps.player_id,SUM(ps.goals)
					FROM player_stats ps,player p 
					WHERE ps.player_id=p.player_id 
                    AND p.edad BETWEEN "25" AND "33"
					GROUP BY ps.player_id)AS TotGoles,
                    
					  (	SELECT p.player_id,COUNT(g.game_id)AS npartidos ,COUNT(ps.assists) AS asistpartido
						FROM player_stats ps, game g,player p
						WHERE ps.game_id=g.game_id
                        AND ps.player_id=p.player_id
                        AND p.edad BETWEEN "25" AND "33"
                        GROUP BY p.player_id) AS AsistPartido,
								(SELECT p.player_id,SUM(ps.assists)/TotPartidos.PartidosTot  AS mediaAsistPartido,SUM(ps.assists) TotAsist
								  FROM player_stats ps, game g,player p,(SELECT p.player_id,COUNT(g.game_id) AS PartidosTot
																		FROM player_stats ps, game g,player p
																		WHERE ps.game_id=g.game_id
																		AND ps.player_id=p.player_id
																		AND p.edad BETWEEN "25" AND "33"
																		GROUP BY p.player_id)AS TotPartidos
								WHERE ps.game_id=g.game_id
								AND ps.player_id=p.player_id
								AND p.edad BETWEEN "25" AND "33"
								AND p.player_id=TotPartidos.player_id
								GROUP BY p.player_id) AS MediaAsist,
                                
								  (	SELECT p.player_id,SUM(ps.goals)/TotPartidos.PartidosTot  AS mediaGolesPartido,SUM(ps.goals) AS TotGoles
									FROM player_stats ps, game g,player p,(SELECT p.player_id,COUNT(g.game_id) AS PartidosTot
																			FROM player_stats ps, game g,player p
																			WHERE ps.game_id=g.game_id
																			AND ps.player_id=p.player_id
																			AND p.edad BETWEEN "25" AND "33"
																			GROUP BY p.player_id)AS TotPartidos
									WHERE ps.game_id=g.game_id
									AND ps.player_id=p.player_id
									AND p.edad BETWEEN "25" AND "33"
									AND p.player_id=TotPartidos.player_id
									GROUP BY p.player_id ) AS MediaGoles
WHERE p.edad BETWEEN "25" AND "33"
AND TotAsist.player_id=p.player_id
AND TotGoles.player_id=p.player_id
AND MediaAsist.player_id=p.player_id
AND MediaGoles.player_id=p.player_id
GROUP BY p.firstName,p.lastName,p.edad;