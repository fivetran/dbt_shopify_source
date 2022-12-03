
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
[0m22:58:27  [[33mWARNING[0m]: Configuration paths exist in your dbt_project.yml file which do not apply to any resources.
There are 2 unused configuration paths:
- models.netsuite
- models.ad_reporting

[0m22:58:30          _fivetran_deleted,
        _fivetran_synced,
        active,
        address_1,
        address_2,
        city,
        country,
        country_code,
        country_name,
        created_at,
        id,
        legacy,
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
