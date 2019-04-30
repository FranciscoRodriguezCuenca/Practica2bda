USE practica2bda;

DROP TRIGGER player_delete_trigger;

DELIMITER //

CREATE TRIGGER player_delete_trigger
BEFORE DELETE
   ON player FOR EACH ROW

BEGIN

   DELETE FROM player_data WHERE player_id = OLD.player_id;

END; //

DELIMITER ;