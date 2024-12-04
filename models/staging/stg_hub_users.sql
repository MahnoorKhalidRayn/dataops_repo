{{ config(
    materialized='incremental',
    unique_key='HUB_USER_KEY'
) }}

with source as (

    select
        HUB_USER_KEY,
        USER_BUSINESS_KEY,
        to_timestamp(LOAD_DATE) as LOAD_DATE,
        RECORD_SOURCE
    from {{ source('TELELINK', 'BRONZE', 'HUB_USERS') }}

),

transformed as (

    select
        HUB_USER_KEY,
        USER_BUSINESS_KEY,
        LOAD_DATE,
        RECORD_SOURCE
    from source

)

select * from transformed