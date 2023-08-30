SELECT
    department,
    year,
    avg_salary,
    (avg_salary - LAG(avg_salary) OVER (PARTITION BY department ORDER BY year)) / LAG(avg_salary) OVER (PARTITION BY department ORDER BY year) * 100 AS growth_rate
FROM
    prello-lewagon.dbt_mverstraete.avg_salary_by_department_year
ORDER BY
    department, year;