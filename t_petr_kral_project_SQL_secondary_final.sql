DROP TABLE IF EXISTS t_petr_kral_project_SQL_secondary_final;

CREATE TABLE t_petr_kral_project_SQL_secondary_final AS
SELECT 
    e.country,
    e.year AS year_column,  -- Přejmenování, aby nedocházelo ke konfliktům s rezervovaným slovem
    e.GDP,
    e.gini,
    e.population
FROM economies e
JOIN countries c ON e.country = c.country
WHERE c.continent = 'Europe'
AND e.year BETWEEN 2006 AND 2018;