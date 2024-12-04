{{ config(
    materialized='incremental',
    unique_key='HASH_DIFF'
) }}

WITH source AS (
    SELECT
        HUB_LOCATION_KEY,
        LOCATIONNAME,
        LOCATIONTYPE,
        LOAD_DATE,
        RECORD_SOURCE
    FROM {{ source('TELELINK', 'SAT_STOCK_LOCATIONS') }}
)

SELECT
    HUB_LOCATION_KEY,
    {{ hash('LOCATIONNAME', 'LOCATIONTYPE') }} AS HASH_DIFF,
    LOCATIONNAME,
    LOCATIONTYPE,
    LOAD_DATE,
    RECORD_SOURCE
FROM source