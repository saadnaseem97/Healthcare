-- take mean, max and variance of 
-- nb of prescriptions, nb of days and total cost
-- DROP TABLE PartD_base;
CREATE TABLE PartD_base_no_year(
    npi int,
    speciality varchar(80),
    nb_diff_prescriptions int,
    sum_prescr int,
    sum_days int,
    sum_cost float,
    max_prescr int,
    max_days int,
    max_cost float,   
    var_prescr float,
    var_days float,
    var_cost float
);

INSERT INTO PartD_base_no_year
SELECT * FROM 
(

    SELECT npi
        , min(speciality) as speciality
        , count(*) as nb_diff_prescriptions
        , sum(nb_prescriptions) as sum_prescr
        , sum(nb_days) as sum_days
        , sum(cost) as sum_cost
        , max(nb_prescriptions) as max_prescr
        , max(nb_days) as max_days
        , max(cost) as max_cost
        , variance(nb_prescriptions) as var_prescr
        , variance(nb_days) as var_days
        , variance(cost) as var_cost    
    FROM partd_no_year 
    GROUP BY npi
)base
;