# Decision Log

In creating this package, which is meant for a wide range of use cases, we had to take opinionated stances on a few different questions we came across during development. We've consolidated significant choices we made here, and will continue to update as the package evolves. 

## Creating Empty Tables for Refunds, Order Line Refunds, and Order Adjustments 

Source tables related to `refunds`, `order_line_refunds`, and `order_adjustments` are created in the Shopify schema dyanmically. For example, if your shop has not incurred any refunds, you will not have a `refund` table yet until you do refund an order. 

Thus, the source package will create empty (1 row of all `NULL` fields) staging models if these source tables do not exist in your Shopify schema yet, and the transform package will work seamlessly with these empty models. Once `refund`, `order_line_refund`, or `order_adjustment` exists in your schema, the source and transform packages will automatically reference the new populated table(s). ([example](https://github.com/fivetran/dbt_shopify_source/blob/main/models/tmp/stg_shopify__refund_tmp.sql)). 

> In previous versions of the package, you had to manually enable or disable transforms of `refund`, `order_line_refund`, or `order_adjustment` through variables. Because this required you to monitor your Shopify account/schema and update the variable(s) accordingly, we decided to pursue a more automated solution.

## Keeping Deleted Entities 

todo - not filtering out _fivetran_deleted in staging models. when joining these tables together in the transform package, bring in _fivetran_deleted as is_<foreign key table>_deleted