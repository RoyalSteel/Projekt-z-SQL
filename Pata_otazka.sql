/* 
 * 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? 
 *    Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
 */

-- Na základě analýzy průměrného růstu cen potravin, mezd a HDP v letech 2006–2018 nelze s jistotou potvrdit ani vyvrátit danou hypotézu.
-- I když existuje jistá kauzalita, tato závislost se projevila nepravidelně a není jednoznačná pro všechny roky.
-- Například v roce 2015 je patrný výrazný růst HDP o 5,39 %, ale průměrné ceny potravin ve stejném i v následujícím roce klesaly.
-- Na druhé straně v roce 2012 došlo ke snížení HDP, ale ceny potravin i mzdy v následujících letech rostly.
-- V roce 2013 je vidět menší pokles HDP o -0,05 %, ale ceny potravin stouply a mzdy klesly.
-- V roce 2009 došlo k výraznému poklesu HDP o -4,66 %, ale ceny potravin se naopak snížily a mzdy rostly.
-- Z dostupných dat lze tedy vyvodit, že výška HDP nemá jednoznačný vliv na změny cen potravin nebo platů.
-- Průměrné ceny potravin, stejně jako průměrné mzdy, mohou stoupat i klesat nezávisle na vývoji HDP.
-- V období od roku 2006 do 2018 převládaly mezi všemi sledovanými kategoriemi hodnoty meziročního růstu nad jejich poklesem.
-- V případě HDP došlo ke třem meziročním poklesům, ceny potravin klesly ve třech případech a mzdy klesly pouze v jednom roce.
-- Průměrná roční rychlost růstu HDP mezi lety 2006 a 2018 byla 2,48 % a celkový nárůst za toto období činil 32,28 %.
-- Mzdy pak rostly v průměru o 3,87 % ročně, celkově pak vzrostly o 46,45 %.
-- Ceny potravin stoupaly průměrně o 2,87 % ročně a celkově se zvýšily o 34,49 %.

WITH GDPChange AS (
    SELECT 
        e."year" AS year,
        e.GDP AS gdp_value,
        LAG(e.GDP) OVER (ORDER BY e."year") AS previous_gdp,
        ROUND(((e.GDP - LAG(e.GDP) OVER (ORDER BY e."year")) / NULLIF(LAG(e.GDP) OVER (ORDER BY e."year"), 0))::numeric * 100, 2) AS gdp_change_percentage
    FROM 
        economies e
    WHERE 
        e.country = 'Czech Republic'
), -- zde jsem získal informace o HDP za Českou republiku
SalariesAndWages AS (
    SELECT 
        trzpspf."year",
        ROUND(AVG(trzpspf.average_salary)::numeric) AS average_salary,
        ROUND(AVG(trzpspf.average_food_price)::numeric) AS average_price,
        LAG(AVG(trzpspf.average_salary)) OVER (ORDER BY trzpspf."year") AS previous_avg_salary,
        LAG(AVG(trzpspf.average_food_price)) OVER (ORDER BY trzpspf."year") AS previous_avg_price,
        ROUND(((AVG(trzpspf.average_salary) - LAG(AVG(trzpspf.average_salary)) OVER (ORDER BY trzpspf."year")) / NULLIF(LAG(AVG(trzpspf.average_salary)) OVER (ORDER BY trzpspf."year"), 0))::numeric * 100, 2) AS salary_change_percentage,
        ROUND(((AVG(trzpspf.average_food_price) - LAG(AVG(trzpspf.average_food_price)) OVER (ORDER BY trzpspf."year")) / NULLIF(LAG(AVG(trzpspf.average_food_price)) OVER (ORDER BY trzpspf."year"), 0))::numeric * 100, 2) AS price_change_percentage
    FROM 
        t_petr_kral_project_sql_primary_final trzpspf
    GROUP BY 
        trzpspf."year"
)
SELECT 
    p."year",
    h.gdp_value,
    p.average_salary,
    p.average_price,
    h.gdp_change_percentage,
    p.salary_change_percentage,
    p.price_change_percentage
FROM 
    GDPChange h
JOIN 
    SalariesAndWages p ON h."year" = p."year"
ORDER BY 
    p."year";