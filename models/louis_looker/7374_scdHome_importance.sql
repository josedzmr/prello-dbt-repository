WITH rank_nb AS (
SELECT 
  municipality_code
, city_name
, AVG(secondary_home_rate) AS scd_rate
, SUM(nb_second_home) AS nb_scd_home
, ROW_NUMBER() OVER(ORDER BY AVG(secondary_home_rate) DESC) AS rank_scd_rate
FROM {{ ref('stg_housing_stock') }} hs
LEFT JOIN {{ ref('stg_geographical_referential_check') }} geo
USING (municipality_code)
WHERE year = 2018 
GROUP BY municipality_code, city_name
ORDER BY scd_rate DESC
)
,   by_dep AS(
SELECT
    municipality_code
,   city_name
,   AVG(rb.scd_rate) AS secondary_home_rate
,   SUM(rb.nb_scd_home) AS nb_second_home
FROM rank_nb rb
WHERE (rb.municipality_code LIKE '74%'OR rb.municipality_code LIKE '73%') AND rb.nb_scd_home > 1000 AND rb.rank_scd_rate < 460
GROUP BY municipality_code, city_name
)
SELECT
    dep.municipality_code
,   city_name
,   LEFT(dep.municipality_code, 2) AS department
,   AVG(secondary_home_rate) AS secondary_home_rate
,   AVG(nb_second_home) AS nb_second_home
,   SUM(site.importance) AS site_importance
,   SUM(esta.importance) AS estab_importance
FROM by_dep dep
INNER JOIN {{ ref('stg_POI_touristic_sites_by_municipality') }} site USING (municipality_code)
INNER JOIN {{ ref('stg_POI_tourist_establishments') }} esta USING (municipality_code)
GROUP BY municipality_code, city_name
ORDER BY site_importance DESC
