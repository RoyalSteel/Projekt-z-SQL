/* 
 * 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
 */

-- Z dat lze vyčíst, že v žádném sledovaném roce nedošlo k nárustu přes 10%.

WITH Price_Difference AS (
    SELECT 
        year,
        AVG(average_food_price) AS overall_average_price,
        LAG(AVG(average_food_price)) OVER (ORDER BY year) AS previous_average_price
    FROM 
        t_petr_kral_project_sql_primary_final
    GROUP BY 
        year
)
SELECT 
    year,
    ROUND(((overall_average_price - previous_average_price) / previous_average_price) * 100, 2) AS percentage_difference
FROM 
    Price_Difference
WHERE 
    previous_average_price IS NOT NULL
ORDER BY 
    year;