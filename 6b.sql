SELECT SQL_NO_CACHE p.lastName,p.firstName, TotPartidos.PartidosTot,TotJugadas.NumJugadas
FROM player p,player_stats ps,game g,player_plays pp,
			  (	SELECT p.player_id,COUNT(g.game_id) AS PartidosTot
				FROM player_stats ps, game g,player p
				WHERE ps.game_id=g.game_id
				AND ps.player_id=p.player_id
				GROUP BY p.player_id)AS TotPartidos,
                  (	SELECT p.player_id,COUNT(pp.play_id)AS NumJugadas
					FROM player p,player_plays pp
                    WHERE pp.player_id=p.player_id
                    GROUP BY p.player_id) AS TotJugadas
WHERE p.player_id=TotPartidos.player_id
AND p.player_id=TotJugadas.player_id
AND g.game_id=ps.game_id
AND ps.player_id=p.player_id
AND ps.player_id=pp.player_id
AND YEAR(g.date_time)=2017
GROUP BY p.lastName,p.firstName;
