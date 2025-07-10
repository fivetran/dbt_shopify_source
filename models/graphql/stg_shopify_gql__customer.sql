
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
        source_relation, 
        _fivetran_deleted,
        _fivetran_synced,
        can_delete,
        created_at,
        currency,
        data_sale_opt_out,
        display_name,
        email,
        email_marketing_consent_opt_in_level,
        email_marketing_consent_state,
        email_marketing_consent_updated_at,
        first_name,
        id as customer_id,
        image_alt_text,
        image_height,
        image_id,
        image_url,
        image_width,
        is_data_sale_opt_out,
        last_name,
        last_order_id,
        lifetime_duration,
        locale,
        multipass_identifier,
        note,
        number_of_orders,
        orders_count,
        phone,
        product_subscriber_status,
        sms_marketing_consent_collected_from,
        sms_marketing_consent_opt_in_level,
        sms_marketing_consent_state,
        sms_marketing_consent_updated_at,
        state,
        statistics_predicted_spend_tier,
        tax_exempt,
        total_spent,
        unsubscribe_url,
        updated_at,
        valid_email_address,
        verified_email
    from fields
)

select *
from final
