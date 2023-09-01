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
    WHEN department_cleaned = '1' THEN '01'
    WHEN department_cleaned = '2' THEN '02'
    WHEN department_cleaned = '3' THEN '03'
    WHEN department_cleaned = '4' THEN '04'
    WHEN department_cleaned = '5' THEN '05'
    WHEN department_cleaned = '6' THEN '06'
    WHEN department_cleaned = '7' THEN '07'
    WHEN department_cleaned = '8' THEN '08'
    WHEN department_cleaned = '9' THEN '09'
    ELSE department_cleaned
  END AS deparmtent 
, (nb_second_home*0.295) AS secnd_home
, (foreigners_stay_total*0.11) AS foreigners
, (sum_site_importance*0.30) AS site_importance
, (sum_estab_importance*0.295) AS estab_importance
, (nb_second_home*0.295) + (foreigners_stay_total*0.11)+(sum_site_importance*0.30)+(sum_estab_importance*0.295) AS tourism_score
FROM cast_tourism
ORDER BY tourism_score DESC