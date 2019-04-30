USE practica2bda;

DROP TRIGGER player_stats_update_trigger;

DELIMITER //
CREATE TRIGGER
player_stats_update_trigger AFTER UPDATE
ON player_stats FOR EACH ROW
BEGIN
	UPDATE `practica2bda`.`player_data`
	SET
		`asistencias` = (
				SELECT SUM(ps.assists)
				FROM player_stats ps
				WHERE player_id = NEW.player_id
			),
		`media_asistencias` = (
				SELECT AVG(ps.assists)
				FROM player_stats ps
				WHERE player_id = NEW.player_id
			)
	WHERE `player_id` = NEW.player_id;
END; //

DELIMITER ;