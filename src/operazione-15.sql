-- Operazione 15: visualizzare le mappe ordinate per estensione decrescente
SELECT "Codice", "Nome", "Larghezza" * "Altezza" AS "Area"
FROM "Mappa"
ORDER BY "Area" DESC