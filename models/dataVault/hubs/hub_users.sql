{{ config(materialized='incremental', unique_key='hub_user_key') }}

with source as (
    select
        md5(concat(USER_BUSINESS_KEY, LOAD_DATE, RECORD_SOURCE)) as hub_user_key,
        USER_BUSINESS_KEY,
        to_timestamp(LOAD_DATE) as load_date,
        RECORD_SOURCE
    from {{ source('bronze', 'HUB_USERS') }}
    {% if is_incremental() %}
        where load_date > (select max(load_date) from {{ this }})
    {% endif %}
)

select * from source