
with base as (

    select * 
    from {{ ref('stg_shopify__product_image_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__product_image_tmp')),
                staging_columns=get_product_image_columns()
            )
        }}
    from base
),

final as (
    
    select 
[0m22:57:56  [[33mWARNING[0m]: Configuration paths exist in your dbt_project.yml file which do not apply to any resources.
There are 2 unused configuration paths:
- models.netsuite
- models.ad_reporting

[0m22:57:59          _fivetran_deleted,
        _fivetran_synced,
        alt,
        created_at,
        height,
        id,
        is_default,
        position,
        product_id,
        src,
        updated_at,
        variant_ids,
        width
    from fields
)

select *
from final
