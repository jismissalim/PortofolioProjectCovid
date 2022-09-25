select *
from PortofolioProject..CovidDeaths
where continent is not null
order by 3,4
-- karena pada table data terdapat pada kolom continent not null

--select *
--from PortofolioProject..[Covid Vaksin]
--order by 3,4

select location, date, total_cases, new_cases, total_deaths, population
from PortofolioProject..CovidDeaths
where continent is not null
order by 1,2

-- Looking at Total cases vs total deaths
-- shows likelihood of dying if you contract covid in your country

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PortofolioProject..CovidDeaths
where location='United States'
and continent is not null
order by 1,2

-- Looking at Total cases vs population
-- shows what percentage of population got  covid
select location, date, total_cases, population, (total_cases/population)*100 as DeathPercentage
from PortofolioProject..CovidDeaths
where continent is not null
order by 1,2

-- Looking at Countries with Highest Infection Rate compared to Population
select location, MAX(total_cases) as HighestInfectionCount, population, MAX((total_cases/population))*100 as PercentPopulationInfected
from PortofolioProject..CovidDeaths
where continent is not null
group by location, population
-- group by digunakan untuk mengelompokkan kolom dalam satu grup (lokasi dan populasi) yang memiliki nilai sama
order by PercentPopulationInfected desc

-- Showing Percentage Countries with Highest Death Count per Population
select location, MAX(total_deaths) as Total_Death_Count, population, MAX((total_deaths/population))*100 as Percent_Population_Deaths
from PortofolioProject..CovidDeaths
where continent is not null
group by location, population
order by Percent_Population_Deaths desc

-- Showing Countries with Highest Death Count per Population
select location, Max(cast(total_deaths as int)) as Total_Death_Count
-- mengubah jenis data menggunakan cast karena pada kolom total_death bersifat int bukan nvarchar
from PortofolioProject..CovidDeaths
where continent is not null
group by location
order by Total_Death_Count desc;


-- LETS BREAK THINGS DOWN BY CONTINENT
select continent, Max(cast(total_deaths as int)) as Total_Death_Count
-- mengubah jenis data menggunakan cast karena pada kolom total_death bersifat int bukan nvarchar
from PortofolioProject..CovidDeaths
where continent is not null
group by continent
order by Total_Death_Count desc;

-- Showing continents with highest death count
select continent, Max(cast(total_deaths as int)) as Total_Death_Count
-- mengubah jenis data menggunakan cast karena pada kolom total_death bersifat int bukan nvarchar
from PortofolioProject..CovidDeaths
where continent is not null
group by continent
order by Total_Death_Count desc;


-- Global Numbers
select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/Sum(new_cases)*100 as Death_Percetage
from PortofolioProject..CovidDeaths
--where location='United States'
where continent is not null
order by 1,2


-- Looking at Total Population vs Vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
Sum(convert(bigint,vac.new_vaccinations)) Over (Partition by dea.location) as Rolling_People_Vaccinated
from PortofolioProject..CovidDeaths dea
join PortofolioProject..CovidVaksin vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3 

-- Creating view to store data for later visual
Create view





