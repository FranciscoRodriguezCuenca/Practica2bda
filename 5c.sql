CREATE TABLE `player_data` (
`player_id` int(11) NOT NULL,
`firstName` varchar(25) DEFAULT NULL,
`lastName` varchar(25) DEFAULT NULL,
`edad` int(11) DEFAULT NULL,
`goles` int(11) DEFAULT NULL,
`media_goles` decimal(10,5) DEFAULT NULL,
`asistencias` int(11) DEFAULT NULL,
`media_asistencias` int(11) DEFAULT NULL,
PRIMARY KEY (`player_id`),
CONSTRAINT `player_data_player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO player_data
(
	SELECT p.player_id, p.firstName, p.lastName, p.edad, p.goles, p.media_goles, SUM(ps.assists), AVG(ps.assists)
	FROM player p
		INNER JOIN player_stats ps ON p.player_id = ps.player_id
	GROUP BY p.player_id, p.firstName, p.lastName, p.edad, p.goles, p.media_goles
);

SELECT p.firstName, p.lastName, p.edad, p.goles, p.media_goles, p.asistencias, p.media_asistencias
FROM player_data p
WHERE p.edad > 25 and p.edad < 33;