{{ config(materialized='incremental', unique_key='LINK_INVENTORY_KEY') }}

WITH source_data AS (
    SELECT
        HUB_INVENTORY_KEY,
        HUB_PRODUCT_KEY,
        HUB_LOCATION_KEY,
        LOAD_DATE::timestamp AS LOAD_DATE,
        RECORD_SOURCE
    FROM {{ source('TELELINK', 'LINK_INVENTORY') }}
),
hashed_data AS (
    SELECT
        HUB_INVENTORY_KEY,
        HUB_PRODUCT_KEY,
        HUB_LOCATION_KEY,
        LOAD_DATE,
        RECORD_SOURCE,
        md5(concat_ws('|', HUB_INVENTORY_KEY, HUB_PRODUCT_KEY, HUB_LOCATION_KEY)) AS LINK_INVENTORY_KEY
    FROM source_data
)

SELECT * FROM hashed_data