
with base as (

    select * 
    from {{ ref('stg_shopify__metafield_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__metafield_tmp')),
                staging_columns=get_metafield_columns()
            )
        }}
    from base
),

final as (
    
    select 
        id as metafield_id,
        description,
        namespace,
        key,
        value,
        lower(coalesce(type, value_type)) as value_type,
        owner_id as owner_resource_id,
        owner_resource,
        created_at,
        updated_at,
        _fivetran_synced
        
    from fields
)

select *
from final
