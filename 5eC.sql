USE practica2bda;

DROP TRIGGER player_update_trigger;

DELIMITER //
CREATE TRIGGER
player_update_trigger AFTER UPDATE
ON player FOR EACH ROW
BEGIN
	UPDATE `practica2bda`.`player_data`
	SET
		`player_id` = NEW.player_id,
		`firstName` = (
				SELECT firstName
				FROM player
				WHERE player_id = NEW.player_id
        ),
		`lastName` = (
				SELECT lastName
				FROM player
				WHERE player_id = NEW.player_id
        ),
		`edad` = (
				SELECT edad
				FROM player
				WHERE player_id = NEW.player_id
        ),
		`goles` = (
				SELECT goles
				FROM player
				WHERE player_id = NEW.player_id
        ),
		`media_goles` = (
				SELECT media_goles
				FROM player
				WHERE player_id = NEW.player_id
        )
	WHERE `player_id` = NEW.player_id;
END; //

DELIMITER ;