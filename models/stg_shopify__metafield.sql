
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

        {{ fivetran_utils.source_relation(
            union_schema_variable='shopify_union_schemas', 
            union_database_variable='shopify_union_databases') 
        }}

    from base

    {{ shopify_source.result_if_table_exists(
        table_ref=ref('stg_shopify__abandoned_checkout_discount_code_tmp'),
        result_statement="",
        if_empty="limit 0")
    }}
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
        lower(owner_resource) as owner_resource,
        {{ dbt_date.convert_timezone(column='cast(created_at as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as created_at,
        {{ dbt_date.convert_timezone(column='cast(updated_at as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as updated_at,
        {{ dbt_date.convert_timezone(column='cast(_fivetran_synced as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as _fivetran_synced,
        lower({{ dbt.concat(["namespace","'_'","key"]) }}) as metafield_reference,
        row_number() over(partition by id, source_relation order by updated_at desc) = 1 as is_most_recent_record,
        source_relation
        
    from fields
)

select *
from final
