/* 
 * 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
 */

-- Budeme-li porovnávat trend mezd (růst/pokles/beze změny) mezi průmeřnou roční mzdou v jednotlivých letech a pro každé odvětví.
-- Tak dojdeme k zjištění, že v některých odvětvích došlo i k meziročnímu poklesu.

WITH TrendMezd AS (
    SELECT
        year,
        industry,
        average_salary,
        LAG(average_salary) OVER (PARTITION BY industry ORDER BY year) AS previous_wage
    FROM 
        t_petr_kral_project_SQL_primary_final
)
SELECT 
    year,
    industry,
    average_salary,
    previous_wage,
	CASE
	    WHEN average_salary > previous_wage THEN 'Increase'
	    WHEN average_salary < previous_wage THEN 'Decrease'
	    ELSE 'No change'
    END AS trend
FROM 
    TrendMezd
WHERE 
industry IS NOT null
ORDER BY 
    trend ASC 
   
-- Při srovnání mezd mezi prvním a posledním rokem sledovaného období zjistíme, že nárůst zaznamenala všechna odvětví.
WITH TrendMezd AS (
    SELECT 
        year, 
        industry, 
        average_salary,
        FIRST_VALUE(average_salary) OVER (PARTITION BY industry ORDER BY year ASC) AS first_salary,
        LAST_VALUE(average_salary) OVER (PARTITION BY industry ORDER BY year ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_salary,
        FIRST_VALUE(year) OVER (PARTITION BY industry ORDER BY year ASC) AS first_year,
        LAST_VALUE(year) OVER (PARTITION BY industry ORDER BY year ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_year
    FROM 
        t_petr_kral_project_SQL_primary_final
)
SELECT 
    industry,
    first_salary,
    last_salary,
    CASE 
        WHEN last_salary > first_salary THEN 'Increase'
        WHEN last_salary < first_salary THEN 'Decrease'
        ELSE 'No change'
    END AS trend
FROM 
    TrendMezd
WHERE 
industry IS NOT null
GROUP BY 
    industry, first_year, last_year, first_salary, last_salary
ORDER BY 
    industry;