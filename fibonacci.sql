/*Napisz procedurê wypisuj¹c¹ do konsoli ci¹g Fibonacciego. Procedura musi przyjmowaæ jako 
argument wejœciowy liczbê n. Generowanie ci¹gu Fibonacciego musi zostaæ 
zaimplementowane jako osobna funkcja, wywo³ywana przez procedurê.*/


-- funkcja
CREATE FUNCTION dbo.Fibonacci(@n INT) RETURNS INT
AS
BEGIN
    DECLARE @res INT;

    --  Fib(0) = 0
    IF @n = 0
        SET @res = 0;
    --  Fib(1) = 1
    ELSE IF @n = 1
        SET @res = 1;
    -- rekurencyjnie  Fib(n) = Fib(n-1) + Fib(n-2)
    ELSE
        SET @res = dbo.Fibonacci(@n - 1) + dbo.Fibonacci(@n - 2);

   
    RETURN @res;
END;
GO

-- procedura ktora drukuje n licz z ciagu
CREATE PROCEDURE dbo.PrintFibonacci @n INT
AS
BEGIN
    --  tymczasowa tabela ktora przechowuje wyniki
    DECLARE @Fibonacci TABLE (FibValue INT);

    -- wstawiamy  wyniki do tabeli tymczasowej
    INSERT INTO @Fibonacci
    SELECT dbo.Fibonacci(n)
    FROM (SELECT TOP (@n) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS n FROM sys.objects) AS Numbers;

    
    SELECT FibValue
    FROM @Fibonacci;
END;
GO

-- wywolujemy 
EXEC dbo.PrintFibonacci @n = 10;
