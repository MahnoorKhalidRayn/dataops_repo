{{ config(
    materialized='incremental',
    unique_key='HASH_DIFF'
) }}

WITH source AS (
    SELECT
        HUB_USER_KEY,
        FIRSTNAME,
        LASTNAME,
        EMAIL,
        ROLE,
        PROFILE,
        LOAD_DATE,
        RECORD_SOURCE
    FROM {{ source('TELELINK', 'SAT_USERS') }}
)

SELECT
    HUB_USER_KEY,
    {{ hash('FIRSTNAME', 'LASTNAME', 'EMAIL', 'ROLE', 'PROFILE') }} AS HASH_DIFF,
    FIRSTNAME,
    LASTNAME,
    EMAIL,
    ROLE,
    PROFILE,
    LOAD_DATE,
    RECORD_SOURCE
FROM source