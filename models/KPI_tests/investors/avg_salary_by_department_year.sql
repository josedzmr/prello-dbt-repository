SELECT
    LEFT(municipality_code,2) as department --french department are the two first numbers of the municipality code
    , AVG(avg_net_salary) as avg_salary
    , year
FROM prello-lewagon.prello.average_salary_by_municipality
GROUP BY department, year
ORDER BY department, year;