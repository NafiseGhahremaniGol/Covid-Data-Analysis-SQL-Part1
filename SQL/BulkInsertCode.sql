--Bulk Insert Time :) !
BULK INSERT dbo.CovidDeaths
FROM 'D:\Data Analysis Projects\Part 1\CovidDeaths-Edited.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,  -- چون ردیف اول هدر هست
    FIELDTERMINATOR = ',',  -- جداکننده ستون‌ها
    ROWTERMINATOR = '\n',   -- جداکننده ردیف‌ها
    TABLOCK
);


BULK INSERT dbo.CovidVaccinations
FROM 'D:\Data Analysis Projects\Part 1\CovidVaccination-Edited.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
