USE practica2bda;

ALTER TABLE game DROP PRIMARY KEY;
ALTER TABLE game ADD PRIMARY KEY (game_id,date_time);      
/*Para poder realizar la particion correctamente necesitamos que date_time esté definido como clave en la tabla
game, por lo que borramos la clave anterior y generamos una nueva compuesta por game_id y date_time*/

ALTER TABLE game
	PARTITION BY RANGE(YEAR(date_time))
		(
			PARTITION partAñosMenores VALUES LESS THAN(2017),
			PARTITION part2017 VALUES LESS THAN (2018),
			PARTITION partOtrosAños VALUES LESS THAN MAXVALUE
        );
        