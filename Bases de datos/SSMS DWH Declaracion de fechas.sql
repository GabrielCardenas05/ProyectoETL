-- 1. Declarar la fecha de inicio y fin
DECLARE @CurrentDate DATE = '2020-01-01';
DECLARE @EndDate DATE = '2030-12-31';

-- 2. Limpiar la tabla por si hiciste pruebas antes (Opcional, pero recomendado)
-- DELETE FROM Dim_Time;

-- 3. Iniciar el bucle para llenar los días
WHILE @CurrentDate <= @EndDate
BEGIN
    INSERT INTO Dim_Time ([Date], [Month], Quarter, [Year])
    VALUES (
        @CurrentDate,
        MONTH(@CurrentDate),
        DATEPART(QUARTER, @CurrentDate),
        YEAR(@CurrentDate)
    );

    -- Sumar 1 día para la siguiente vuelta del bucle
    SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
END

PRINT '¡Dim_Time cargada con éxito!';
GO