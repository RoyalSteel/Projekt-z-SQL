# Projekt z SQL
Tento [repozitář](https://github.com/RoyalSteel/Projekt-z-SQL) obsahuje soubory, které odpovídají na klíčové výzkumné otázky pro Engeto Datovou akademii.
<br>Odpovědi na jednotlivé otázky jsou v [Průvodní listina k Projektu z SQL.pdf](https://github.com/RoyalSteel/Projekt-z-SQL/blob/main/Pr%C5%AFvodn%C3%AD%20listina%20k%20Projektu%20z%20SQL.pdf).
<br>Pro vytvoření tabulek z kterých čerpají jednotlivé odpovědi na otázky slouží [t_petr_kral_project_SQL_primary_final.sql](https://github.com/RoyalSteel/Projekt-z-SQL/blob/main/t_petr_kral_project_SQL_primary_final.sql) a [t_petr_kral_project_SQL_secondary_final.sql](https://github.com/RoyalSteel/Projekt-z-SQL/blob/main/t_petr_kral_project_SQL_secondary_final.sql).

### Výzkumné otázky
[1. &nbsp;&nbsp;&nbsp;Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?](https://github.com/RoyalSteel/Projekt-z-SQL/blob/main/Prvni_otazka.sql)
<br>[2. &nbsp;&nbsp;&nbsp;Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dostupných datech cen a mezd?](https://github.com/RoyalSteel/Projekt-z-SQL/blob/main/Druha_otazka.sql)
<br>[3. &nbsp;&nbsp;&nbsp;Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?](https://github.com/RoyalSteel/Projekt-z-SQL/blob/main/Treti_otazka.sql)
<br>[4. &nbsp;&nbsp;&nbsp;Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?](https://github.com/RoyalSteel/Projekt-z-SQL/blob/main/Ctvrta_otazka.sql)
<br>[5. &nbsp;&nbsp;&nbsp;Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?](https://github.com/RoyalSteel/Projekt-z-SQL/blob/main/Pata_otazka.sql)

### Datové sady, které je možné použít pro získání vhodného datového podkladu

***Primární tabulky:***
1. &nbsp;&nbsp;&nbsp;*czechia_payroll* – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada
<br>&nbsp;&nbsp;&nbsp;pochází z Portálu otevřených dat ČR.
2. &nbsp;&nbsp;&nbsp;*czechia_payroll_calculation* – Číselník kalkulací v tabulce mezd.
3. &nbsp;&nbsp;&nbsp;*czechia_payroll_industry_branch* – Číselník odvětví v tabulce mezd.
4. &nbsp;&nbsp;&nbsp;*czechia_payroll_unit* – Číselník jednotek hodnot v tabulce mezd.
5. &nbsp;&nbsp;&nbsp;*czechia_payroll_value_type* – Číselník typů hodnot v tabulce mezd.
6. &nbsp;&nbsp;&nbsp;*czechia_price* – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází
<br>&nbsp;&nbsp;&nbsp;z Portálu otevřených dat ČR.
7. &nbsp;&nbsp;&nbsp;*czechia_price_category* – Číselník kategorií potravin, které se vyskytují v našem přehledu.

***Číselníky sdílených informací o ČR:***
1. &nbsp;&nbsp;&nbsp;*czechia_region* – Číselník krajů České republiky dle normy CZ-NUTS 2.
2. &nbsp;&nbsp;&nbsp;*czechia_district* – Číselník okresů České republiky dle normy LAU.

***Dodatečné tabulky:***
1. &nbsp;&nbsp;&nbsp;*countries* - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo
<br>&nbsp;&nbsp;&nbsp;průměrná výška populace.
2. &nbsp;&nbsp;&nbsp;*economies* - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.
