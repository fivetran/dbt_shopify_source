
with base as (

    select * 
    from {{ ref('stg_shopify__collection_product_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__collection_product_tmp')),
                staging_columns=get_collection_product_columns()
            )
        }}
    from base
),

final as (
    
    select 
[0m22:58:11  [[33mWARNING[0m]: Configuration paths exist in your dbt_project.yml file which do not apply to any resources.
There are 2 unused configuration paths:
- models.netsuite
- models.ad_reporting

[0m22:58:14          _fivetran_synced,
        collection_id,
        product_id
    from fields
)

select *
from final
