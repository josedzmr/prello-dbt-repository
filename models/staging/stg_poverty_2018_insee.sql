SELECT
    Code AS department
    , D__partement AS department_name
    , ROUND(Taux_de_pauvret____en____ /100,4) AS poverty_rate

FROM `prello-lewagon.prello.poverty_2018_insee`