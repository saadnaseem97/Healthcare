DROP TABLE PartD_concat;

CREATE TABLE PartD_concat(
	npi int,
	nb_prescriptions int,
	nb_days int,
	cost float,
	drug varchar(80),
	year int,
	speciality varchar(80)
);

INSERT INTO PartD_concat
SELECT * FROM
(
	SELECT 
	    alls.*
	    , infos.speciality
	    
	FROM (

	    SELECT npi
		, nb_prescriptions
		, nb_days
		, cost
		, drug
		, 2014 as year
	    FROM partd_2014 
	    
	    UNION
	    
	    SELECT npi
		, nb_prescriptions
		, nb_days
		, cost
		, drug
		, 2013 as year
	    FROM partd_2013  
	    ) alls
	JOIN (
	    SELECT npi, min("speciality") as speciality
	    FROM partd_2013
	    GROUP BY npi
	    ) infos 
	    
	ON infos.npi = alls.npi
)Concatt;
