WITH site AS (
SELECT
    *
,   CASE
        WHEN department = '74' THEN importance
        ELSE 0
    END ski_site_import

--,   SUM(importance) OVER(PARTITION BY department, touristic_site) AS sum_importance_dep
FROM {{ ref('stg_POI_touristic_sites_by_municipality') }}

)
,   prep_join AS(
SELECT
    department
,   touristic_site
,   SUM(ski_site_import) AS ski_sum_importance
,   SUM(importance) AS sum_site_importance
FROM site
GROUP BY department, touristic_site
)
SELECT
    *
,   SUM(sum_site_importance) OVER() AS site_importance_total
FROM prep_join