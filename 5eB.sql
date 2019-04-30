USE practica2bda;

DROP TRIGGER player_stats_insert_trigger;

DELIMITER //

CREATE TRIGGER
player_stats_insert_trigger AFTER INSERT
ON player_stats FOR EACH ROW
BEGIN
	INSERT INTO `practica2bda`.`player_data`
		(`asistencias`,
        `media_asistencias`)
	VALUES
		(
			(
				SELECT SUM(ps.assists)
				FROM player_stats ps
				WHERE player_id = NEW.player_id
			),
			(
				SELECT AVG(ps.assists)
				FROM player_stats ps
				WHERE player_id = NEW.player_id
			)
        );
END; //

DELIMITER ;

