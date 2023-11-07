CREATE SCHEMA IF NOT EXISTS rozliczenia;

/*pracownicy(id_pracownika, imie, nazwisko, adres, telefon) */
CREATE TABLE IF NOT EXISTS rozliczenia.pracownicy(
id_pracownika integer NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	imie text NOT NULL,
	nazwisko text NOT NULL,
	adres text NOT NULL,
	telefon text NOT NULL
);
/*godziny(id_godziny, data, liczba_godzin , id_pracownika),*/

CREATE TABLE IF NOT EXISTS rozliczenia.godziny(
id_godziny int NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	data date NOT NULL,
	liczba_godzin numeric(5,2) NOT NULL,
	id_pracownika integer NOT NULL,
	FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika)
);
/*PREmie(id_premii, rodzaj, kwota),*/
	CREATE TABLE IF NOT EXISTS rozliczenia.premie(
	id_premii int NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
		rodzaj text NOT NULL,
		kwota numeric(10,2) NOT NULL
	);



/*pensje(id_pensji, stanowisko, kwota, id_premii),*/
CREATE TABLE IF NOT EXISTS rozliczenia.pensje(
id_pensji int NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	stanowisko text NOT NULL,
	kwota numeric(10,2) NOT NULL,
	id_premii integer,
				  FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii)
);



ALTER TABLE rozliczenia.godziny
ADD FOREIGN KEY ( id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);

ALTER TABLE rozliczenia.pensje
ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);

SELECT * FROM rozliczenia.pracownicy

