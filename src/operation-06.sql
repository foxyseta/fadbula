-- Operazione 6: inserire nuovi eventi
INSERT INTO Evento("Codice", "Nome", "Veridicita")
VALUES
	(0, "Mamma chiede un favore", TRUE),
	(1, "Mamma mette in guardia", TRUE),
	(2, "Cappuccetto parte", TRUE),
	(3, "Cappuccetto incontra Lupo", TRUE),
	(4, "Lupo raggiunge nonna", TRUE),
	(5, "Lupo mangia nonna", TRUE),
	(6, "Cappuccetto raggiunge nonna", TRUE),
	(7, "Nonna è a letto", FALSE),
	(8, "Lupo mangia cappuccetto", TRUE),
	(9, "Il cacciatore soccorre", TRUE);
-- "Chi" correlati
INSERT INTO Chi("Evento", "Agente")
VALUES
    (0, 0),
	(0, 1),
	(1, 0),
	(1, 1),
	(2, 0),
	(2, 1),
	(3, 1),
	(3, 2),
	(4, 2),
	(5, 2),
	(5, 3),
	(6, 1),
	(7, 1),
	(7, 3),
	(8, 1),
	(8, 2),
	(9, 1),
	(9, 2),
	(9, 4),
	(9, 5);
-- "Quando" correlati
INSERT INTO Quando("Evento", "IstanteInizio", "Istantefine")
VALUES
	(0,
	'2023-01-02T06:00:00',
    '2023-01-02T06:30:00'),
	(1,
	'2023-01-02T06:00:00',
    '2023-01-02T06:30:00'),
	(2,
    '2023-01-02T06:30:00',
    '2023-01-02T07:30:00'),
	(3,
	'2023-01-02T08:30:00',
    '2023-01-02T09:00:00'),
	(4,
	'2023-01-02T10:30:00',
    '2023-01-02T11:00:00'),
	(5,
	'2023-01-02T10:30:00',
    '2023-01-02T11:00:00'),
	(6,
	'2023-01-02T10:30:00',
    '2023-01-02T11:00:00'),
	(7,
    '2023-01-02T10:30:00',
    '2023-01-02T11:30:00'),
	(8,
    '2023-01-02T11:30:00',
    '2023-01-02T12:30:00'),
	(9,
    '2023-01-02T11:30:00',
    '2023-01-02T12:30:00');
-- "Dove" correlati
INSERT INTO Dove("Evento", "X", "Y", "Mappa")
VALUES
	(0, 0.1, 0.1, 1),
	(1, 0.1, 0.1, 1),
	(2, 0.1, 0.1, 1),
	(3, 0.5, 0.5, 1),
	(4, 0.9, 0.9, 1),
	(5, 0.9, 0.9, 1),
	(6, 0.9, 0.9, 1),
	(7, 0.9, 0.9, 1),
	(8, 0.9, 0.9, 1),
	(9, 0.9, 0.9, 1);
-- Credenze correlate
INSERT INTO Credenza("Evento", "Agente", "IstanteInizio", "IstanteFine")
VALUES (7, 0, '2023-01-02T10:30:00', '2023-01-02T11:00:00')