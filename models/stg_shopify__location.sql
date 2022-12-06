
with base as (

    select * 
    from {{ ref('stg_shopify__location_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__location_tmp')),
                staging_columns=get_location_columns()
            )
        }}
    from base
),

final as (
    
    select 
        _fivetran_deleted as is_deleted,
        _fivetran_synced,
        active as is_active,
        address_1,
        address_2,
        city,
        coalesce(country_code, country) as country_code,
        country_name,
        created_at,
        id as location_id,
        legacy as is_legacy,
        localized_country_name,
        localized_province_name,
        name,
        phone,
        province,
        province_code,
        updated_at,
        zip

    from fields
)

select *
from final
