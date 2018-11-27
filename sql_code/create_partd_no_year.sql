CREATE TABLE PartD_no_year(
	npi int,
	drug varchar(80),	
	nb_prescriptions int,
	nb_days int,
	cost float,
	speciality varchar(80)
);

INSERT INTO PartD_no_year
SELECT * FROM (

	SELECT
	    npi
	    , drug
	    , sum("nb_prescriptions") as nb_prescriptions
	    , sum("nb_days") as nb_days
	    , sum("cost") as cost 
	    , min(speciality) as speciality
	FROM PartD_concat   
	GROUP BY NPI, drug
)noYear;
