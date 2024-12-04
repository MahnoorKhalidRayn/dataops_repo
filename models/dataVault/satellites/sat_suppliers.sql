{{ config(
    materialized='incremental',
    unique_key='HASH_DIFF'
) }}

WITH source AS (
    SELECT
        HUB_SUPPLIER_KEY,
        SUPPLIERNAME,
        EMAIL,
        PHONE,
        ADDRESS,
        LOAD_DATE,
        RECORD_SOURCE
    FROM {{ source('TELELINK', 'SAT_SUPPLIERS') }}
)

SELECT
    HUB_SUPPLIER_KEY,
    {{ hash('SUPPLIERNAME', 'EMAIL', 'PHONE', 'ADDRESS') }} AS HASH_DIFF,
    SUPPLIERNAME,
    EMAIL,
    PHONE,
    ADDRESS,
    LOAD_DATE,
    RECORD_SOURCE
FROM source