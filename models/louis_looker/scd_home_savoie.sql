WITH scd_home AS (
SELECT
    *
,   CASE
        WHEN municipality_code = '74056' OR municipality_code = '74191' OR municipality_code = '74173' OR municipality_code = '74014' OR municipality_code = '74236' OR municipality_code = '74136' OR municipality_code = '74063' OR municipality_code = '74080' OR municipality_code = '74258' OR municipality_code = '74134' OR municipality_code = '74085' OR municipality_code = '74083' OR municipality_code = '74215' OR municipality_code = '74190' OR municipality_code = '74160' OR municipality_code = '74238' OR municipality_code = '74279' OR municipality_code = '74058' OR municipality_code = '74099' OR municipality_code = '74010' OR municipality_code = '74281' OR municipality_code = '74119' THEN nb_second_home
        WHEN municipality_code = '73257' THEN 41226
        ELSE 0
    END AS best_savoie_scd_home_nb
,   CASE
        WHEN department = '74' THEN nb_second_home
        ELSE 0
    END AS savoie_scd_home_nb
FROM {{ ref('stg_housing_stock') }}
WHERE year = 2018
)
,   renam AS (
SELECT
    department
,   SUM(best_savoie_scd_home_nb) AS best_scd_home_nb
,   SUM(savoie_scd_home_nb) - SUM(best_savoie_scd_home_nb) AS worst_scd_home_nb
,   SUM(nb_second_home) AS total_scd_home_nb
FROM scd_home
WHERE department = '74' OR department = '73'
GROUP BY department
)
SELECT
    *
,   CASE
        WHEN best_scd_home_nb = 82863 THEN 'Top 22'
        ELSE 'Remaining 257'
    END AS Municipalities
FROM renam