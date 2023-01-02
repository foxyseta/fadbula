-- Operazione 10: dato un luogo, visualizzare tutti quelli presenti nella stessa mappa 
SELECT
	"Luogo"."Nome" AS "Nome luogo",
	"X" * "Larghezza" AS "X",
	"Y" * "Altezza" AS "Y",
	"Mappa"."Nome" AS "Nome mappa"
FROM "Luogo"
JOIN "Mappa"
	ON "Mappa"."Codice" = "Luogo"."Mappa"
-- Siccome il codice della mappa appartiene alla chiave primaria
-- del luogo, se possiedo un riferimento a esso lo stesso vale
-- per il codice della mappa.
WHERE "Mappa"."Codice" = 0