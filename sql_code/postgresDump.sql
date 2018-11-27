-- su - postgres

-- 1011


-- psql partd
-- DROP TABLE partd_2013;


-- CREATE TABLE partd_2013 (
-- 	npi 							int,	--npi
-- 	nppes_provider_last_org_name	varchar(80),
-- 	nppes_provider_first_name		varchar(80),	
-- 	nppes_provider_city				varchar(80),	
-- 	nppes_provider_state			varchar(80),	
-- 	specialty_description			varchar(80),	--speciality
-- 	description_flag				varchar(80),	
-- 	drug_name						varchar(80),	--drug
-- 	generic_name					varchar(80),	
-- 	bene_count 						int,	
-- 	total_claim_count 				int,			--nb_perscriptions
-- 	total_30_day_fill_count 		float,	
-- 	total_day_supply 				int,			--nb_days
-- 	total_drug_cost 				float,			--cost
-- 	bene_count_ge65 				float,
-- 	bene_count_ge65_suppress_flag 	varchar(10),	
-- 	total_claim_count_ge65 			int,	
-- 	ge65_suppress_flag 				varchar(10),	
-- 	total_30_day_fill_count_ge65 	float,	
-- 	total_day_supply_ge65 			int,	
-- 	total_drug_cost_ge65 			float
-- );

-- CREATE TABLE partd_2014 (
-- 	npi 							int,	--npi
-- 	nppes_provider_last_org_name	varchar(80),
-- 	nppes_provider_first_name		varchar(80),	
-- 	nppes_provider_city				varchar(80),	
-- 	nppes_provider_state			varchar(80),	
-- 	specialty_description			varchar(80),	--speciality
-- 	description_flag				varchar(80),	
-- 	drug_name						varchar(80),	--drug
-- 	generic_name					varchar(80),	
-- 	bene_count 						int,	
-- 	total_claim_count 				int,			--nb_perscriptions
-- 	total_30_day_fill_count 		float,	
-- 	total_day_supply 				int,			--nb_days
-- 	total_drug_cost 				float,			--cost
-- 	bene_count_ge65 				float,
-- 	bene_count_ge65_suppress_flag 	varchar(10),	
-- 	total_claim_count_ge65 			int,	
-- 	ge65_suppress_flag 				varchar(10),	
-- 	total_30_day_fill_count_ge65 	float,	
-- 	total_day_supply_ge65 			int,	
-- 	total_drug_cost_ge65 			float
-- );

CREATE TABLE partd_2015 (
	npi 							int,	--npi
	nppes_provider_last_org_name	varchar(80),
	nppes_provider_first_name		varchar(80),	
	nppes_provider_city				varchar(80),	
	nppes_provider_state			varchar(80),	
	specialty_description			varchar(80),	--speciality
	description_flag				varchar(80),	
	drug_name						varchar(80),	--drug
	generic_name					varchar(80),	
	bene_count 						int,	
	total_claim_count 				int,			--nb_perscriptions
	total_30_day_fill_count 		float,	
	total_day_supply 				int,			--nb_days
	total_drug_cost 				float,			--cost
	bene_count_ge65 				float,
	bene_count_ge65_suppress_flag 	varchar(10),	
	total_claim_count_ge65 			int,	
	ge65_suppress_flag 				varchar(10),	
	total_30_day_fill_count_ge65 	float,	
	total_day_supply_ge65 			int,	
	total_drug_cost_ge65 			float
);

-- CREATE TABLE partd_2016 (
-- 	npi 							varchar(80),	--npi
-- 	nppes_provider_last_org_name	varchar(80),
-- 	nppes_provider_first_name		varchar(80),	
-- 	nppes_provider_city				varchar(80),	
-- 	nppes_provider_state			varchar(80),	
-- 	specialty_description			varchar(80),	--speciality
-- 	description_flag				varchar(80),	
-- 	drug_name						varchar(80),	--drug
-- 	generic_name					varchar(80),	
-- 	bene_count 						int,	
-- 	total_claim_count 				int,			--nb_perscriptions
-- 	total_30_day_fill_count 		float,	
-- 	total_day_supply 				int,			--nb_days
-- 	total_drug_cost 				float,			--cost
-- 	bene_count_ge65 				float,
-- 	bene_count_ge65_suppress_flag 	varchar(10),	
-- 	total_claim_count_ge65 			int,	
-- 	ge65_suppress_flag 				varchar(10),	
-- 	total_30_day_fill_count_ge65 	float,	
-- 	total_day_supply_ge65 			int,	
-- 	total_drug_cost_ge65 			float
-- );

-- CREATE TABLE partd_concat (
-- 	npi 							varchar(80),	--npi
-- 	nppes_provider_last_org_name	varchar(80),
-- 	nppes_provider_first_name		varchar(80),	
-- 	nppes_provider_city				varchar(80),	
-- 	nppes_provider_state			varchar(80),	
-- 	specialty_description			varchar(80),	--speciality
-- 	description_flag				varchar(80),	
-- 	drug_name						varchar(80),	--drug
-- 	generic_name					varchar(80),	
-- 	bene_count 						int,	
-- 	total_claim_count 				int,			--nb_perscriptions
-- 	total_30_day_fill_count 		float,	
-- 	total_day_supply 				int,			--nb_days
-- 	total_drug_cost 				float,			--cost
-- 	bene_count_ge65 				float,
-- 	bene_count_ge65_suppress_flag 	varchar(10),	
-- 	total_claim_count_ge65 			int,	
-- 	ge65_suppress_flag 				varchar(10),	
-- 	total_30_day_fill_count_ge65 	float,	
-- 	total_day_supply_ge65 			int,	
-- 	total_drug_cost_ge65 			float
-- );

COPY partd_2015
	FROM '/home/saadn22/Documents/Healthcare/Data/part-d-2015/PartD_Prescriber_PUF_NPI_Drug_15.txt' CSV HEADER
	DELIMITER E'\t' NULL '';

ALTER TABLE partd_2015
DROP COLUMN nppes_provider_last_org_name,
DROP COLUMN nppes_provider_first_name,
DROP COLUMN nppes_provider_city,
DROP COLUMN nppes_provider_state,
DROP COLUMN description_flag,
DROP COLUMN generic_name,
DROP COLUMN bene_count,
DROP COLUMN total_30_day_fill_count,
DROP COLUMN bene_count_ge65,
DROP COLUMN bene_count_ge65_suppress_flag,
DROP COLUMN total_claim_count_ge65,
DROP COLUMN ge65_suppress_flag,	
DROP COLUMN total_30_day_fill_count_ge65,	
DROP COLUMN total_day_supply_ge65,	
DROP COLUMN total_drug_cost_ge65;

ALTER TABLE partd_2015
ADD year int;

ALTER TABLE partd_2015
RENAME COLUMN specialty_description TO speciality;

ALTER TABLE partd_2015
RENAME COLUMN drug_name TO drug;

ALTER TABLE partd_2015
RENAME COLUMN total_claim_count TO nb_prescriptions;

ALTER TABLE partd_2015
RENAME COLUMN total_day_supply TO nb_days;

ALTER TABLE partd_2015
RENAME COLUMN total_drug_cost TO cost;

-- UPDATE partd_2013
-- SET year = 2013;

-----------------------------------------
-- COPY partd_2014 
-- 	FROM PROGRAM 'tail -n +2 /home/shahzeb/Documents/Healthcare/Data/PartD_Prescriber_PUF_NPI_Drug_14.txt' 
-- 	WITH DELIMITER E'\t' NULL '';

-- ALTER TABLE partd_2014
-- DROP COLUMN nppes_provider_last_org_name,
-- DROP COLUMN nppes_provider_first_name,
-- DROP COLUMN nppes_provider_city,
-- DROP COLUMN nppes_provider_state,
-- DROP COLUMN description_flag,
-- DROP COLUMN generic_name,
-- DROP COLUMN bene_count,
-- DROP COLUMN total_30_day_fill_count,
-- DROP COLUMN bene_count_ge65,
-- DROP COLUMN bene_count_ge65_suppress_flag,
-- DROP COLUMN total_claim_count_ge65,
-- DROP COLUMN ge65_suppress_flag,	
-- DROP COLUMN total_30_day_fill_count_ge65,	
-- DROP COLUMN total_day_supply_ge65,	
-- DROP COLUMN total_drug_cost_ge65;

-- ALTER TABLE partd_2014
-- ADD year int;

-- UPDATE partd_2014
-- SET year = 2014;
-- -----------------------------------------

-- COPY partd_2015 
-- 	FROM PROGRAM 'tail -n +2 /home/shahzeb/Documents/Healthcare/Data/PartD_Prescriber_PUF_NPI_Drug_15.txt' 
-- 	WITH DELIMITER E'\t' NULL '';

-- ALTER TABLE partd_2015
-- DROP COLUMN nppes_provider_last_org_name,
-- DROP COLUMN nppes_provider_first_name,
-- DROP COLUMN nppes_provider_city,
-- DROP COLUMN nppes_provider_state,
-- DROP COLUMN description_flag,
-- DROP COLUMN generic_name,
-- DROP COLUMN bene_count,
-- DROP COLUMN total_30_day_fill_count,
-- DROP COLUMN bene_count_ge65,
-- DROP COLUMN bene_count_ge65_suppress_flag,
-- DROP COLUMN total_claim_count_ge65,
-- DROP COLUMN ge65_suppress_flag,	
-- DROP COLUMN total_30_day_fill_count_ge65,	
-- DROP COLUMN total_day_supply_ge65,	
-- DROP COLUMN total_drug_cost_ge65;

-- ALTER TABLE partd_2015
-- ADD year int;

-- UPDATE partd_2015
-- SET year = 2015;
-----------------------------------------
-- COPY partd_2016 
-- 	FROM PROGRAM 'tail -n +2 /home/shahzeb/Documents/Healthcare/Data/PartD_Prescriber_PUF_NPI_Drug_16.txt' 
-- 	WITH DELIMITER E'\t' NULL '';


-- ALTER TABLE partd_2016
-- DROP COLUMN nppes_provider_last_org_name,
-- DROP COLUMN nppes_provider_first_name,
-- DROP COLUMN nppes_provider_city,
-- DROP COLUMN nppes_provider_state,
-- DROP COLUMN description_flag,
-- DROP COLUMN generic_name,
-- DROP COLUMN bene_count,
-- DROP COLUMN total_30_day_fill_count,
-- DROP COLUMN bene_count_ge65,
-- DROP COLUMN bene_count_ge65_suppress_flag,
-- DROP COLUMN total_claim_count_ge65,
-- DROP COLUMN ge65_suppress_flag,	
-- DROP COLUMN total_30_day_fill_count_ge65,	
-- DROP COLUMN total_day_supply_ge65,	
-- DROP COLUMN total_drug_cost_ge65;

-- ALTER TABLE partd_2016
-- ADD year int;

-- UPDATE partd_2016
-- SET year = 2016;


-- \i /home/shahzeb/Documents/Healthcare/sql_codes/create_partd_concat.sql