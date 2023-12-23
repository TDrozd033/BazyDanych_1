
/*
1. Napisz zapytanie, które wykorzystuje transakcjê (zaczyna j¹), a nastêpnie aktualizuje cenê 
produktu o ProductID równym 680 w tabeli Production.Product o 10% i nastêpnie 
zatwierdza transakcjê.
*/
BEGIN TRANSACTION;
UPDATE Production.Product
SET ListPrice = ListPrice * 1.1
WHERE ProductID = 680;

--ROLLBACK TRANSACTION;
COMMIT TRANSACTION;

SELECT * FROM Production.Product
WHERE ProductID = 680;




/*
2. Napisz zapytanie, które zaczyna transakcjê, dodaje nowy produkt do tabeli 
Production.Product, a nastêpnie zatwierdza transakcjê.
*/
SELECT * FROM Production.Product
WHERE ProductID = 680;


BEGIN TRANSACTION;

INSERT INTO Production.Product ( Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, Size, SizeUnitMeasureCode, WeightUnitMeasureCode, Weight, DaysToManufacture, ProductLine, Class, ProductSubcategoryID, ProductModelID, SellStartDate, rowguid, ModifiedDate)
VALUES ( 'Nowy Produkt', 'KR-R93C-45', 1, 1, 'Red', 50, 25, 20.00, 49.99, 'Large', 'CM', 'LB', 2.5, 10, 'R', 'H', 1, 1, GETDATE(), NEWID(), GETDATE());
COMMIT TRANSACTION;

SELECT * FROM Production.Product

/*


3. Napisz zapytanie, które zaczyna transakcjê, usuwa produkt (o ProductID równym temu
dodanemu w poprzednim zadaniu) z tabeli Production.Product, ale nastêpnie wycofuje
transakcjê.
*/


BEGIN TRANSACTION;

DELETE FROM Production.Product
WHERE ProductID = 1004;

ROLLBACK TRANSACTION;

SELECT * FROM Production.Product
WHERE (ProductID >= 1000 AND ProductID <= 1005);

/*
4. Napisz zapytanie, które zaczyna transakcjê i aktualizuje StandardCost wszystkich produktów 
w tabeli Production.Product o 10%, je¿eli suma wszystkich StandardCost po aktualizacji nie 
przekracza 50000. W przeciwnym razie zapytanie powinno wycofaæ transakcjê
*/
BEGIN TRANSACTION;

UPDATE Production.Product
SET StandardCost = StandardCost * 1.1

IF (SELECT SUM(StandardCost) FROM Production.Product) > 50000
ROLLBACK;
ELSE
COMMIT;


SELECT SUM(StandardCost) AS TotalCost
FROM Production.Product;






/*
5. Napisz zapytanie SQL, które zaczyna transakcjê i próbuje dodaæ nowy produkt do tabeli 
Production.Product. Jeœli ProductNumber ju¿ istnieje w tabeli, zapytanie powinno wycofaæ 
transakcjê.
*/

BEGIN TRANSACTION;

INSERT INTO Production.Product ( Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, Size, SizeUnitMeasureCode, WeightUnitMeasureCode, Weight, DaysToManufacture, ProductLine, Class, ProductSubcategoryID, ProductModelID, SellStartDate, rowguid, ModifiedDate)
VALUES ( 'New_Product', 'WR-R94C-48', 1, 1, 'Green', 25, 40, 18.50, 44.99, 50, 'CM', 'LB', 2.0, 8, 'R', 'H', 2, 3, GETDATE(), NEWID(), GETDATE());
IF EXISTS( SELECT 1 FROM Production.Product WHERE ProductNumber = 'WR-R94C-48')
ROLLBACK;
ELSE
COMMIT;

SELECT * FROM Production.Product WHERE ProductNumber = 'WR-R94C-48';

/*
6. Napisz zapytanie SQL, które zaczyna transakcjê i aktualizuje wartoœæ OrderQty dla ka¿dego 
zamówienia w tabeli Sales.SalesOrderDetail. Je¿eli którykolwiek z zamówieñ ma OrderQty 
równ¹ 0, zapytanie powinno wycofaæ transakcjê.
*/

BEGIN TRANSACTION;

UPDATE Sales.SalesOrderDetail
SET OrderQty = OrderQty + 1

IF EXISTS( SELECT 1 FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
ROLLBACK;
ELSE 
COMMIT;

 SELECT * FROM Sales.SalesOrderDetail;


/*
7. Napisz zapytanie SQL, które zaczyna transakcjê i usuwa wszystkie produkty, których 
StandardCost jest wy¿szy ni¿ œredni koszt wszystkich produktów w tabeli 
Production.Product. Je¿eli liczba produktów do usuniêcia przekracza 10, zapytanie powinno 
wycofaæ transakcjê.
*/

BEGIN TRANSACTION;

DECLARE @AverageCost MONEY;

SELECT @AverageCost = AVG(StandardCost) FROM Production.Product;


DELETE FROM Production.Product
WHERE StandardCost > @AverageCost;

IF @@ROWCOUNT > 10
ROLLBACK;
ELSE
COMMIT;

SELECT * FROM Production.Product
WHERE StandardCost > 1800;

/* @ROWCOUNT przechowuje liczbê wierszy, które zosta³y ostatnio zmienione w wyniku ostatniego zapytania