SELECT 
    *
    , LEFT(municipality_code, 2) as department
FROM `prello-lewagon.prello.real_estate_info_by_municipality` 