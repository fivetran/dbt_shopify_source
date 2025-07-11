with base as (

    select * 
    from {{ ref('stg_shopify_gql__customer_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__customer_tmp')),
                staging_columns=get_graphql_customer_columns()
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
        id as customer_id,
        lower(email) as email,
        first_name,
        last_name,
        orders_count,
        {# default_address_id - need to join in #}
        phone,
        lower(state) as account_state,
        tax_exempt as is_tax_exempt,
        total_spent,
        verified_email as is_verified_email,
        note,
        currency,
        lower(email_marketing_consent_state) end as marketing_consent_state,
        lower(email_marketing_consent_opt_in_level) as marketing_opt_in_level,

        {{ shopify_source.fivetran_convert_timezone(column='cast(email_marketing_consent_updated_at as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as marketing_consent_updated_at,
        {{ shopify_source.fivetran_convert_timezone(column='cast(created_at as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as created_timestamp,
        {{ shopify_source.fivetran_convert_timezone(column='cast(updated_at as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as updated_timestamp,
        {{ shopify_source.fivetran_convert_timezone(column='cast(_fivetran_synced as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as _fivetran_synced,
        source_relation
        
        {{ fivetran_utils.fill_pass_through_columns('customer_pass_through_columns') }}

        {# 
        TODO - remove from macro
        _fivetran_deleted,
        can_delete,
        data_sale_opt_out,
        display_name,
        image_alt_text,
        image_height,
        image_id,
        image_url,
        image_width,
        is_data_sale_opt_out,
        last_order_id,
        lifetime_duration,
        locale,
        multipass_identifier,
        number_of_orders,
        product_subscriber_status,
        sms_marketing_consent_collected_from,
        sms_marketing_consent_opt_in_level,
        sms_marketing_consent_state,
        sms_marketing_consent_updated_at,
        statistics_predicted_spend_tier,
        unsubscribe_url,
        valid_email_address #}

    from fields
)

select *
from final
