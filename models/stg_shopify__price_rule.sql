
with base as (

    select * 
    from {{ ref('stg_shopify__price_rule_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__price_rule_tmp')),
                staging_columns=get_price_rule_columns()
            )
        }}
    from base
),

final as (
    
    select 
        _fivetran_synced,
        allocation_limit,
        allocation_method,
        created_at,
        customer_selection,
        ends_at,
        id as price_rule_id,
        once_per_customer as is_once_per_customer,
        prerequisite_quantity_range as prereq_min_quantity,
        prerequisite_shipping_price_range as prereq_max_shipping_price,
        prerequisite_subtotal_range as prereq_min_subtotal,
        prerequisite_to_entitlement_purchase_prerequisite_amount as prereq_min_purchase_quantity_for_entitlement,
        quantity_ratio_entitled_quantity as prereq_buy_x_get_this,
        quantity_ratio_prerequisite_quantity as prereq_buy_this_get_y,
        starts_at,
        target_selection,
        target_type,
        title,
        updated_at,
        usage_limit,
        value,
        value_type
        
    from fields
)

select *
from final
