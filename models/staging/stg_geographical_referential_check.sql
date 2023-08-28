{# geographical_referential table check #}

{# Null values#}
SELECT
    COUNT (municipality_code) IS NULL
    ,COUNT (city_name) IS NULL
    ,COUNT (city_name_normalized) IS NULL
    ,COUNT (municipality_type) IS NULL
    ,COUNT (latitude) IS NULL
    ,COUNT (longitude) IS NULL
    ,COUNT (department_name) IS NULL
FROM
    prello-lewagon.prello.geographical_referential

{# Check number of Départments, 101 in total#}
SELECT 
    DISTINCT department_name
FROM 
    prello-lewagon.prello.geographical_referential

{# Check duplicated rows#}
SELECT 
CONCAT(municipality_code, " ", latitude, " ", longitude ) as location
, COUNT (*) AS nb
FROM prello-lewagon.prello.geographical_referential
GROUP BY location
HAVING nb >1