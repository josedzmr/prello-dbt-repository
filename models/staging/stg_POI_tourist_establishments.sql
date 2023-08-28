/* Cleaning DATA: Deleting duplicated rows, selecting and renaming columns */
WITH clean AS ( 
SELECT
  *
, ROW_NUMBER() OVER(PARTITION BY (CONCAT(latitude, "  ", longitude))) AS row_nb
FROM `prello.POI_tourist_establishments`
)
SELECT
    poi AS accomodation_type
,   latitude
,   longitude
,   municipality_code
,   importance
,   LEFT(municipality_code, 2) AS department
FROM clean
WHERE row_nb = 1

