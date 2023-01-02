-- Operazione 8: dato un agente, visualizzarne tutti gli alias
SELECT "Codice", "Nome", "Sesso", "IstanteNascita", "IstanteMorte"
FROM "Agente"
JOIN "Mascheramento"
	ON "Mascheramento"."Alias" = "Agente"."Codice"
WHERE "Mascheramento"."Personaggio" = 2