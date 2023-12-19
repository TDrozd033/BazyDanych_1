/*
Wykorzystuj¹c wyra¿enie CTE zbuduj zapytanie, które znajdzie informacje na temat stawki 
pracownika oraz jego danych, a nastêpnie zapisze je do tabeli tymczasowej 
TempEmployeeInfo. Rozwi¹¿ w oparciu o AdventureWorks
*/

USE AdventureWorks2022;
GO

-- definiujemy CTE i wstawiamy dane do tabeli tymczasowej 
WITH EmployeeSalaryInfo AS (
    SELECT p.BusinessEntityID, p.FirstName AS EmployeeFirstName, p.LastName AS EmployeeLastName, r.Rate AS SalaryRate
    FROM Person.Person AS p
    INNER JOIN HumanResources.EmployeePayHistory AS r
       ON p.BusinessEntityID = r.BusinessEntityID
    WHERE p.PersonType IN ('EM','SP') AND r.ModifiedDate = (
          SELECT MAX(ModifiedDate)
          FROM HumanResources.EmployeePayHistory
          WHERE BusinessEntityID = p.BusinessEntityID
       )
)

-- wsaawiamy dane z cte do tab tymczasowej
SELECT BusinessEntityID, EmployeeFirstName, EmployeeLastName, SalaryRate
INTO TempEmployeeInfo
FROM EmployeeSalaryInfo;

-- wyswietlamy dane 
SELECT * FROM TempEmployeeInfo;

