/* 
 * 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
 */

-- V roce 2006 bylo možné si koupit Chléb konzumní kmínový 1284kg.
-- V roce 2018 bylo možné si koupit Chléb konzumní kmínový 1342kg.

-- V roce 2006 bylo možné si koupit Mléko polotučné pasterované 1436l.
-- V roce 2018 bylo možné si koupit Mléko polotučné pasterované 1641l.

WITH Annual_data_food AS (
    SELECT 
        food_name,
        year,
        AVG(average_food_price) AS average_food_price_per_year -- Agregace cen potravin za rok
    FROM 
        t_petr_kral_project_SQL_primary_final
    WHERE 
        food_name IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový') -- Filtrujte data pro požadované položky potravin
        AND year IN (2006, 2018) -- Filtrujte data pro požadované roky
    GROUP BY
        food_name,
        year
),
Annual_data_salary AS (
    SELECT 
        year,
        AVG(average_salary) AS average_salary_per_year -- Agregace mezd za rok napříč odvětvími
    FROM 
        t_petr_kral_project_SQL_primary_final
    WHERE 
        year IN (2006, 2018) -- Filtrujte data pro požadované roky
    GROUP BY
        year
),
Calculated AS (
    SELECT 
        adf.food_name,
        ads.year,
        ROUND(ads.average_salary_per_year / adf.average_food_price_per_year) AS quantity
    FROM Annual_data_food adf
    JOIN Annual_data_salary ads 
      ON adf.year = ads.year
)
SELECT 
    food_name, -- Ve výsledku zobrazit název jídla
    MAX(CASE WHEN year = 2006 THEN quantity END) AS quantity_for_2006, -- Výpočet množství pro rok 2006
    MAX(CASE WHEN year = 2018 THEN quantity END) AS quantity_for_2018  -- Výpočet množství pro rok 2018
FROM Calculated
GROUP BY food_name
HAVING MAX(CASE WHEN year = 2006 THEN quantity END) IS NOT NULL
   AND MAX(CASE WHEN year = 2018 THEN quantity END) IS NOT NULL
ORDER BY food_name;