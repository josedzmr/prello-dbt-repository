SELECT
  accomodation_type
  , COUNT(accomodation_type) AS nbr_accomodation_type
  , AVG(importance) AS avg_importance
FROM {{ref("stg_POI_tourist_establishments")}}
GROUP BY accomodation_type
ORDER BY avg_importance DESC