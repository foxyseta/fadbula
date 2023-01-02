-- Operazione 11: dato un agente, visualizzare tutte le sue false credenze ordinate cronologicamente
SELECT "Evento"."Nome" AS "Falso evento",
	"Intervallo"."Nome" AS "Quando",
	"Intervallo"."IstanteInizio" AS "Inizio intervallo"
FROM "Credenza"
	JOIN "Evento" ON "Evento"."Codice" = "Credenza"."Evento"
	JOIN "Intervallo" ON "Intervallo"."IstanteInizio" = "Credenza"."IstanteInizio"
	AND "Intervallo"."IstanteFine" = "Credenza"."IstanteFine"
WHERE "Credenza"."Agente" = 0
	AND "Evento"."Veridicita" = FALSE