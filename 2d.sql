USE practica2bda;

CREATE INDEX player_idx1
ON player (nationality, firstName, lastName, edad);

CREATE INDEX playerstats_idx1
ON player_stats (player_id);

