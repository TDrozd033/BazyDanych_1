/*Napisz trigger DML, kt�ry po wprowadzeniu danych do tabeli Persons zmodyfikuje nazwisko 
tak, aby by�o napisane du�ymi literami. 
*/

CREATE OR ALTER TRIGGER my_trigger -- definiujemy trigger
ON Person.Person
AFTER INSERT -- trigger uruchamiany po dodaniu rekordu
AS
BEGIN 
UPDATE Person.Person
SET LastName = UPPER(Person.LastName)
FROM inserted
		WHERE Person.BusinessEntityID = inserted.BusinessEntityID
END;


/*
Przygotuj trigger �taxRateMonitoring�, kt�ry wy�wietli komunikat o b��dzie, je�eli nast�pi 
zmiana warto�ci w polu �TaxRate� o wi�cej ni� 30%*/


CREATE OR ALTER TRIGGER taxRateMonitoring
ON Sales.SalesTaxRate
AFTER UPDATE 
AS
BEGIN
	IF UPDATE(TaxRate)
	BEGIN 
		DECLARE @OldTaxRate DECIMAL(8, 4); -- deklarujemy 2 zmienne ktore przechowuja stare i nowe wartosci 
		DECLARE @NewTaxRate DECIMAL(8, 4);

		SELECT @OldTaxRate = TaxRate FROM deleted;
		SELECT @NewTaxRate = TaxRate FROM inserted;

		IF @NewTaxRate > @OldTaxRate*1.3
		BEGIN
			RAISERROR('Error: Stawka podatku nie moze przekroczyc 30%', 16, 1);
			ROLLBACK;
			RETURN;
		END;
	END;
END;


