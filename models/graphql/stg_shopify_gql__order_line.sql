
with base as (

    select * 
    from {{ ref('stg_shopify_gql__order_line_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__order_line_tmp')),
                staging_columns=get_graphql_order_line_columns()
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
        _fivetran_synced,
        current_quantity,
        discounted_total_set_pres_amount,
        discounted_total_set_pres_currency_code,
        discounted_total_set_shop_amount,
        discounted_total_set_shop_currency_code,
        discounted_unit_price_after_all_disc_set_pres_amount,
        discounted_unit_price_after_all_disc_set_pres_currency_code,
        discounted_unit_price_after_all_disc_set_shop_amount,
        discounted_unit_price_after_all_disc_set_shop_currency_code,
        discounted_unit_price_set_pres_amount,
        discounted_unit_price_set_pres_currency_code,
        discounted_unit_price_set_shop_amount,
        discounted_unit_price_set_shop_currency_code,
        id as order_line_id,
        image_alt_text,
        image_height,
        image_id,
        image_url,
        image_width,
        is_gift_card,
        line_item_group_id,
        line_item_group_quantity,
        line_item_group_title,
        line_item_group_variant_id,
        line_item_group_variant_sku,
        merchant_editable,
        name as order_line_name,
        non_fulfillable_quantity,
        order_id,
        original_total_set_pres_amount,
        original_total_set_pres_currency_code,
        original_total_set_shop_amount,
        original_total_set_shop_currency_code,
        original_unit_price_set_pres_amount,
        original_unit_price_set_pres_currency_code,
        original_unit_price_set_shop_amount,
        original_unit_price_set_shop_currency_code,
        product_id,
        quantity,
        refundable_quantity,
        requires_shipping,
        restockable,
        selling_plan_id,
        selling_plan_name,
        sku,
        staff_member_id,
        taxable,
        title,
        total_discount_set_pres_amount,
        total_discount_set_pres_currency_code,
        total_discount_set_shop_amount,
        total_discount_set_shop_currency_code,
        unfulfilled_discounted_total_set_pres_amount,
        unfulfilled_discounted_total_set_pres_currency_code,
        unfulfilled_discounted_total_set_shop_amount,
        unfulfilled_discounted_total_set_shop_currency_code,
        unfulfilled_original_total_set_pres_amount,
        unfulfilled_original_total_set_pres_currency_code,
        unfulfilled_original_total_set_shop_amount,
        unfulfilled_original_total_set_shop_currency_code,
        unfulfilled_quantity,
        variant_id,
        variant_title,
        vendor
    from fields
)

select *
from final
