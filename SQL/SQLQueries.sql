--Primary Observation on Data
SELECT 
      [location]
      ,[date]
      ,[total_cases]
      ,[new_cases]
      ,[total_deaths]
      ,[population]
  FROM [PortfolioProject].[dbo].[CovidDeaths]
    where Continent is not null --To Clean data in cases that location is filled with Continent name
  ORDER BY 1, 2

--Total Cases Vs Total Deaths
SELECT 
      [location]
      ,[date]
      ,[total_cases]
      ,[total_deaths]
      ,ROUND(([total_deaths]/[total_cases])*100,2) as DeathPercentage
  FROM [PortfolioProject].[dbo].[CovidDeaths]
    where Continent is not null
  ORDER BY 1, 2

--Total Cases VS Population
SELECT 
      [location]
      ,[date]
      ,[total_cases]
      ,[Population]
      ,ROUND(([total_cases]/[population])*100,2) as PercentPopulationInfected
  FROM [PortfolioProject].[dbo].[CovidDeaths]
    where Continent is not null
  ORDER BY 1, 2

--Countries with Highest Infection
--What country has gotten COVID most in comparion to its population
SELECT 
      [location]
	  ,[Population]
      ,MAX([total_cases]) HighestInfectiousCount
      ,MAX(ROUND(([total_cases]/[population])*100,2) )as PercentPopulationInfected
  FROM [PortfolioProject].[dbo].[CovidDeaths]
    where Continent is not null
  GROUP BY       [location] ,[Population]
  ORDER BY PercentPopulationInfected DESC


--Countries with Highest Death after Infectious
SELECT 
      [location]
      ,MAX([total_deaths]) TotalDeathCount
      --,MAX(ROUND(([total_deaths]/[population])*100,2) )as PercentPopulationDied
  FROM [PortfolioProject].[dbo].[CovidDeaths] 
  where Continent is not null
  GROUP BY       [location] 
  ORDER BY TotalDeathCount DESC

--Continents with Highest Death after Infectious
SELECT 
      Continent
      ,MAX([total_deaths]) TotalDeathCount
      --,MAX(ROUND(([total_deaths]/[population])*100,2) )as PercentPopulationDied
  FROM [PortfolioProject].[dbo].[CovidDeaths] 
  where Continent is not null
  GROUP BY       Continent 
  ORDER BY TotalDeathCount DESC

--Global Numbers
SELECT 
      [date]
      ,[total_cases]
      ,[total_deaths]
      ,ROUND(([total_deaths]/[total_cases])*100,2) as DeathPercentage
  FROM [PortfolioProject].[dbo].[CovidDeaths]
    where Continent is not null
GROUP BY       [date],[total_cases],[total_deaths]
  ORDER BY 1, 2
  
  --Death Rate Across world 
    SELECT SUM([new_cases]) as TotalCases
	  ,SUM([new_deaths]) as TotalDeath
	  ,ROUND((SUM([new_deaths])/SUM([new_cases]))*100 ,2) as DeathPercentage
  FROM [PortfolioProject].[dbo].[CovidDeaths]
    where Continent is not null
  ORDER BY 1
  --Death Rate Across world per date
  SELECT 
      [date]
      ,SUM([new_cases]) as TotalCases
	  ,SUM([new_deaths]) as TotalDeath
	  ,ROUND((SUM([new_deaths])/SUM([new_cases]))*100 ,2) as DeathPercentage
  FROM [PortfolioProject].[dbo].[CovidDeaths]
    where Continent is not null
GROUP BY       [date]
  ORDER BY 1

 --Let's Join Data :)
--Count of Vaccinated people
 select 
 dea.continent,
 dea.location,
 dea.date,
 dea.population,
 vac.[new_vaccinations],
 SUM( vac.[new_vaccinations]) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date) RollingPeopleVaccinated
 from [PortfolioProject].[dbo].[CovidDeaths] dea
 JOIN [PortfolioProject].[dbo].[CovidVaccinations] vac
   ON dea.location=vac.location and dea.date=vac.date
   where dea.continent is not null
 ORDER BY 2,3

 --Total Population VS Vaccination 
WITH CTE AS(
 select 
 dea.continent,
 dea.location,
 dea.date,
 dea.population,
 vac.[new_vaccinations],
 SUM( vac.[new_vaccinations]) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date) RollingPeopleVaccinated
 from [PortfolioProject].[dbo].[CovidDeaths] dea
 JOIN [PortfolioProject].[dbo].[CovidVaccinations] vac
   ON dea.location=vac.location and dea.date=vac.date
   where dea.continent is not null
)
SELECT 
*,ROUND((RollingPeopleVaccinated/population * 100),2) VaccinatedToPopulationPercentage
FROM CTE

--Create TEMP Table of RollingPeopleVaccinated
DROP TABLE IF EXISTS #RollingPeopleVaccinated
 select 
 dea.continent,
 dea.location,
 dea.date,
 dea.population,
 vac.[new_vaccinations],
 SUM( vac.[new_vaccinations]) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date) RollingPeopleVaccinated
 INTO #RollingPeopleVaccinated
 from [PortfolioProject].[dbo].[CovidDeaths] dea
 JOIN [PortfolioProject].[dbo].[CovidVaccinations] vac
   ON dea.location=vac.location and dea.date=vac.date
   where dea.continent is not null
 ORDER BY 2,3

--Create View for Visualizations
CREATE VIEW  PercentPopulationVaccinated as 
WITH CTE AS(
 select 
 dea.continent,
 dea.location,
 dea.date,
 dea.population,
 vac.[new_vaccinations],
 SUM( vac.[new_vaccinations]) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date) RollingPeopleVaccinated
 from [PortfolioProject].[dbo].[CovidDeaths] dea
 JOIN [PortfolioProject].[dbo].[CovidVaccinations] vac
   ON dea.location=vac.location and dea.date=vac.date
   where dea.continent is not null
)
SELECT 
*,ROUND((RollingPeopleVaccinated/population * 100),2) VaccinatedToPopulationPercentage
FROM CTE
