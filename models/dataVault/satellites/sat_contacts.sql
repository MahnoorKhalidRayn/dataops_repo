{{ config(
    materialized='incremental',
    unique_key='HASH_DIFF'
) }}

WITH source AS (
    SELECT
        HUB_CONTACT_KEY,
        FIRSTNAME,
        LASTNAME,
        TITLE,
        EMAIL,
        PHONE,
        MAILINGADDRESS,
        LOAD_DATE,
        RECORD_SOURCE
    FROM {{ source('TELELINK', 'SAT_CONTACTS') }}
)

SELECT
    HUB_CONTACT_KEY,
    {{ hash('FIRSTNAME', 'LASTNAME', 'TITLE', 'EMAIL', 'PHONE', 'MAILINGADDRESS') }} AS HASH_DIFF,
    FIRSTNAME,
    LASTNAME,
    TITLE,
    EMAIL,
    PHONE,
    MAILINGADDRESS,
    LOAD_DATE,
    RECORD_SOURCE
FROM source