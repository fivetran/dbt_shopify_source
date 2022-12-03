
with base as (

    select * 
    from {{ ref('stg_shopify__inventory_level_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__inventory_level_tmp')),
                staging_columns=get_inventory_level_columns()
            )
        }}
    from base
),

final as (
    
    select 
[0m22:58:21  [[33mWARNING[0m]: Configuration paths exist in your dbt_project.yml file which do not apply to any resources.
There are 2 unused configuration paths:
- models.netsuite
- models.ad_reporting

[0m22:58:24          _fivetran_synced,
        available,
        inventory_item_id,
        location_id,
        updated_at
    from fields
)

select *
from final
