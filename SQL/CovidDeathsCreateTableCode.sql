--Note for those who use these datasets:
--Struggling with the Import Wizard too? Congrats, you’re officially one of us!
--Alright, let’s suffer together and do it the hard way 
USE PortfolioProject;
GO

CREATE TABLE dbo.CovidDeaths (
    iso_code NVARCHAR(20),
    continent NVARCHAR(50),
    location NVARCHAR(100),
    date DATE,
    population BIGINT,
    total_cases FLOAT,
    new_cases FLOAT,
    new_cases_smoothed FLOAT,
    total_deaths FLOAT,
    new_deaths FLOAT,
    new_deaths_smoothed FLOAT,
    total_cases_per_million FLOAT,
    new_cases_per_million FLOAT,
    new_cases_smoothed_per_million FLOAT,
    total_deaths_per_million FLOAT,
    new_deaths_per_million FLOAT,
    new_deaths_smoothed_per_million FLOAT,
    reproduction_rate FLOAT,
    icu_patients FLOAT,
    icu_patients_per_million FLOAT,
    hosp_patients FLOAT,
    hosp_patients_per_million FLOAT,
    weekly_icu_admissions FLOAT,
    weekly_icu_admissions_per_million FLOAT,
    weekly_hosp_admissions FLOAT,
    weekly_hosp_admissions_per_million FLOAT
);
