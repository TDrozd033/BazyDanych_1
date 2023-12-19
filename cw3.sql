/* Napisz zapytanie, które zwróci wartoœæ sprzeda¿y dla poszczególnych kategorii produktów.
Wykorzystaj CTE i bazê AdventureWorksLT.
*/

USE AdventureWorksLT2022; 

-- definicja cte
WITH SalesByCategory AS (
    --  wybieramy kategorie produktu i sume wartosci 
    SELECT pc.Name AS ProductCategory, SUM(sod.LineTotal) AS TotalSales
    FROM SalesLT.SalesOrderDetail AS sod
    INNER JOIN SalesLT.Product AS p ON sod.ProductID = p.ProductID
    INNER JOIN SalesLT.ProductCategory AS pc ON p.ProductCategoryID = pc.ProductCategoryID
    -- grupujemy wedlug nazwy kategorii
    GROUP BY pc.Name
)

-- wybieramy nazwe kategorii produktu i sume wartosci sprzedazy 
SELECT ProductCategory,TotalSales
FROM SalesByCategory;

