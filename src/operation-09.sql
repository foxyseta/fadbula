-- Operazione 9: Dato un istante, visualizzare tutti gli agenti indicando se in vita o meno
SELECT *
FROM "Agente"
WHERE
	("Agente"."IstanteNascita" IS NULL OR
	"Agente"."IstanteNascita" <= '2023-01-06T09:00:00') AND
	("Agente"."IstanteMorte" IS NULL OR
	'2023-01-06T09:00:00' <= "Agente"."IstanteMorte")