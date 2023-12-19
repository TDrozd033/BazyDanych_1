USE AdventureWorks2022;

-- definiujemy cte
WITH CompanySalesInfo AS (
   SELECT CONCAT(cs.CompanyName, ' (', pp.Firstname, ' ', pp.Lastname, ')') AS ClientContact, SUM(od.TotalDue) AS TotalSales
    FROM AdventureWorksLT2022.SalesLT.Customer AS cs
    INNER JOIN AdventureWorksLT2022.SalesLT.SalesOrderHeader AS od ON cs.CustomerID = od.CustomerID
    INNER JOIN AdventureWorks2022.HumanResources.Employee AS emp ON cs.CustomerID = emp.BusinessEntityID
    INNER JOIN AdventureWorks2022.Person.Person AS pp ON emp.BusinessEntityID = pp.BusinessEntityID
    -- grupujemy wyniki wedlug nazwy firmy imienia i nazwiska klienta 
    GROUP BY cs.CompanyName, pp.Firstname, pp.Lastname
)
SELECT ClientContact TotalSales
FROM CompanySalesInfo;