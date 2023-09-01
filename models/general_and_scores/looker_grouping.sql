WITH geometry AS(
SELECT
  code
  , nom
	, geometry
FROM {{ref('stg_geometry_final')}}
)

SELECT
    gen.department_cleaned AS department
    , gen.w_tourism_score
	, gen.w_invest_score
	, gen.scaled_invest_score
	, gen.scaled_tourism_score
	, gen.general_score
    , gen.s_population_growth
	, gen.s_sales_nb
	, gen.s_avg_salary
	, gen.s_gross_yield
	, gen.s_avg_m2_price
	, gen.s_rental_med
	, gen.s_intensite_immo
	, gen.s_second_home
	, gen.s_foreigners
	, gen.s_site_importance
	, gen.s_estab_importance
    , gen.w_population_growth
    , gen.w_sales_nb
    , gen.w_avg_salary
    , gen.w_gross_yield
    , gen.w_avg_m2_price
    , gen.w_rental_med
    , gen.w_intensite_immo
	, gen.w_second_home
	, gen.w_foreigners
	, gen.w_site_importance
	, gen.w_estab_importance
    , geo.nom as name_department
    , geo.geometry 
FROM {{ref('final_score')}} as gen
INNER JOIN geometry as geo
ON geo.code = gen.department_cleaned
ORDER BY department