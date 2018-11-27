-- count number of times being an outlier happens on the four variables
-- SELECT npi
--     , sum(perc_pres) as nb_perc_presc
--     , sum(perc_days) as nb_perc_days
--     , sum(perc_cost) as nb_perc_cost
--     , sum(perc_unicost) as perc_unicost    
-- FROM (
--     SELECT * 
--         , (nb_prescriptions > mean_nb_prescriptions + 4 * sqrt (var_nb_prescriptions))::int as perc_pres 
--         , (nb_days > mean_nb_days + 4 * sqrt (var_nb_days))::int as perc_days 
--         , (cost > mean_cost + 4 * sqrt (var_cost))::int as perc_cost 
--         , (unitary_cost > mean_unitary_cost + 4 * sqrt (var_unitary_cost))::int as perc_unicost 
--     FROM (     
--         SELECT *
--             -- calculate avgs
--             , AVG(nb_prescriptions) over (PARTITION BY speciality, drug ) as mean_nb_prescriptions
--             , AVG(nb_days) over (PARTITION BY speciality, drug ) as mean_nb_days
--             , AVG(cost) over (PARTITION BY speciality, drug ) as mean_cost
--             , AVG(unitary_cost) over (PARTITION BY speciality, drug ) as mean_unitary_cost
--             -- calculate vars
--             , variance(nb_prescriptions) over (PARTITION BY speciality, drug ) as var_nb_prescriptions
--             , variance(nb_days) over (PARTITION BY speciality, drug ) as var_nb_days
--             , variance(cost) over (PARTITION BY speciality, drug ) as var_cost
--             , variance(unitary_cost) over (PARTITION BY speciality, drug ) as var_unitary_cost
--         FROM (
--             SELECT *
--                 , "nb_days" / GREATEST("cost",0.00001) as unitary_cost
--             FROM PartD_no_year  
--             ) partd
--         ) avgvar
--     ) final
-- GROUP BY npi 

/*
-- count number of times being an outlier happens on the four variables
SELECT npi
    , sum(perc_pres) as nb_perc_presc
    , sum(perc_days) as nb_perc_days
    , sum(perc_cost) as nb_perc_cost
    , sum(perc_unicost) as perc_unicost    
FROM (
    
    SELECT *
        -- set 1 if npi is in the 1 % of best prescriber of a drug in its speciality 
        , (ntile(100) over (PARTITION BY speciality, drug order by nb_prescriptions asc)=1)::int as perc_pres 
        , (ntile(100) over (PARTITION BY speciality, drug order by nb_days asc)=1)::int as perc_days
        , (ntile(100) over (PARTITION BY speciality, drug order by cost asc)=1)::int as perc_cost
        -- set 1 if npi is in the 1 % of best prescriber of a drug in its speciality 
        , (ntile(100) over (PARTITION BY drug order by unitary_cost asc)=1)::int as perc_unicost  
    
    FROM (
        SELECT *
            , "nb_days" / "cost" as unitary_cost
        FROM PartD_no_year  
        ) partd
    ) ntiles
GROUP BY npi 
*/

-- DROP TABLE PartD_outlier_2015;

CREATE TABLE PartD_outlier_no_year(
    npi int,
    nb_perc_presc float,
    nb_perc_days float,
    nb_perc_cost float,
    perc_unicost float
);


INSERT INTO PartD_outlier_no_year
SELECT * FROM 
(
    SELECT npi
        , sum(perc_pres) as nb_perc_presc
        , sum(perc_days) as nb_perc_days
        , sum(perc_cost) as nb_perc_cost
        , sum(perc_unicost) as perc_unicost    
    FROM (
        SELECT * 
            , (nb_prescriptions > mean_nb_prescriptions 
              + 4 * sqrt (var_nb_prescriptions))::int as perc_pres 
            , (nb_days > mean_nb_days 
              + 4 * sqrt (var_nb_days))::int as perc_days 
            , (cost > mean_cost 
              + 4 * sqrt (var_cost))::int as perc_cost 
            , (unitary_cost > mean_unitary_cost 
               + 4 * sqrt (var_unitary_cost))::int as perc_unicost 
        FROM (     
            SELECT *
                -- calculate avgs
                , AVG(nb_prescriptions) 
                over (PARTITION BY speciality, drug ) 
                as mean_nb_prescriptions
                , AVG(nb_days) 
                over (PARTITION BY speciality, drug ) 
                as mean_nb_days
                , AVG(cost) 
                over (PARTITION BY speciality, drug ) 
                as mean_cost
                , AVG(unitary_cost) 
                over (PARTITION BY speciality, drug ) 
                as mean_unitary_cost
                -- calculate vars
                , variance(nb_prescriptions) 
                over (PARTITION BY speciality, drug ) 
                as var_nb_prescriptions
                , variance(nb_days) 
                over (PARTITION BY speciality, drug ) 
                as var_nb_days
                , variance(cost) 
                over (PARTITION BY speciality, drug ) 
                as var_cost
                , variance(unitary_cost) 
                over (PARTITION BY speciality, drug ) 
                as var_unitary_cost
            FROM (
                SELECT *
                    , nb_days / nullif(cost,0) as unitary_cost
                FROM partd_no_year  
                ) partd
            ) avgvar
        ) final
    GROUP BY npi 


    -- SELECT npi
    --     , sum(perc_pres) as nb_perc_presc
    --     , sum(perc_days) as nb_perc_days
    --     , sum(perc_cost) as nb_perc_cost
    --     , sum(perc_unicost) as perc_unicost    
    -- FROM (
    --     SELECT * 
    --         , (nb_prescriptions > mean_nb_prescriptions + 4 * sqrt (var_nb_prescriptions))::int as perc_pres 
    --         , (nb_days > mean_nb_days + 4 * sqrt (var_nb_days))::int as perc_days 
    --         , (cost > mean_cost + 4 * sqrt (var_cost))::int as perc_cost 
    --         , (unitary_cost > mean_unitary_cost + 4 * sqrt (var_unitary_cost))::int as perc_unicost 
    --     FROM (     
    --         SELECT *
    --             -- calculate avgs
    --             , AVG(nb_prescriptions) over (PARTITION BY speciality, drug ) as mean_nb_prescriptions
    --             , AVG(nb_days) over (PARTITION BY speciality, drug ) as mean_nb_days
    --             , AVG(cost) over (PARTITION BY speciality, drug ) as mean_cost
    --             , AVG(unitary_cost) over (PARTITION BY speciality, drug ) as mean_unitary_cost
    --             -- calculate vars
    --             , variance(nb_prescriptions) over (PARTITION BY speciality, drug ) as var_nb_prescriptions
    --             , variance(nb_days) over (PARTITION BY speciality, drug ) as var_nb_days
    --             , variance(cost) over (PARTITION BY speciality, drug ) as var_cost
    --             , variance(unitary_cost) over (PARTITION BY speciality, drug ) as var_unitary_cost
    --         FROM (
    --             SELECT *
    --                 , "nb_days" / GREATEST("cost",0.00001) as unitary_cost
    --             FROM PartD_no_year  
    --             ) partd
    --         ) avgvar
    --     ) final
    -- GROUP BY npi 
)outs; 