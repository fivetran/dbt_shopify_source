-- this model will be all NULL until you create a refund in Shopify

{{
    shopify_source.shopify_union_data(
        table_identifier='refund', 
        database_variable='shopify_database', 
        schema_variable='shopify_schema', 
        default_database=target.database,
        default_schema='shopify',
        default_variable='refund_source',
        union_schema_variable='shopify_union_schemas',
        union_database_variable='shopify_union_databases'
    )
}}