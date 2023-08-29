SELECT 
  CONCAT(municipality_code, '-', year) as prim_key
  , municipality_code
  , LEFT(municipality_code, 2) as department
  , year
  , population 
FROM `prello-lewagon.prello.population_by_municipality`
