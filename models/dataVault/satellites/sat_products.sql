{{ config(
    materialized='incremental',
    unique_key='HASH_DIFF'
) }}

WITH source AS (
    SELECT
        HUB_PRODUCT_KEY,
        PRODUCTNAME,
        PRODUCTCODE,
        CATEGORYID,
        SALEPRICE,
        COSTPRICE,
        DESCRIPTION,
        UOM,
        LOAD_DATE,
        RECORD_SOURCE
    FROM {{ source('TELELINK', 'SAT_PRODUCTS') }}
)

SELECT
    HUB_PRODUCT_KEY,
    {{ hash('PRODUCTNAME', 'PRODUCTCODE', 'CATEGORYID', 'SALEPRICE', 'COSTPRICE', 'DESCRIPTION', 'UOM') }} AS HASH_DIFF,
    PRODUCTNAME,
    PRODUCTCODE,
    CAST(CATEGORYID AS INT) AS CATEGORYID,
    CAST(SALEPRICE AS DECIMAL) AS SALEPRICE,
    CAST(COSTPRICE AS DECIMAL) AS COSTPRICE,
    DESCRIPTION,
    UOM,
    LOAD_DATE,
    RECORD_SOURCE
FROM source