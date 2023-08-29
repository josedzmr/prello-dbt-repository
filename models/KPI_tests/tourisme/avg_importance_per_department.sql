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

SELECT 
  site.department as department
  , site.avg_site_importance
  , establishement.avg_estab_importance
FROM establishements as establishement
INNER JOIN sites as site
ON site.department = establishement.department
ORDER BY site.department ASC