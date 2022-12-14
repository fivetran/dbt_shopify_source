with base as (

    select * 
    from {{ ref('stg_shopify__customer_tmp') }}

),

fields as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__customer_tmp')),
                staging_columns=get_customer_columns()
            )
        }}

        {{ fivetran_utils.source_relation(
            union_schema_variable='shopify_union_schemas', 
            union_database_variable='shopify_union_databases') 
        }}

    from base

),

final as (

    select 
        accepts_marketing as has_accepted_marketing,
        email_marketing_consent_state,
        default_address_id,
        email,
        first_name,
        id as customer_id,
        last_name,
        orders_count,
        phone,
        state as account_state,
        tax_exempt as is_tax_exempt,
        total_spent,
        verified_email as is_verified_email,
        note,
        coalesce(marketing_opt_in_level, email_marketing_consent_opt_in_level) as marketing_opt_in_level,
        lifetime_duration,
        currency,
        cast( coalesce(accepts_marketing_updated_at, email_marketing_consent_consent_updated_at) as {{ dbt.type_timestamp() }}) as accepts_marketing_updated_at,
        cast(updated_at as {{ dbt.type_timestamp() }}) as updated_at,
        cast(created_at as {{ dbt.type_timestamp() }}) as created_at,
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        source_relation
        
        {{ fivetran_utils.fill_pass_through_columns('customer_pass_through_columns') }}

    from fields
    
)

select * 
from final