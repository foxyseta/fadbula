-- Operazione 14: visualizzare l'intreccio
SELECT "UnitaNarrativa"."Indice" AS "Indice",
	"UnitaNarrativa"."Nome" AS "Nome",
	"Evento"."Nome" AS "Evento"
FROM "UnitaNarrativa"
	JOIN "Intervallo" ON "Intervallo"."IstanteInizio" = "UnitaNarrativa"."IstanteInizio"
	AND "UnitaNarrativa"."IstanteFine" = "UnitaNarrativa"."IstanteFine"
	JOIN "Quando" ON "Quando"."IstanteInizio" = "Intervallo"."IstanteInizio"
	AND "Quando"."IstanteFine" = "Intervallo"."IstanteFine"
	JOIN "Evento" ON "Evento"."Codice" = "Quando"."Evento"
ORDER BY "UnitaNarrativa"."Indice"