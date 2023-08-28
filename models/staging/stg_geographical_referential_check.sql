{# geographical_referential table check #}
{# No null values or duplicates found#}
SELECT
    ,municipality_code
    ,city_name_normalized AS city_name
    ,municipality_type
    ,CONCAT(municipality_code, " ", latitude, " ", longitude ) as location --used as primary key to check for duplicates
    ,department_name
    ,department_code
FROM prello-lewagon.prello.geographical_referential