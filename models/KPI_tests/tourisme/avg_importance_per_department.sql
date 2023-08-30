WITH establishements AS (
  SELECT
  department
  , AVG(importance) AS avg_estab_importance
FROM {{ref("stg_POI_touristic_sites_by_municipality")}}
GROUP BY department
)
, sites as (
  SELECT
  department
  , AVG(importance) AS avg_site_importance
FROM {{ref("stg_POI_tourist_establishments")}}
GROUP BY department
)

, poverty as (
  SELECT
  department
  , AVG(poverty_rate) AS avg_poverty_rate
FROM {{ref("stg_poverty_2018_insee")}}
GROUP BY department
)

SELECT 
  site.department as department
  , site.avg_site_importance
  , establishement.avg_estab_importance
  , poverty.avg_poverty_rate
FROM establishements as establishement
INNER JOIN sites as site
ON site.department = establishement.department
INNER JOIN poverty as poverty
ON poverty.department = establishement.department
ORDER BY site.department ASC