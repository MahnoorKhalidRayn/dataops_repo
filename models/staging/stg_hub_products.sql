{{ config(
    materialized='incremental',
    unique_key='HUB_PRODUCT_KEY'
) }}

with source as (

    select
        HUB_PRODUCT_KEY,
        PRODUCT_BUSINESS_KEY,
        to_timestamp(LOAD_DATE) as LOAD_DATE,
        RECORD_SOURCE
    from {{ source('TELELINK', 'BRONZE', 'HUB_PRODUCTS') }}

),

transformed as (

    select
        HUB_PRODUCT_KEY,
        PRODUCT_BUSINESS_KEY,
        LOAD_DATE,
        RECORD_SOURCE
    from source

)

select * from transformed