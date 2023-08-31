SELECT
    inv.*
,   tou.nb_accomodation_type
,   tou.avg_site_importance
,   tou.sum_site_importance
,   tou.nb_touristic_site
,   tou.avg_estab_importance
,   tou.sum_estab_importance
,   tou.avg_poverty_rate
,   tou.sum_poverty_rate
,   tou.overnight_stay_hotel
,   tou.foreigners_hotel_rate
,   tou.overnight_stay_camping
,   tou.foreigners_camping_rate
,   tou.secondary_home_rate
,   tou.nb_second_home
FROM {{ ref('growth_rate_all') }} inv
LEFT JOIN {{ ref('avg_importance_per_department') }} tou
USING(department)