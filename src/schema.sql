BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Evento" (
	"Codice"	INTEGER NOT NULL,
	"Veridicità"	INTEGER NOT NULL CHECK("Veridicità" IN (0, 1)),
	PRIMARY KEY("Codice" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Fase" (
	"Indice"	INTEGER NOT NULL CHECK("Indice" >= 1),
	"Nome"	TEXT NOT NULL,
	PRIMARY KEY("Indice")
);
CREATE TABLE IF NOT EXISTS "Intervallo" (
	"Nome"	NUMERIC NOT NULL,
	"IstanteInizio"	TEXT NOT NULL CHECK("IstanteInizio" REGEXP "^((?:(\d{4}-\d{2}-\d{2})T(\d{2}:\d{2}:\d{2}(?:\.\d+)?))(Z|[\+-]\d{2}:\d{2})?)$"),
	"IstanteFine"	TEXT NOT NULL CHECK("IstanteFine" REGEXP "^((?:(\d{4}-\d{2}-\d{2})T(\d{2}:\d{2}:\d{2}(?:\.\d+)?))(Z|[\+-]\d{2}:\d{2})?)$" AND "IstanteInizio" <= "IstanteFine"),
	"Iterazione"	INTEGER CHECK("Iterazione" >= 1),
	"Fase"	INTEGER CHECK(CASE WHEN "Iterazione" IS NULL THEN "Fase" IS NULL ELSE "Fase" IS NOT NULL END),
	PRIMARY KEY("IstanteInizio","IstanteFine")
);
CREATE TABLE IF NOT EXISTS "Luogo" (
	"Nome"	TEXT NOT NULL,
	"X"	REAL NOT NULL CHECK("X" BETWEEN 0 AND 1),
	"Y"	REAL NOT NULL CHECK("Y" BETWEEN 0 AND 1),
	"Mappa"	INTEGER NOT NULL,
	PRIMARY KEY("X","Y","Mappa"),
	FOREIGN KEY("Mappa") REFERENCES "Mappa"("Codice") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "Mappa" (
	"Codice"	INTEGER NOT NULL,
	"Nome"	TEXT NOT NULL,
	"Immagine"	BLOB,
	"Larghezza"	INTEGER NOT NULL CHECK("Larghezza" >= 0),
	"Altezza"	INTEGER NOT NULL CHECK("Altezza" >= 0),
	PRIMARY KEY("Codice" AUTOINCREMENT)
);
COMMIT;
