
with base as (

    select * 
    from {{ ref('stg_shopify__collection_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__collection_tmp')),
                staging_columns=get_collection_columns()
            )
        }}
    from base
),

final as (
    
    select 
[0m22:58:06  [[33mWARNING[0m]: Configuration paths exist in your dbt_project.yml file which do not apply to any resources.
There are 2 unused configuration paths:
- models.netsuite
- models.ad_reporting

[0m22:58:09          _fivetran_deleted,
        _fivetran_synced,
        body_html,
        disjunctive,
        handle,
        id,
        published_at,
        published_scope,
        rules,
        sort_order,
        template_suffix,
        title,
        updated_at
    from fields
)

select *
from final
