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
, (nb_second_home*0.295) AS secnd_home
, (foreigners_stay_total*0.11) AS foreigners
, (sum_site_importance*0.30) AS site_importance
, (sum_estab_importance*0.295) AS estab_importance
, (nb_second_home*0.295) + (foreigners_stay_total*0.11)+(sum_site_importance*0.30)+(sum_estab_importance*0.295) AS tourism_score
FROM cast_tourism
ORDER BY tourism_score DESC