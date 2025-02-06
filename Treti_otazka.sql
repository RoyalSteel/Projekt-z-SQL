/* 
 * 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
 */

-- V datech lze vidět, že existují potraviny, které v některých letech dokonce i zlevňovaly.
-- Na otázku tedy nelze odpověďet, že nějaká „kategorie“ meziročně zdražuje nejpomaleji.
-- Pro zobrazení pouze těchto potravin a let, kdy zlevňovaly slouží druhá část skriptu.

WITH Annual_Summary AS (
    SELECT 
        food_name,
        year,
        average_food_price,
        LAG(average_food_price) OVER (PARTITION BY food_name ORDER BY year ASC) AS previous_price
    FROM 
        t_petr_kral_project_sql_primary_final
)
SELECT 
    food_name,
    year,
    average_food_price,
    previous_price,
    ROUND(((average_food_price - previous_price) / previous_price) * 100, 2) AS percentage_difference
FROM 
    Annual_Summary
WHERE 
    year > 2006
    AND previous_price IS NOT NULL  -- Ošetření nulových hodnot
ORDER BY 
    percentage_difference ASC;


-- část skriptu, kterou lze použít k zobrazení potravin, jejichž cena se snižuje
 WITH Annual_Summary AS (
    SELECT 
        food_name,
        year,
        average_food_price,
        LAG(average_food_price) OVER (PARTITION BY food_name ORDER BY year ASC) AS previous_price
    FROM 
        t_petr_kral_project_sql_primary_final
)
SELECT 
    food_name,
    year,
    average_food_price,
    previous_price,
    CASE 
        WHEN previous_price IS NOT NULL THEN ROUND(((average_food_price - previous_price) / previous_price) * 100, 2)
        ELSE NULL
    END AS percentage_difference
FROM 
    Annual_Summary
WHERE 
    year > 2006
    AND CASE 
        WHEN previous_price IS NOT NULL THEN ROUND(((average_food_price - previous_price) / previous_price) * 100, 2)
        ELSE NULL
    END < 0
GROUP BY
    food_name,
    year,
    average_food_price,
    previous_price
ORDER BY 
    food_name DESC;