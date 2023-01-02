-- Operazione 16: 
SELECT "Quando"."IstanteInizio" AS "Da", "Quando"."IstanteFine" AS "A", "Luogo"."Nome"
FROM "Luogo"
JOIN "Dove"
	ON "Dove"."X" = "Luogo"."X" AND "Dove"."Y" = "Luogo"."Y" AND "Dove"."Mappa" = "Luogo"."Mappa"
JOIN "Quando"
	ON "Quando"."Evento" = "Dove"."Evento"
JOIN "Chi"
	ON "Dove"."Evento" = "Chi"."Evento" AND "Chi"."Agente" = 0