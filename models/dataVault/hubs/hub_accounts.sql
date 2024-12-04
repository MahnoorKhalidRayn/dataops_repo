{{ config(materialized='incremental', unique_key='hub_account_key') }}

with source as (
    select
        md5(concat(ACCOUNT_BUSINESS_KEY, LOAD_DATE, RECORD_SOURCE)) as hub_account_key,
        ACCOUNT_BUSINESS_KEY,
        to_timestamp(LOAD_DATE) as load_date,
        RECORD_SOURCE
    from {{ source('bronze', 'HUB_ACCOUNTS') }}
    {% if is_incremental() %}
        where load_date > (select max(load_date) from {{ this }})
    {% endif %}
)

select * from source