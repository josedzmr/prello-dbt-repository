/*
Toursim score 
*/
WITH cast_tourism AS (
SELECT
  *
, CAST(department AS string) AS department_cleaned
FROM `prello-lewagon.dbt_louis2506_general.scaled_tourism`
)
SELECT 
  CASE
    WHEN department_cleaned = '2000' THEN '2B'
    WHEN department_cleaned = '2999' THEN '2A'
    ELSE department_cleaned
  END AS deparmtent 
, (nb_second_home + sum_estab_importance + sum_site_importance + foreigners_stay_total) / 4 AS tourism_score
FROM cast_tourism
ORDER BY tourism_score DESC