SELECT 
    partd.*
    , nb_perc_presc
    , nb_perc_days
    , nb_perc_cost
    , perc_unicost
    , score
    , weighted_score
    , payments_2013
    , CASE WHEN ex."NPI" is not null THEN 
        1 
        ELSE 
        0 
        END as is_fraud
FROM basic_features  partd

LEFT JOIN  outliers_features  uni
on partd.npi = uni.npi
LEFT JOIN exclusions ex
ON partd.npi = ex."NPI"
LEFT JOIN physician_score phy
ON partd.npi = phy.npi
LEFT JOIN payments_npi pay
ON partd.npi = pay.npi

ORDER BY partd.npi