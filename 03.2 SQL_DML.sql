
######## ZIP_CODE

SELECT *
FROM vaxchi.dim_zipcode;

SELECT *
FROM `raw_data`.`zipcode`;

INSERT INTO vaxchi.dim_zipcode (zipcode_id, zipcode, population, city, state)
SELECT zipcodeID, zipcode, population, city, state
FROM raw_data.zipcode;

##### TEST_LOC

INSERT INTO vaxchi.dim_test_loc(
    test_facility_id,
    zipcode_id,
    facility_test_name,
    phone_test,
    address_test,
    web_site_test
)
(SELECT
    test_facilityID,
    zipcodeID,
    facility_test,
    phone,
    address_test,
    web_site
FROM
    raw_data.test_locations);
    
SELECT *
FROM vaxchi.dim_test_loc;

##### CCVI

INSERT INTO vaxchi.dim_ccvi(
    ccvi_id,
    zipcode_id,
    ccvi_score,
    ccvi_category
)
(SELECT
    ccvi_id,
    zipcode_id,
    ccvi_score,
    ccvi_category
FROM
    raw_data.dim_ccvi);
    
SELECT * FROM vaxchi.dim_ccvi;

##### DATE
insert into vaxchi.dim_date (date_id, full_date, month, year)
select dateID, full_date, month, year from raw_data.date;

##### VAXLOC
insert into vaxchi.dim_vax_loc (vax_facility_id, facility_vax_name, address_vax, zipcode_id, website_vax, phone_vax)
select vax_facilityID, facility_name_vax, address_vax, zipcodeID, url, phone
from raw_data.vax_loc;

##### FACT VAXCHI

INSERT INTO vaxchi.fact_vaxchi(
    vaxchi_id,
    zipcode_id,
    date_id,
    sum_total_first_doses,
    sum_total_second_doses,
    sum_first_doses_5_11,
    sum_first_doses_12_17,
    sum_first_doses_18_64,
    sum_first_doses_65_plus,
    sum_second_dose_5_11,
    sum_second_dose_12_17,
    sum_second_dose_18_64,
    sum_second_dose_65_plus,
    sum_covid_cases,
    sum_covid_tests,
    sum_covid_deaths
)
(SELECT
    vax_zip_groupID,
    zipcodeID,
    date_id,
    `1st_dose_sum_month`,
    `2nd_dose_sum_month`,
    sum_first_dose_5_11,
    sum_first_dose_12_17,
    sum_first_dose_18_64,
    sum_first_dose_65_plus,
    sum_second_dose_5_11,
    sum_second_dose_12_17,
    sum_second_dose_18_64,
    sum_second_dose_65_plus,
    sum_covid_cases,
    sum_covid_tests,
    sum_covid_deaths
FROM
    raw_data.fact_vaxchi);
    
SELECT *
FROM vaxchi.fact_vaxchi
LIMIT 10;


