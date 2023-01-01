-- Operazione 7: inserire nuove unita' narrative
INSERT INTO UnitaNarrativa(Indice, Nome, IstanteInizio, IstanteFine)
VALUES (
    '1',
    'Inizio',
    '2023-01-02T06:00:00',
    '2023-01-02T06:30:00'
  ),
  ('2', 'Svolgimento', NULL, NULL),
  (
    '2.1',
    'Passeggiata',
    '2023-01-02T06:30:00',
    '2023-01-02T07:30:00'
  ),
  (
    '2.2',
    'Strano incontro',
    '2023-01-02T08:30:00',
    '2023-01-02T09:00:00'
  ),
  (
    '2.3',
    'Arrivo',
    '2023-01-02T10:30:00',
    '2023-01-02T11:00:00'
  ),
  (
    '3',
    'Fine',
    '2023-01-02T11:30:00',
    '2023-01-02T12:30:00'
  )