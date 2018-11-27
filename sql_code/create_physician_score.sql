SELECT 
  npi
  , sum(percent_drug_for_me * weighted_drug_score) as weighted_score
  , avg(drug_score) as score
  , min(is_fraud) as is_fraud
FROM (
      SELECT 
        base.* 
        , cost / sum(cost) over (partition by npi) as percent_drug_for_me
        , sum(cost) over (partition by drug) - cost as total_drug_but_me
        , (sum(cost * is_fraud) over (partition by drug) - cost*is_fraud)/GREATEST((sum(cost) over (partition by drug) - cost),0.00000000001) as weighted_drug_score
        , (sum(is_fraud) over (partition by drug) - is_fraud)/GREATEST((count(*) over (partition by drug) - 1),0.00000000001) as drug_score
      FROM
        (
        select partd.* 
          , CASE WHEN "EXCLDATE" IS NULL THEN 0 ELSE 1 END as is_fraud
        from partd_no_year partd
        LEFT JOIN exclusions ex 
        ON partd.npi = ex."NPI"
        ) base
    ) s1
GROUP BY npi  