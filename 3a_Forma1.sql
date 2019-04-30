SELECT SQL_NO_CACHE t.team_id,t.teamName,DatosGolesPartidos.media AS media_goles_partido,totaltiros.ttiros AS total_tiros,DatosGolesPartidos.PartidosTotales
FROM game g, team t,team_stats st,
	(	SELECT st.team_id,AVG(st.tgoals)as media,SUM(st.tgoals)AS GolesTotales,COUNT(g.game_id)AS PartidosTotales
		FROM game g,team_stats st
		WHERE g.game_id=st.game_id
		AND g.date_time BETWEEN '2017-07-01' AND '2017-12-31'
		GROUP BY st.team_id
	) 
		AS DatosGolesPartidos,
    (
		SELECT st.team_id,SUM(st.tshots) AS ttiros
		FROM game g, team_stats st 
		WHERE g.game_id=st.game_id
		AND g.date_time BETWEEN '2017-07-01' AND '2017-12-31'
		GROUP BY st.team_id
    )AS totaltiros
WHERE t.team_id=totaltiros.team_id
	AND t.team_id=DatosGolesPartidos.team_id
    AND g.game_id=st.game_id
    AND  DatosGolesPartidos.PartidosTotales IN (SELECT MAX(a.num_partidos) AS num_partidos
												FROM (SELECT st.team_id,COUNT(g.game_id) AS num_partidos
														FROM team_stats st, game g
														WHERE g.game_id=st.game_id
															AND g.date_time BETWEEN '2017-07-01' AND '2017-12-31'
														GROUP BY st.team_id
													)AS a
										)
GROUP BY t.team_id,t.teamName;


