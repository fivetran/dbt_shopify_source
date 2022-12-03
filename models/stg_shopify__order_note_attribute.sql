
with base as (

    select * 
    from {{ ref('stg_shopify__order_note_attribute_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__order_note_attribute_tmp')),
                staging_columns=get_order_note_attribute_columns()
            )
        }}
    from base
),

final as (
    
    select 
[0m22:57:29  [[33mWARNING[0m]: Configuration paths exist in your dbt_project.yml file which do not apply to any resources.
There are 2 unused configuration paths:
- models.ad_reporting
- models.netsuite

[0m22:57:32          _fivetran_synced,
        name,
        order_id,
        value
    from fields
)

select *
from final
