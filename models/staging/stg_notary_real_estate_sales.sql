SELECT 
    fullname
    , DATE(sales_date) as sales_date -- Set as date
    , sales_amount
    , street_number
    , street_code	
    , street_name
    , nom_commune
    , municipality_code
    , LEFT(municipality_code,2) as department --french department are the two first numbers of the municipality code
    , premise_type
    , surface
    , number_of_principal_rooms
    , sales_price_m2	
    , latitude
    , longitude
FROM `prello-lewagon.prello.notary_real_estate_sales` 