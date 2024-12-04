{{ config(materialized='incremental', unique_key='hub_product_key') }}

with source as (
    select
        md5(concat(PRODUCT_BUSINESS_KEY, LOAD_DATE, RECORD_SOURCE)) as hub_product_key,
        PRODUCT_BUSINESS_KEY,
        to_timestamp(LOAD_DATE) as load_date,
        RECORD_SOURCE
    from {{ source('bronze', 'HUB_PRODUCTS') }}
    {% if is_incremental() %}
        where load_date > (select max(load_date) from {{ this }})
    {% endif %}
)

select * from source