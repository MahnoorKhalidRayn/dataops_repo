{{ config(materialized='incremental', unique_key='LINK_CONTACTS_KEY') }}

WITH source_data AS (
    SELECT
        HUB_CONTACT_KEY,
        HUB_ACCOUNT_KEY,
        HUB_USER_KEY,
        LOAD_DATE::timestamp AS LOAD_DATE,
        RECORD_SOURCE
    FROM {{ source('TELELINK', 'LINK_CONTACTS') }}
),
hashed_data AS (
    SELECT
        HUB_CONTACT_KEY,
        HUB_ACCOUNT_KEY,
        HUB_USER_KEY,
        LOAD_DATE,
        RECORD_SOURCE,
        md5(concat_ws('|', HUB_CONTACT_KEY, HUB_ACCOUNT_KEY, HUB_USER_KEY)) AS LINK_CONTACTS_KEY
    FROM source_data
)

SELECT * FROM hashed_data