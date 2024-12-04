{{ config(
    materialized='incremental',
    unique_key='HASH_DIFF'
) }}

WITH source AS (
    SELECT
        HUB_INVENTORY_KEY,
        PRODUCTNAME,
        QUANTITYONHAND,
        QUANTITYRESERVED,
        LOAD_DATE,
        RECORD_SOURCE
    FROM {{ source('TELELINK', 'SAT_INVENTORY') }}
)

SELECT
    HUB_INVENTORY_KEY,
    {{ hash('PRODUCTNAME', 'QUANTITYONHAND', 'QUANTITYRESERVED') }} AS HASH_DIFF,
    PRODUCTNAME,
    CAST(QUANTITYONHAND AS INT) AS QUANTITYONHAND,
    CAST(QUANTITYRESERVED AS INT) AS QUANTITYRESERVED,
    LOAD_DATE,
    RECORD_SOURCE
FROM source