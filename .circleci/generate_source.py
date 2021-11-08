from google.cloud import bigquery

client = bigquery.Client.from_service_account_json("~/gcloud-service-key.json")

schema_name = "shopify_source_integration_tests"

tables = [
    {"seed": "shopify_customer_data", "source": "customer"},
    {"seed": "shopify_order_line_refund_data", "source": "order_line_refund"},
    {"seed": "shopify_order_line_data", "source": "order_line"},
    {"seed": "shopify_order_data", "source": "order"},
    {"seed": "shopify_product_data", "source": "product"},
    {"seed": "shopify_order_adjustment_data", "source": "order_adjustment"},
    {"seed": "shopify_product_variant_data", "source": "product_variant"},
    {"seed": "shopify_refund_data", "source": "refund"},
    {"seed": "shopify_transaction_data", "source": "transaction"},
]

for table_set in tables:
    delete_job = client.delete_table(
        f"{schema_name}.{table_set['source']}", not_found_ok=True
    )
    job = client.copy_table(
        f"{schema_name}.{table_set['seed']}", f"{schema_name}.{table_set['source']}"
    )
    job.result()  # Wait for the job to complete.
