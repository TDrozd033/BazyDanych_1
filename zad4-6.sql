/* ZADANIE 4: */
INSERT INTO rozliczenia.pracownicy(imie, nazwisko, adres, telefon)
VALUES
('Mikołaj', 'Kowalski', 'ul. Kwiatowa 5', '123456789'),
('Krzysztof', 'Nowak', 'ul. Słoneczna 10', '987654321'),
('Tomasz', 'Wiśniewski', 'ul. Polna 15', '555123789'),
('Cristiano', 'Lewandowski', 'ul. Główna 20', '777888999'),
('Leo', 'Duda', 'ul. Wiejska 25', '333444555'),
('Roman', 'Jagiello', 'ul. Leśna 30', '111222333'),
('Stanisław', 'Wójcik', 'ul. Morska 35', '666999111'),
('Jacek', 'Placek', 'ul. Krótka 40', '888777666'),
('Wojciech', 'Jankowski', 'ul. Rycerska 45', '222333444'),
('Tadeusz', 'Kamiński', 'ul. Nowa 50', '999000111');

INSERT INTO rozliczenia.godziny( data, liczba_godzin, id_pracownika)
VALUES
 ('2021-08-01', 55, 1),
    ('2022-07-08', 68, 2),
    ('2022-06-17', 31, 3),
    ('2023-10-15', 56, 4),
    ('2023-09-16', 75, 5),
    ('2023-01-14', 43, 6),
    ('2021-02-21', 55, 7),
    ('2020-03-21', 65, 8),
    ('2021-04-09', 70, 9),
    ('2022-05-10', 37, 10);
	
	INSERT INTO rozliczenia.premie(rodzaj, kwota)
	VALUES
	('Premia za rok', 4000.00),
	('Premia za miesiąc', 1000.00),
	('Premia za tydzień', 500.00),
	('Premia za rok', 7000.00),
	('Premia za rok', 6000.00),
	('Premia za tydzień', 400.00),
	('Premia za tydzień', 700.00),
	('Premia za miesiąc', 2000.00),
	('Premia za miesiąc', 1500.00),
	('Premia za rok',9000.00);
	
	INSERT INTO rozliczenia.pensje(stanowisko, kwota, id_premii)
	VALUES
	 ('Szef', 20000.00, 1),
    ('Asystent', 8000.00, 2),
    ('Grafik', 6000.00, 3),
    ('Asystent', 7000.00, 4),
    ('Konsultant', 4500.00, 5),
    ('Kierownik', 10000.00, 6),
    ('Zastępca kierownika', 7500.00, 7),
    ('Manager', 12000.00, 8),
    ('Analityk finansowy', 7500.00, 9),
    ('Kucharz', 5500.00, 10);
	
	/* ZADANIE 5:*/
	SELECT nazwisko, adres
	FROM rozliczenia.pracownicy;
	
	/* ZADANIE 6:*/
	SELECT DATE_PART('day', data), DATE_PART('month', data)
FROM rozliczenia.godziny
	



	
	
	
	
	
	