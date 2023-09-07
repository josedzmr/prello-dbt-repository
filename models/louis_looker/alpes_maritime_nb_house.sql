WITH test AS (
SELECT 
  department
, SUM(nb_principal_home) AS nb_principal_home 
, SUM(nb_second_home) AS nb_second_home
, SUM(nb_vacants_housing) AS nb_vacants_housing
FROM {{ ref('stg_housing_stock') }}
WHERE department < '97' AND year = 2018
GROUP BY department
)
SELECT 
  department
, CASE
    WHEN department = '06' THEN 512562
    ELSE 28999656/96
  END AS nb_principal_hom
, CASE 
    WHEN department = '06' THEN 195108
    ELSE 3464938/96
  END AS nb_second_home
, CASE 
    WHEN department = '06' THEN 64643
    ELSE 2843945/96
  END AS nb_vacants_housing
, CASE 
    WHEN department = '06' THEN 'Alpes maritimes'
    WHEN department = '01' THEN 'France average'
    ELSE department
    END AS dep_looker
FROM test
