SELECT  
  department
, w_tourism_score
, IFNULL(w_invest_score, 0) AS w_invest_score
, IFNULL(scaled_invest_score, 0) AS scaled_invest_score
, scaled_tourism_score
, IFNULL(general_score,0) AS general_score
, s_population_growth
, IFNULL(s_sales_nb, 0) AS s_sales_nb
, s_avg_salary
, IFNULL(s_gross_yield,0) AS s_gross_yield
, IFNULL(s_avg_m2_price,0) AS s_avg_m2_price
, IFNULL(s_rental_med, 0) AS s_rental_med
, s_intensite_immo
, s_second_home
, s_foreigners
, s_site_importance
, s_estab_importance
, w_population_growth
, IFNULL(w_sales_nb,0) AS w_sales_nb
, w_avg_salary
, IFNULL(w_gross_yield,0) AS w_gross_yield
, IFNULL(w_avg_m2_price,0) AS w_avg_m2_price
, IFNULL(w_rental_med,0) AS w_rental_med
, w_intensite_immo
, w_second_home
, w_foreigners
, w_site_importance
, w_estab_importance
, name_department
, geometry
, ROW_NUMBER () OVER(ORDER BY general_score DESC) AS ranking
FROM {{ ref('looker_grouping') }}