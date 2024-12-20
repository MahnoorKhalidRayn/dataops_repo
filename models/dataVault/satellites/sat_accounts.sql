{{ config(
    materialized='incremental',
    unique_key='HASH_DIFF'
) }}

WITH source AS (
    SELECT
        HUB_ACCOUNT_KEY,
        ACCOUNTNAME,
        ACCOUNTTYPE,
        INDUSTRY,
        ANNUALREVENUE,
        PHONE,
        WEBSITE,
        BILLINGADDRESS,
        SHIPPINGADDRESS,
        OWNERID,
        LOAD_DATE,
        RECORD_SOURCE
    FROM {{ source('TELELINK', 'SAT_ACCOUNTS') }}
)

SELECT
    HUB_ACCOUNT_KEY,
    {{ hash('ACCOUNTNAME', 'ACCOUNTTYPE', 'INDUSTRY', 'ANNUALREVENUE', 'PHONE', 'WEBSITE', 'BILLINGADDRESS', 'SHIPPINGADDRESS', 'OWNERID') }} AS HASH_DIFF,
    ACCOUNTNAME,
    ACCOUNTTYPE,
    INDUSTRY,
    ANNUALREVENUE,
    PHONE,
    WEBSITE,
    BILLINGADDRESS,
    SHIPPINGADDRESS,
    OWNERID,
    LOAD_DATE,
    RECORD_SOURCE
FROM source