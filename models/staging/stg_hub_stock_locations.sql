{{ config(
    materialized='incremental',
    unique_key='HUB_LOCATION_KEY'
) }}

with source as (

    select
        HUB_LOCATION_KEY,
        LOCATION_BUSINESS_KEY,
        to_timestamp(LOAD_DATE) as LOAD_DATE,
        RECORD_SOURCE
    from {{ source('TELELINK', 'BRONZE', 'HUB_STOCK_LOCATIONS') }}

),

transformed as (

    select
        HUB_LOCATION_KEY,
        LOCATION_BUSINESS_KEY,
        LOAD_DATE,
        RECORD_SOURCE
    from source

)

select * from transformed