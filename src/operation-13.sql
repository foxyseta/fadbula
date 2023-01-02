-- Operazione 13: visualizzare la fabula
SELECT "Evento"."Nome" AS "Evento",
	"Intervallo"."Nome" AS "Intervallo"
FROM "Evento"
	JOIN "Quando" ON "Quando"."Evento" = "Evento"."Codice"
	JOIN "Intervallo" ON "Intervallo"."IstanteInizio" = "Quando"."IstanteInizio"
	AND "Intervallo"."IstanteFine" = "Quando"."IstanteFine"
WHERE "Veridicita" = TRUE
ORDER BY "Intervallo"."IstanteInizio"