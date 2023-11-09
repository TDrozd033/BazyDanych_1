/*
a) Wyświetl tylko id pracownika oraz jego nazwisko.
b) Wyświetl id pracowników, których płaca jest większa niż 1000.
c) Wyświetl id pracowników nieposiadających premii, których płaca jest większa niż 2000.
d) Wyświetl pracowników, których pierwsza litera imienia zaczyna się na literę ‘J’.
e) Wyświetl pracowników, których nazwisko zawiera literę ‘n’ oraz imię kończy się na literę ‘a’.
f) Wyświetl imię i nazwisko pracowników oraz liczbę ich nadgodzin, przyjmując, iż standardowy
czas pracy to 160 h miesięcznie.
g) Wyświetl imię i nazwisko pracowników, których pensja zawiera się w przedziale 1500 – 3000
PLN.
h) Wyświetl imię i nazwisko pracowników, którzy pracowali w nadgodzinach i nie otrzymali
premii.
i) Uszereguj pracowników według pensji.
j) Uszereguj pracowników według pensji i premii malejąco.
k) Zlicz i pogrupuj pracowników według pola ‘stanowisko’.

l) Policz średnią, minimalną i maksymalną płacę dla stanowiska ‘kierownik’ (jeżeli takiego nie
masz, to przyjmij dowolne inne).
m) Policz sumę wszystkich wynagrodzeń.
n) Policz sumę wynagrodzeń w ramach danego stanowiska.
o) Wyznacz liczbę premii przyznanych dla pracowników danego stanowiska.
p) Usuń wszystkich pracowników mających pensję mniejszą niż 1200 zł
*/

/*a) Wyświetl tylko id pracownika oraz jego nazwisko.*/
SELECT id_pracownika, nazwisko
FROM ksiegowosc.pracownicy;

/*b) Wyświetl id pracowników, których płaca jest większa niż 1000.*/
SELECT ksiegowosc.wynagrodzenie.id_pracownika
FROM ksiegowosc.wynagrodzenie 
JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii
GROUP BY wynagrodzenie.id_pracownika
HAVING SUM(pensje.kwota + premie.kwota) > 1000.00;

/*c) Wyświetl id pracowników nieposiadających premii, których płaca jest większa niż 2000.*/

SELECT id_pracownika
FROM ksiegowosc.wynagrodzenie
LEFT JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii
JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
WHERE premie.kwota = 0 AND pensje.kwota > 2000;

/* d) Wyświetl pracowników, których pierwsza litera imienia zaczyna się na literę ‘J’.*/

SELECT *
FROM ksiegowosc.pracownicy
WHERE imie LIKE 'J%';

/* e) Wyświetl pracowników, których nazwisko zawiera literę ‘n’ oraz imię kończy się na literę ‘a’.*/
SELECT * 
FROM ksiegowosc.pracownicy
WHERE imie LIKE '%a' AND nazwisko LIKE '%n%';

/* f) Wyświetl imię i nazwisko pracowników oraz liczbę ich nadgodzin, przyjmując, iż standardowy
czas pracy to 160 h miesięcznie.*/
SELECT imie, nazwisko, (liczba_godzin - 160) AS nadgodziny
FROM ksiegowosc.godziny
JOIN ksiegowosc.pracownicy ON godziny.id_pracownika = pracownicy.id_pracownika -- przypisuje poszczegolnym id z tabeli godziny.id do tabeli z pracowninycy id--
WHERE liczba_godzin > 160;

/* g) Wyświetl imię i nazwisko pracowników, których pensja zawiera się w przedziale 1500 – 3000
PLN.*/
SELECT imie, nazwisko
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
WHERE kwota >=1500 AND kwota <= 3000;


/* h) Wyświetl imię i nazwisko pracowników, którzy pracowali w nadgodzinach i nie otrzymali
premii.*/
SELECT imie, nazwisko
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.godziny ON wynagrodzenie.id_godziny = godziny.id_godziny
JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii
JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
WHERE godziny.liczba_godzin > 160 AND premie.kwota = 0;

/*i) Uszereguj pracowników według pensji.*/
SELECT * 
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
ORDER BY pensje.kwota DESC;

/* w tych laczeniach chodzi o to zeby za pomoca tej tabeli wynagrodzenie zrobic sobie polaczenia
czyli potrzebne w danej czesci polecenia to biore tabele co mam tą informacje i łącze z tabelka
wynagrodzenie.id_odpowiadajacaczesc ( to czego szukamy np pensje) i przypisujemy to do tej
tabelki z ktorej bierzemy czyli np pensje.id_pensji
i wtedy do tej kolumny id_pensji w tabeli wynagrodzenie przypisuje sie cala tabele pensje
dzieki temu mozemy uzywac kolumn z tabeli pensje za pomoca tabeli wynagrodzenie 
czyli jest polaczona */

/* DESC  - sortuje malejaco, ASC - rosnaco 

ORDER BY - sluzy do sortowania 
JOIN - laczenie tabel
JOIN nazwa tabeli ktora lacze ON kolumna z tabeli z ktorej laczymy = kolumna ta sama z tabeli tej przed ON */

/* j) Uszereguj pracowników według pensji i premii malejąco.*/

SELECT imie, nazwisko, (pensje.kwota + premie.kwota) AS wyplata
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii
ORDER BY (pensje.kwota + premie.kwota )DESC;


/* k) Zlicz i pogrupuj pracowników według pola ‘stanowisko’.*/
SELECT stanowisko, COUNT(*) AS liczba_pracownikow
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
GROUP BY stanowisko;

/* GROUP BY  - grupuje wedlug danych kryteriow
count(*) zlicza liczbe pracownikow*/

/* l) Policz średnią, minimalną i maksymalną płacę dla stanowiska ‘kierownik’ (jeżeli takiego nie
masz, to przyjmij dowolne inne).*/
SELECT stanowisko, AVG(kwota) AS srednia_pensja, MIN(kwota) AS minimalna_pensja, MAX(kwota) AS maksymalna_pensja
 FROM ksiegowosc.pensje
WHERE stanowisko = 'Kierownik'
GROUP BY stanowisko;

/* m) Policz sumę wszystkich wynagrodzeń.*/
SELECT SUM(pensje.kwota+ premie.kwota) AS suma_wynagrodzen
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii;

/* n) Policz sumę wynagrodzeń w ramach danego stanowiska.*/
SELECT stanowisko, SUM(pensje.kwota+ premie.kwota) AS suma_wynagrodzen
FROM ksiegowosc.wynagrodzenie
 JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
 JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii
GROUP BY stanowisko;

/* o) Wyznacz liczbę premii przyznanych dla pracowników danego stanowiska.*/
SELECT stanowisko, COUNT(id_premii) liczba_premii
FROM ksiegowosc.wynagrodzenie
 JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
GROUP BY stanowisko;

/* p) Usuń wszystkich pracowników mających pensję mniejszą niż 1200 zł
DELETE FROM ksiegowosc.pracownicy
WHERE id_pracownika IN (SELECT id_pracownika
					   FROM ksiegowosc.wynagrodzenie
					   JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
					   WHERE kwota < 1200);
*/
SELECT * FROM ksiegowosc.pracownicy