WITH esta AS (
SELECT
    *
,   CASE
        WHEN department = '74' THEN importance
        ELSE 0
    END ski_import

--,   SUM(importance) OVER(PARTITION BY department, touristic_site) AS sum_importance_dep
FROM {{ ref('stg_POI_tourist_establishments') }}

)
SELECT
    department
,   accomodation_type
,   SUM(ski_import) AS ski_sum_importance
,   SUM(importance) AS sum_importance
FROM esta
GROUP BY department, accomodation_type
