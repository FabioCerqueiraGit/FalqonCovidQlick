-- Cria a tabela DimCalendario
CREATE TABLE DimCalendario (
    Data_Completa DATE PRIMARY KEY,
    Dia_Numero INT,
    Mes_Numero INT,
    Ano_Numero INT,
    Mes_Nome NVARCHAR(20),
    Bimestre INT,
    Trimestre INT,
    Semestre INT
);

-- Insere os dados na tabela DimCalendario
WITH DateSeries AS (
    SELECT CAST('2020-01-01' AS DATE) AS Data_Completa
    UNION ALL
    SELECT DATEADD(DAY, 1, Data_Completa)
    FROM DateSeries
    WHERE Data_Completa < '2025-01-01'
)
INSERT INTO DimCalendario (Data_Completa, Dia_Numero, Mes_Numero, Ano_Numero, Mes_Nome, Bimestre, Trimestre, Semestre)
SELECT 
    Data_Completa,
    DAY(Data_Completa) AS Dia_Numero,
    MONTH(Data_Completa) AS Mes_Numero,
    YEAR(Data_Completa) AS Ano_Numero,
    DATENAME(MONTH, Data_Completa) AS Mes_Nome,
    ((MONTH(Data_Completa)-1)/2) + 1 AS Bimestre,
    ((MONTH(Data_Completa)-1)/3) + 1 AS Trimestre,
    ((MONTH(Data_Completa)-1)/6) + 1 AS Semestre
FROM DateSeries
OPTION (MAXRECURSION 0);

-- Verifica se os dados foram inseridos corretamente no formato brasileiro
SELECT 
    FORMAT(Data_Completa, 'dd/MM/yyyy') AS Data_Completa,
    Dia_Numero,
    Mes_Numero,
    Ano_Numero,
    Mes_Nome,
    Bimestre,
    Trimestre,
    Semestre
FROM DimCalendario
ORDER BY Data_Completa;
