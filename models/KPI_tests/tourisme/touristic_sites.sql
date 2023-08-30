SELECT
  touristic_site
  , COUNT(touristic_site) AS nbr_touristic_sites
  , AVG(importance) AS avg_importance
FROM {{ref("stg_POI_touristic_sites_by_municipality")}}
GROUP BY touristic_site
ORDER BY avg_importance DESC