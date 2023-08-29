SELECT
    municipality_code
    , LEFT(municipality_code,2) as department --french department are the two first numbers of the municipality code
    , avg_net_salary
    , year
FROM prello-lewagon.prello.average_salary_by_municipality