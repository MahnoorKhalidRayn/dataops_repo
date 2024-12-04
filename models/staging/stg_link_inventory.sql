{{ config(
    materialized='incremental',
    unique_key='LINK_INVENTORY_KEY'
) }}

with source as (

    select
        HUB_INVENTORY_KEY,
        HUB_PRODUCT_KEY,
        HUB_LOCATION_KEY,
        LINK_INVENTORY_KEY,
        to_timestamp(LOAD_DATE) as LOAD_DATE,
        RECORD_SOURCE
    from {{ source('TELELINK', 'BRONZE', 'LINK_INVENTORY') }}

),

transformed as (

    select
        HUB_INVENTORY_KEY,
        HUB_PRODUCT_KEY,
        HUB_LOCATION_KEY,
        LINK_INVENTORY_KEY,
        LOAD_DATE,
        RECORD_SOURCE
    from source

)

select * from transformed