-- test no nulls / no dupli / no <0 values

SELECT   --taken out 'int64_field0' and 'country_code' columns
    CONCAT(municipality_code,'-',year) as prim_key --to keep a primary key, there is 279584 rows which is 34948 municilpality_code on 8 years
    , municipality_code
    , LEFT(municipality_code,2) as department --french department are the two first numbers of the municipality code
    , year  -- year concerned 1968 1975 1982 1990 1999 2008 2013 2018
    , DATE(year,01,01) as date  -- everything on the 1st of Jan, will help if we do graph by temporality
    , nb_principal_home
    , nb_second_home
    , nb_vacants_housing
    , nb_tot_housing
    , secondary_home_rate
    , principal_home_rate
    , vacants_housing_rate
FROM `prello-lewagon.prello.housing_stock`
