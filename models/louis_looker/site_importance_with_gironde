SELECT
    *
,   CASE
        WHEN department = '33' THEN importance
        ELSE 0
    END gir_import
FROM {{ ref('stg_POI_touristic_sites_by_municipality') }}