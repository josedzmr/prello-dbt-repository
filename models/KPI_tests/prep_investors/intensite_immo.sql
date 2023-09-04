SELECT
    department
,   AVG(intensite_tension_immo) AS intensite_tension_immo
FROM {{ ref('stg_RE_info_by_municipality') }}
GROUP BY department