WITH second_home AS (
  SELECT *
  FROM {{ref("stg_housing_stock")}}
  WHERE year = 2008 OR year = 2013 OR year= 2018
)

SELECT 
  department
  , year
  , sum(nb_second_home) as nb_second_home
  , sum(nb_principal_home) as nb_principal_home
  , sum(nb_vacants_housing) as nb_vacants_housing
  , sum(nb_tot_housing) as nb_tot_housing
  , avg(principal_home_rate) as principal_home_rate
  , avg(secondary_home_rate) as secondary_home_rate
  , avg(vacants_housing_rate) as vacants_home_rate
FROM second_home
GROUP BY department, year