SELECT
    municipality_code
    , city_name_normalized AS city_name {# used for clarity. original "city_name" column is not include, since it is the same name as "normalized", but with special characters #}
    , municipality_type
    , epci_code {# maintained for completion. It includes 52 null values in total, related to urban areas/cities in France without an epci code #}
    , latitude
    , longitude
    , department_code as department
    , department_name 
FROM prello-lewagon.prello.geographical_referential