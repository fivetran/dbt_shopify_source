{{ config(enabled=var('shopify_using_all_metafields', False) or var('shopify_using_collection_metafields', False) or var('shopify_using_customer_metafields', False) or var('shopify_using_order_metafields', False) or var('shopify_using_product_metafields', False) or var('shopify_using_product_image_metafields', False) or var('shopify_using_product_variant_metafields', False) or var('shopify_using_shop_metafields', False)) }}

{{
    fivetran_utils.union_data(
        table_identifier='metafield', 
        database_variable='shopify_database', 
        schema_variable='shopify_schema', 
        default_database=target.database,
        default_schema='shopify',
        default_variable='metafield_source',
        union_schema_variable='shopify_union_schemas',
        union_database_variable='shopify_union_databases'
    )
}}