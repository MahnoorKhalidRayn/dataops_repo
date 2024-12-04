{{ config(
    materialized='incremental',
    unique_key='HASH_DIFF'
) }}

WITH source AS (
    SELECT
        HUB_EMPLOYEE_KEY,
        FIRSTNAME,
        LASTNAME,
        DATEOFBIRTH,
        GENDER,
        HIREDATE,
        JOBID,
        DEPARTMENTID,
        MANAGERID,
        EMAIL,
        PHONE,
        ADDRESS,
        EMPLOYMENTSTATUS,
        LOAD_DATE,
        RECORD_SOURCE
    FROM {{ source('TELELINK', 'SAT_EMPLOYEES') }}
)

SELECT
    HUB_EMPLOYEE_KEY,
    {{ hash('FIRSTNAME', 'LASTNAME', 'DATEOFBIRTH', 'GENDER', 'HIREDATE', 'JOBID', 'DEPARTMENTID', 'MANAGERID', 'EMAIL', 'PHONE', 'ADDRESS', 'EMPLOYMENTSTATUS') }} AS HASH_DIFF,
    FIRSTNAME,
    LASTNAME,
    DATEOFBIRTH,
    GENDER,
    HIREDATE,
    JOBID,
    DEPARTMENTID,
    MANAGERID,
    EMAIL,
    PHONE,
    ADDRESS,
    EMPLOYMENTSTATUS,
    LOAD_DATE,
    RECORD_SOURCE
FROM source