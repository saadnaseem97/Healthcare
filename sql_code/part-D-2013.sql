CREATE TABLE public."part-D-2013"
(
  npi bigint,
  nppes_provider_last_org_name text,
  nppes_provider_first_name text,
  nppes_provider_city text,
  nppes_provider_state text,
  specialty_description text,
  description_flag text,
  drug_name text,
  generic_name text,
  bene_count bigint,
  total_claim_count bigint,
  total_30_day_fill_count double precision,
  total_day_supply bigint,
  total_drug_cost double precision,
  bene_count_ge65 bigint,
  bene_count_ge65_suppress_flag text,
  total_claim_count_ge65 bigint,
  ge65_suppress_flag text,
  total_30_day_fill_count_ge65 double precision,
  total_day_supply_ge65 bigint,
  total_drug_cost_ge65 double precision
);

COPY public."part-D-2013" FROM '/home/saadn22/Documents/Healthcare/Data/part-d-2013/PartD_Prescriber_PUF_NPI_Drug_13.txt' DELIMITER E'\t' CSV HEADER;