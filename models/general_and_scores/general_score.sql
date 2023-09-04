/*
Total score !!
*/

SELECT
    t.deparmtent
,   t.tourism_score
,   i.invest_score
,   (t.tourism_score + i.invest_score) / 2 AS general_score
FROM {{ ref('tourism_score') }} t
INNER JOIN {{ ref('invest_score') }} i
USING(deparmtent)
ORDER BY general_score DESC