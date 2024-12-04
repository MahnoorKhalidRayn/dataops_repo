{{ config(
    materialized='incremental',
    unique_key='LINK_CONTACTS_KEY'
) }}

with source as (

    select
        HUB_CONTACT_KEY,
        HUB_ACCOUNT_KEY,
        HUB_USER_KEY,
        LINK_CONTACTS_KEY,
        to_timestamp(LOAD_DATE) as LOAD_DATE,
        RECORD_SOURCE
    from {{ source('TELELINK', 'BRONZE', 'LINK_CONTACTS') }}

),

transformed as (

    select
        HUB_CONTACT_KEY,
        HUB_ACCOUNT_KEY,
        HUB_USER_KEY,
        LINK_CONTACTS_KEY,
        LOAD_DATE,
        RECORD_SOURCE
    from source

)

select * from transformed