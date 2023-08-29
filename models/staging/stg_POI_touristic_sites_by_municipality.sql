/* Cleaning DATA: Deleting duplicated rows, selecting and renaming columns */
WITH clean AS (
SELECT  
  *
, ROW_NUMBER() OVER (PARTITION BY CONCAT(latitude, "  ", longitude, " ",poi)) AS row_nb
FROM `prello-lewagon.prello.POI_touristic_sites_by_municipality` 
)
SELECT
  poi as touristic_site
, latitude
, longitude
, municipality_code
, LEFT(municipality_code, 2) AS department
, importance
FROM clean
WHERE row_nb = 1