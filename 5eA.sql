USE practica2bda;

DROP TRIGGER player_insert_trigger;

DELIMITER //

CREATE TRIGGER
player_insert_trigger AFTER INSERT
ON player FOR EACH ROW
BEGIN
	INSERT INTO `practica2bda`.`player_data`
		(`player_id`,
		`firstName`,
		`lastName`,
		`edad`,
		`goles`,
		`media_goles`,
        `asistencias`,
        `media_asistencias`)
	VALUES
		(
			NEW.player_id,
			NEW.firstName,
			NEW.lastName,
			NEW.edad,
			NEW.goles,
			NEW.media_goles,
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