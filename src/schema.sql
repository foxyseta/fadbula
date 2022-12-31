BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Agente" (
	"Codice"	INTEGER NOT NULL,
	"Nome"	TEXT NOT NULL,
	"Immagine"	NUMERIC,
	"Sesso"	TEXT CHECK("Sesso" IN ('M', 'F')),
	"IstanteNascita"	TEXT CHECK("IstanteNascita" REGEXP '^((?:(\d{4}-\d{2}-\d{2})T(\d{2}:\d{2}:\d{2}(?:\.\d+)?))(Z|[\+-]\d{2}:\d{2})?)$'),
	"IstanteMorte"	TEXT CHECK("IstanteMorte" REGEXP '^((?:(\d{4}-\d{2}-\d{2})T(\d{2}:\d{2}:\d{2}(?:\.\d+)?))(Z|[\+-]\d{2}:\d{2})?)$' AND "IstanteNascita" < "IstanteMorte"),
	"Tipo"	TEXT CHECK("Tipo" IN ('Personaggio', 'Alias')),
	PRIMARY KEY("Codice" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Chi" (
	"Evento"	INTEGER NOT NULL,
	"Agente"	INTEGER NOT NULL,
	PRIMARY KEY("Evento","Agente"),
	FOREIGN KEY("Evento") REFERENCES "Evento"("Codice") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY("Agente") REFERENCES "Agente"("Codice") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "Credenza" (
	"Evento"	INTEGER NOT NULL,
	"Agente"	INTEGER NOT NULL,
	"IstanteInizio"	TEXT NOT NULL CHECK("IstanteInizio" REGEXP '^((?:(\d{4}-\d{2}-\d{2})T(\d{2}:\d{2}:\d{2}(?:\.\d+)?))(Z|[\+-]\d{2}:\d{2})?)$'),
	"IstanteFine"	TEXT NOT NULL CHECK("IstanteFine" REGEXP '^((?:(\d{4}-\d{2}-\d{2})T(\d{2}:\d{2}:\d{2}(?:\.\d+)?))(Z|[\+-]\d{2}:\d{2})?)$'),
	FOREIGN KEY("Evento") REFERENCES "Evento"("Codice") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY("Agente") REFERENCES "Agente"("Codice") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY("IstanteInizio") REFERENCES "Intervallo"("IstanteInizio") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY("IstanteFine") REFERENCES "Intervallo"("IstanteFine") ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY("IstanteFine","IstanteInizio","Agente","Evento")
);
CREATE TABLE IF NOT EXISTS "Dove" (
	"Evento"	INTEGER NOT NULL,
	"X"	REAL NOT NULL,
	"Y"	REAL NOT NULL,
	"Mappa"	INTEGER NOT NULL,
	PRIMARY KEY("Evento","X","Y","Mappa"),
	FOREIGN KEY("Evento") REFERENCES "Evento"("Codice") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY("X") REFERENCES "Luogo"("X") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY("Y") REFERENCES "Luogo"("Y") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY("Mappa") REFERENCES "Luogo"("Mappa") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "Evento" (
	"Codice"	INTEGER NOT NULL,
	"Nome"	TEXT NOT NULL,
	"Veridicita"	INTEGER NOT NULL CHECK("Veridicita" IN (0, 1)),
	PRIMARY KEY("Codice" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Fase" (
	"Indice"	INTEGER NOT NULL CHECK("Indice" >= 1),
	"Nome"	TEXT NOT NULL,
	PRIMARY KEY("Indice")
);
CREATE TABLE IF NOT EXISTS "Intervallo" (
	"Nome"	NUMERIC NOT NULL,
	"IstanteInizio"	TEXT NOT NULL CHECK("IstanteInizio" REGEXP '^((?:(\d{4}-\d{2}-\d{2})T(\d{2}:\d{2}:\d{2}(?:\.\d+)?))(Z|[\+-]\d{2}:\d{2})?)$'),
	"IstanteFine"	TEXT NOT NULL CHECK("IstanteFine" REGEXP '^((?:(\d{4}-\d{2}-\d{2})T(\d{2}:\d{2}:\d{2}(?:\.\d+)?))(Z|[\+-]\d{2}:\d{2})?)$' AND "IstanteInizio" <= "IstanteFine"),
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
	"Larghezza"	INTEGER NOT NULL CHECK("Larghezza" > 0),
	"Altezza"	INTEGER NOT NULL CHECK("Altezza" > 0),
	PRIMARY KEY("Codice" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Mascheramento" (
	"Personaggio"	INTEGER NOT NULL,
	"Alias"	INTEGER NOT NULL,
	PRIMARY KEY("Personaggio","Alias"),
	FOREIGN KEY("Personaggio") REFERENCES "Agente"("Codice") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY("Alias") REFERENCES "Agente"("Codice") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "Quando" (
	"Evento"	INTEGER NOT NULL,
	"IstanteInizio"	TEXT NOT NULL CHECK("IstanteInizio" REGEXP '^((?:(\d{4}-\d{2}-\d{2})T(\d{2}:\d{2}:\d{2}(?:\.\d+)?))(Z|[\+-]\d{2}:\d{2})?)$'),
	"IstanteFine"	TEXT NOT NULL CHECK("IstanteFine" REGEXP '^((?:(\d{4}-\d{2}-\d{2})T(\d{2}:\d{2}:\d{2}(?:\.\d+)?))(Z|[\+-]\d{2}:\d{2})?)$'),
	PRIMARY KEY("Evento","IstanteInizio","IstanteFine"),
	FOREIGN KEY("Evento") REFERENCES "Evento"("Codice") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY("IstanteInizio") REFERENCES "Intervallo"("IstanteInizio") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY("IstanteFine") REFERENCES "Intervallo"("IstanteFine") ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS "UnitaNarrativa" (
	"Indice"	TEXT NOT NULL CHECK("Indice" REGEXP "\d+(\.\d+)*"),
	"Nome"	TEXT NOT NULL,
	"IstanteInizio"	TEXT NOT NULL CHECK("IstanteInizio" REGEXP '^((?:(\d{4}-\d{2}-\d{2})T(\d{2}:\d{2}:\d{2}(?:\.\d+)?))(Z|[\+-]\d{2}:\d{2})?)$'),
	"IstanteFine"	TEXT NOT NULL CHECK("IstanteFine" REGEXP '^((?:(\d{4}-\d{2}-\d{2})T(\d{2}:\d{2}:\d{2}(?:\.\d+)?))(Z|[\+-]\d{2}:\d{2})?)$'),
	PRIMARY KEY("Indice"),
	FOREIGN KEY("IstanteInizio") REFERENCES "Intervallo"("IstanteInizio") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY("IstanteFine") REFERENCES "Intervallo"("IstanteFine") ON DELETE CASCADE ON UPDATE CASCADE
);
COMMIT;
