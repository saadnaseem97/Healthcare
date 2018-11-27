SELECT npi
    , sum("Total_Amount_of_Payment_USDollars") as payments_2013

FROM (
    SELECT distinct NPI , "NPPES_PROVIDER_FIRST_NAME" , "NPPES_PROVIDER_LAST_ORG_NAME", "NPPES_PROVIDER_CITY" ,"NPPES_PROVIDER_STATE"
    FROM partd_2013
    ) npis 
    
LEFT JOIN  payments pay
ON npis."NPPES_PROVIDER_FIRST_NAME" = pay."Physician_First_Name"
AND npis."NPPES_PROVIDER_LAST_ORG_NAME" = pay."Physician_Last_Name"
AND npis."NPPES_PROVIDER_CITY" = pay."Recipient_City"
AND npis."NPPES_PROVIDER_STATE" = pay."Recipient_State"

GROUP BY npi
;