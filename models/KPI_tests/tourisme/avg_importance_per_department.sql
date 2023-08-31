WITH establishements AS (
  SELECT
  department
  , COUNT(touristic_site) as nb_touristic_site
  , AVG(importance) AS avg_estab_importance
  , SUM(importance) AS sum_estab_importance
FROM {{ref("stg_POI_touristic_sites_by_municipality")}}
GROUP BY department
)
, sites as (
  SELECT
  department
  , COUNT(accomodation_type) as nb_accomodation_type
  , AVG(importance) AS avg_site_importance
  , SUM(importance) AS sum_site_importance
FROM {{ref("stg_POI_tourist_establishments")}}
GROUP BY department
)

, poverty as (
  SELECT
  department
  , AVG(poverty_rate) AS avg_poverty_rate
  , SUM(poverty_rate) AS sum_poverty_rate
FROM {{ref("stg_poverty_2018_insee")}}
GROUP BY department
)

, freq AS(
 SELECT 
  department
  , overnight_stay_hotel
  , foreigners_hotel_rate
  , overnight_stay_camping
  , fereigners_camping_rate as foreigners_camping_rate
FROM {{ref("stg_frequentation_touristic_establishment")}}
)

, sh_rate AS (
SELECT 
  department
  , secondary_home_rate
FROM {{ref("housing_stock_departm_2008-2018")}}
WHERE year = 2018
)

SELECT 
  site.department as department
  , sh.secondary_home_rate
  , site.nb_accomodation_type
  , site.avg_site_importance
  , site.sum_site_importance
  , establishement.nb_touristic_site
  , establishement.avg_estab_importance
  , establishement.sum_estab_importance
  , poverty.avg_poverty_rate
  , poverty.sum_poverty_rate
  , freq.overnight_stay_hotel
  , freq.foreigners_hotel_rate
  , freq.overnight_stay_camping
  , freq.foreigners_camping_rate

FROM establishements as establishement
INNER JOIN sites as site
ON site.department = establishement.department
INNER JOIN poverty as poverty
ON poverty.department = establishement.department
INNER JOIN freq as freq
ON freq.department = establishement.department
INNER JOIN sh_rate as sh
ON sh.department = establishement.department
ORDER BY site.department ASC