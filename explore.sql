-- synthea datasets
-- `bigquery-public-data.fhir_synthea.condition`, `bigquery-public-data.fhir_synthea.patient`, `bigquery-public-data.fhir_synthea.medication_request`

-- how many patients in condition table, patient table, and how many ids overlap
select count(*) 
from (select distinct subject.patientId
    from `bigquery-public-data.fhir_synthea.condition`
    group by subject.patientId);

select count(*)
from(select distinct id
    from `bigquery-public-data.fhir_synthea.patient`
    group by id)

select count(*)
from `bigquery-public-data.fhir_synthea.patient`
where id in (select distinct subject.patientId
            from `bigquery-public-data.fhir_synthea.condition`
            group by subject.patientId)

-- get list of codes for each user and time of occurence
select subject.patientId,
    code.coding[safe_offset(0)].code,
    code.coding[safe_offset(0)].display,
    assertedDate
from `bigquery-public-data.fhir_synthea.condition`;

-- basic demographics
select id,
    birthDate,
    gender,
    us_core_race.text.value.string,
    communication[safe_offset(0)].preferred,
    communication[safe_offset(0)].language.text,
    birthPlace.value.address.city,
    birthPlace.value.address.state,
    deceased.boolean,
    deceased.dateTime
from `bigquery-public-data.fhir_synthea.patient`;

