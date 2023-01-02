BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Evento" (
  "Codice" SERIAL NOT NULL,
  "Nome" TEXT NOT NULL,
  "Veridicita" INTEGER NOT NULL CHECK("Veridicita" IN (0, 1)),
  PRIMARY KEY("Codice")
);
CREATE TABLE IF NOT EXISTS "Agente" (
  "Codice" SERIAL NOT NULL,
  "Nome" TEXT NOT NULL,
  "Immagine" BYTEA,
  "Sesso" TEXT CHECK("Sesso" IN ('M', 'F')),
  "IstanteNascita" TEXT,
  "IstanteMorte" TEXT CHECK(
    "IstanteMorte" IS NULL
    OR "IstanteNascita" < "IstanteMorte"
  ),
  "Tipo" TEXT CHECK("Tipo" IN ('Personaggio', 'Alias')),
  PRIMARY KEY("Codice")
);
CREATE TABLE IF NOT EXISTS "Intervallo" (
  "Nome" NUMERIC NOT NULL,
  "IstanteInizio" TEXT NOT NULL,
  "IstanteFine" TEXT NOT NULL CHECK("IstanteInizio" <= "IstanteFine"),
  "Iterazione" INTEGER CHECK("Iterazione" >= 1),
  "Fase" INTEGER CHECK(
    CASE
      WHEN "Iterazione" IS NULL THEN "Fase" IS NULL
      ELSE "Fase" IS NOT NULL
    END
  ),
  PRIMARY KEY("IstanteInizio", "IstanteFine")
);
CREATE TABLE IF NOT EXISTS "Chi" (
  "Evento" INTEGER NOT NULL,
  "Agente" INTEGER NOT NULL,
  PRIMARY KEY("Evento", "Agente"),
  FOREIGN KEY("Evento") REFERENCES "Evento"("Codice"),
  FOREIGN KEY("Agente") REFERENCES "Agente"("Codice")
);
CREATE TABLE IF NOT EXISTS "Credenza" (
  "Evento" INTEGER NOT NULL,
  "Agente" INTEGER NOT NULL,
  "IstanteInizio" TEXT NOT NULL,
  "IstanteFine" TEXT NOT NULL,
  FOREIGN KEY("Evento") REFERENCES "Evento"("Codice"),
  FOREIGN KEY("Agente") REFERENCES "Agente"("Codice"),
  FOREIGN KEY("IstanteInizio", "IstanteFine") REFERENCES "Intervallo"("IstanteInizio", "IstanteFine"),
  PRIMARY KEY(
    "IstanteFine",
    "IstanteInizio",
    "Agente",
    "Evento"
  )
);
CREATE TABLE IF NOT EXISTS "Mappa" (
  "Codice" SERIAL NOT NULL,
  "Nome" TEXT NOT NULL,
  "Immagine" BYTEA,
  "Larghezza" INTEGER NOT NULL CHECK("Larghezza" > 0),
  "Altezza" INTEGER NOT NULL CHECK("Altezza" > 0),
  PRIMARY KEY("Codice")
);
CREATE TABLE IF NOT EXISTS "Luogo" (
  "Nome" TEXT NOT NULL,
  "X" REAL NOT NULL CHECK(
    "X" BETWEEN 0 AND 1
  ),
  "Y" REAL NOT NULL CHECK(
    "Y" BETWEEN 0 AND 1
  ),
  "Mappa" INTEGER NOT NULL,
  PRIMARY KEY("X", "Y", "Mappa"),
  FOREIGN KEY("Mappa") REFERENCES "Mappa"("Codice")
);
CREATE TABLE IF NOT EXISTS "Dove" (
  "Evento" INTEGER NOT NULL,
  "X" REAL NOT NULL,
  "Y" REAL NOT NULL,
  "Mappa" INTEGER NOT NULL,
  PRIMARY KEY("Evento", "X", "Y", "Mappa"),
  FOREIGN KEY("Evento") REFERENCES "Evento"("Codice"),
  FOREIGN KEY("X", "Y", "Mappa") REFERENCES "Luogo"("X", "Y", "Mappa")
);
CREATE TABLE IF NOT EXISTS "Fase" (
  "Indice" INTEGER NOT NULL CHECK("Indice" >= 1),
  "Nome" TEXT NOT NULL,
  PRIMARY KEY("Indice")
);
CREATE TABLE IF NOT EXISTS "Mascheramento" (
  "Personaggio" INTEGER NOT NULL,
  "Alias" INTEGER NOT NULL,
  PRIMARY KEY("Personaggio", "Alias"),
  FOREIGN KEY("Personaggio") REFERENCES "Agente"("Codice"),
  FOREIGN KEY("Alias") REFERENCES "Agente"("Codice")
);
CREATE TABLE IF NOT EXISTS "Quando" (
  "Evento" INTEGER NOT NULL,
  "IstanteInizio" TEXT NOT NULL,
),
"IstanteFine" TEXT NOT NULL,
PRIMARY KEY("Evento", "IstanteInizio", "IstanteFine"),
FOREIGN KEY("Evento") REFERENCES "Evento"("Codice"),
FOREIGN KEY("IstanteInizio", "IstanteFine") REFERENCES "Intervallo"("IstanteInizio", "IstanteFine")
);
CREATE TABLE IF NOT EXISTS "UnitaNarrativa" (
  "Indice" TEXT NOT NULL,
  "Nome" TEXT NOT NULL,
  "IstanteInizio" TEXT,
  "IstanteFine" TEXT,
  PRIMARY KEY("Indice"),
  FOREIGN KEY("IstanteInizio", "IstanteFine") REFERENCES "Intervallo"("IstanteInizio", "IstanteFine")
);
COMMIT;