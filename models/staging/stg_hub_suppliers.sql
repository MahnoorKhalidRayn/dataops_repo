{{ config(
    materialized='incremental',
    unique_key='HUB_SUPPLIER_KEY'
) }}

with source as (

    select
        HUB_SUPPLIER_KEY,
        SUPPLIER_BUSINESS_KEY,
        to_timestamp(LOAD_DATE) as LOAD_DATE,
        RECORD_SOURCE
    from {{ source('TELELINK', 'BRONZE', 'HUB_SUPPLIERS') }}

),

transformed as (

    select
        HUB_SUPPLIER_KEY,
        SUPPLIER_BUSINESS_KEY,
        LOAD_DATE,
        RECORD_SOURCE
    from source

)

select * from transformed