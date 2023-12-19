-- A. kita melihat data kita terlebih dahulu pada bagian kasus covid
SELECT *
FROM  latihansoal.tabel_kasus_covid


-- A1. kita akan melihat perkembangan kasus covid-19 yang ada di Indonesia sepanjang 2020-2023 berdasarkan kasus infeksi

SELECT location
	,date
    ,population
    ,total_cases
    ,(total_cases/population)*100 AS percentage_cases
    ,new_cases
    ,SUM(new_cases) OVER (PARTITION BY location ORDER BY YEAR(date), location) AS total_cases_per_year
FROM  latihansoal.tabel_kasus_covid
WHERE total_cases > 1
	AND location = 'Indonesia'
-- ORDER BY new_cases DESC

-- A2. bukti bahwa total_cases_per_year benar 
SELECT SUM(new_cases)
FROM  latihansoal.tabel_kasus_covid
WHERE date BETWEEN '2020-01-01' AND '2020-12-31'
	AND location = 'Indonesia'
;

-- A3. kita akan melihat kasus kematian yang diakibatkan covid-19 tahun 2020-2023

SELECT location
	,date
	,total_cases
    ,total_deaths
    ,(total_deaths/total_cases)*100 AS percentage_deaths
    ,new_deaths
    ,SUM(new_deaths) OVER (PARTITION BY YEAR(date)) AS total_death_per_year
FROM  latihansoal.tabel_kasus_covid
WHERE total_cases > 1
	AND location = 'Indonesia'
;

-- A.4 bukti bahwa total_deaths_per_year sama

SELECT SUM(new_deaths)
FROM  latihansoal.tabel_kasus_covid
WHERE date BETWEEN '2023-01-01' AND '2023-12-31'
	AND location = 'Indonesia'
;

-- B. kita melihat data kita terlebih dahulu pada bagian vaksin covid
SELECT *
FROM  latihansoal.tabel_vaksin_covid

-- B1. kita akan melihat bagian perkembangan vaksinasi di Indoensia selama 2020 - 2023
SELECT location
	,date
    ,population
    ,total_vaccinations
    ,people_vaccinated
    ,(people_vaccinated/total_vaccinations)*100 AS percentage_use_vaccinations
    ,(people_vaccinated/population)*100 AS percentage_vaccinated
    ,new_vaccinations
    ,SUM(new_vaccinations) OVER (PARTITION BY YEAR(date)) AS total_vaccincations_per_Year
FROM  latihansoal.tabel_vaksin_covid
WHERE location = 'Indonesia'
ORDER BY SUM(new_vaccinations) OVER (PARTITION BY YEAR(date)) DESC
;
 
SELECT new_vaccinations
	,date
    ,SUM(new_vaccinations) OVER (PARTITION BY YEAR(date)) AS total_vaccincations_per_Year
FROM  latihansoal.tabel_vaksin_covid
WHERE location = 'Indonesia'

-- SEMENTARA ITU SAJA DULU, AKAN ADA UPDATE SELANJUTNYA
