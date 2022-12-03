
with base as (

    select * 
    from {{ ref('stg_shopify__tender_transaction_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__tender_transaction_tmp')),
                staging_columns=get_tender_transaction_columns()
            )
        }}
    from base
),

final as (
    
    select 
[0m22:57:19  [[33mWARNING[0m]: Configuration paths exist in your dbt_project.yml file which do not apply to any resources.
There are 2 unused configuration paths:
- models.netsuite
- models.ad_reporting

[0m22:57:22          _fivetran_synced,
        amount,
        currency,
        id,
        order_id,
        payment_details_credit_card_company,
        payment_details_credit_card_number,
        payment_method,
        processed_at,
        remote_reference,
        test,
        user_id
    from fields
)

select *
from final
