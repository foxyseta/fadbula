-- Operazione 1: inserire nuovi agenti
INSERT INTO "Agente"(
		"Codice",
		"Nome",
		"Immagine",
		"Sesso",
		"IstanteNascita",
		"IstanteMorte",
		"Tipo"
	)
VALUES (
		0,
		'Cappuccetto Rosso',
		NULL,
		'F',
		'2010-01-19T15:21:12',
		NULL,
		'Personaggio'
	),
	(
		1,
		'Mamma',
		NULL,
		'F',
		'1986-01-19T12:24:10',
		NULL,
		'Personaggio'
	),
	(
		2,
		'Lupo Cattivo',
		NULL,
		'M',
		'2016-02-09T12:28:09',
		'2023-01-02T12:00:00',
		'Personaggio'
	),
	(
		3,
		'Nonna',
		NULL,
		'F',
		'1947-06-10T12:28:09',
		NULL,
		'Personaggio'
	),
	(
		4,
		'Finta Nonna',
		NULL,
		'F',
		'1947-06-10T12:28:09',
		'2023-01-02T12:00:00',
		'Alias'
	),
	(
		5,
		'Cacciatore',
		NULL,
		'M',
		'1970-10-11T23:56:23',
		NULL,
		'Personaggio'
	);
-- Mascheramenti correlati
INSERT INTO "Mascheramento"("Personaggio", "Alias")
VALUES (2, 4)