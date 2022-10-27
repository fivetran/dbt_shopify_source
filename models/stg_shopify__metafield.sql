with source as (

    select * from {{ ref('stg_shopify__metafield_tmp') }}

),

renamed as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__metafield_tmp')),
                staging_columns=get_metafield_columns()
            )
        }}

      --The below script allows for pass through columns.
      {% if var('metafield_pass_through_columns') %}
      ,
      {{ var('metafield_pass_through_columns') | join (", ")}}

      {% endif %}

        {{ fivetran_utils.source_relation(
            union_schema_variable='shopify_union_schemas', 
            union_database_variable='shopify_union_databases') 
        }}

    from source

)

select * from renamed

