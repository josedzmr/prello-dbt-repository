With avgs AS(
SELECT 	
    municipality_code,
    intensite_tension_immo,
    LEFT(municipality_code, 2) as department,
    ((rental_max_apartment + rental_min_apartment) / 2) AS avg_rental_apartment,
    ((rental_max_house + rental_min_house) / 2) AS avg_rental_house,
    ((rental_max_all + rental_min_all) / 2) AS avg_rental_all,
    rental_min_apartment,
    rental_max_apartment,
    rental_min_house,
    rental_max_house,
    rental_med_house,
    rental_min_all,
    rental_max_all,
    rental_med_all
FROM {{ref("stg_RE_info_by_municipality")}}
)
SELECT
    department
    , ROUND(AVG(intensite_tension_immo),4) as avg_intensite_tension_immo
    , ROUND(AVG(avg_rental_apartment),4) as avg_rental_apartment
    , ROUND(AVG(avg_rental_house),4) as avg_rental_house
    , ROUND(AVG(avg_rental_all),4) as avg_rental_all
FROM avgs
GROUP BY department
ORDER BY department