-- SELECT 
--     "drug"
--     , count(*) as nb_seen
--     , SUM(is_fraud) as seen_in_fraud
--     , SUM(is_fraud)/count(*) as percent_fraud
--     , SUM(is_fraud * cost)/SUM(cost) as cost_weighted_percent_fraud
-- FROM (
--     SELECT partd.* 
--         , CASE WHEN exc."NPI" is not null THEN 
--         1 
--         ELSE 
--         0 
--         END as is_fraud
--     FROM (
--         select 
--             npi
--             , drug
--             , sum("nb_prescriptions") as nb_prescriptions
--             , sum("nb_days") as nb_days
--             , sum("cost") as cost 
--             , min(speciality) as speciality
--         FROM PartD_no_year   
--         GROUP BY NPI, drug
--     ) partd
--     LEFT JOIN exclusions  exc
--     ON partd.npi = exc."NPI"
--     ) s1
-- GROUP BY drug    
-- ORDER BY SUM(is_fraud * cost)/SUM(cost) desc
-- ;


CREATE TABLE drug_weights_no_year(
    npi int,
    weighted_score float,
    score float,
    is_fraud int
);

INSERT INTO drug_weights_no_year
SELECT * FROM 
    (
        SELECT 
          npi
          , sum(percent_drug * weighted_drug_score) as weighted_score
          , avg(drug_score) as score
          , min(is_fraud) as is_fraud
        FROM (
              SELECT 
                base.* 
                , cost / sum(cost) over (partition by npi) as percent_drug
                , sum(cost) over (partition by drug) - cost as total_drug
                , (sum(cost * is_fraud) over (partition by drug) 
                    - cost*is_fraud)
                    /GREATEST((sum(cost) over (partition by drug) - cost)
                    ,0.00000000001) as weighted_drug_score
                , (sum(is_fraud) over (partition by drug) - is_fraud)
                   /GREATEST((count(*) over (partition by drug) - 1)
                   ,0.00000000001) as drug_score
              FROM
                (
                select partd.* 
                  , CASE WHEN ex."year" IS NULL THEN 
                    0 ELSE 1 END as is_fraud
                from partd_no_year partd
                LEFT JOIN exclusions ex 
                ON partd.npi = ex."NPI"
                ) base
            ) s1
        GROUP BY npi  
        )lala;