-- Operazione 12: dato un agente e un evento, visualizzare eventuali intervalli di tempo in
-- cui il primo crede che sia avvenuto il secondo
SELECT "Intervallo"."Nome",
	"Intervallo"."IstanteInizio",
	"Intervallo"."IstanteFine"
FROM "Credenza"
	JOIN "Intervallo" ON "Intervallo"."IstanteInizio" = "Credenza"."IstanteInizio"
	AND "Intervallo"."IstanteFine" = "Intervallo"."IstanteFine"
WHERE "Credenza"."Agente" = 0
	AND "Credenza"."Evento" = 7