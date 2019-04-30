USE practica2bda;

BEGIN WORK;

DELIMITER //

CREATE  TRIGGER
player_trigger BEFORE INSERT
ON player FOR EACH ROW
BEGIN
	INSERT INTO `practica2bda`.`player`
		(`player_id`,
		`firstName`,
		`lastName`,
		`edad`,
		`goles`,
		`media_goles`)
	VALUES
		(NEW.player_id,
		NEW.firstName,
		NEW.lastName,
		NEW.edad,
		NEW.goles,
		NEW.media_goles );
END; //

DELIMITER ;
