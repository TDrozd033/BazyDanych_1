/* ZADANIE 7: */

ALTER TABLE rozliczenia.pensje
RENAME COLUMN kwota TO kwota_brutto;


ALTER TABLE rozliczenia.pensje
ADD kwota_netto numeric(10,2);

UPDATE rozliczenia.pensje
SET kwota_netto = kwota_brutto * 0.77;

SELECT*FROM rozliczenia.pensje
