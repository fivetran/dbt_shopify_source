# dbt_shopify_source v0.6.0
🎉 dbt v1.0.0 Compatibility 🎉
## 🚨 Breaking Changes 🚨
- Adjusts the `require-dbt-version` to now be within the range [">=1.0.0", "<2.0.0"]. Additionally, the package has been updated for dbt v1.0.0 compatibility. If you are using a dbt version <1.0.0, you will need to upgrade in order to leverage the latest version of the package.
  - For help upgrading your package, I recommend reviewing this GitHub repo's Release Notes on what changes have been implemented since your last upgrade.
  - For help upgrading your dbt project to dbt v1.0.0, I recommend reviewing dbt-labs [upgrading to 1.0.0 docs](https://docs.getdbt.com/docs/guides/migration-guide/upgrading-to-1-0-0) for more details on what changes must be made.
- Upgrades the package dependency to refer to the latest `dbt_fivetran_utils`. The latest `dbt_fivetran_utils` package also has a dependency on `dbt_utils` [">=0.8.0", "<0.9.0"].
  - Please note, if you are installing a version of `dbt_utils` in your `packages.yml` that is not in the range above then you will encounter a package dependency error.
## For dbt Spark Users
- This release has a dependency on `spark-utils` [">=0.2.0", "<0.3.0"] which does not contain an official full dbt v1 compatibility release. As such, this release does not fully support dbt v1.0.0 for dbt spark users. 
 - Once the dbt v1.0.0 release of `spark-utils` is live, a `0.0.x` patch release will be applied on this package for full spark dbt v1 compatiblity.

# dbt_shopify_source v0.5.2
## Under the Hood
- Rearranged the ordering of the columns within the `get_order_columns` macro. This ensure the output of the models within the downstream [Shopify Holistic Reporting](https://github.com/fivetran/dbt_shopify_holistic_reporting) package are easier to understand and interpret. ([#29](https://github.com/fivetran/dbt_shopify_source/pull/29))

# dbt_shopify_source v0.1.0 -> v0.5.1
Refer to the relevant release notes on the Github repository for specific details for the previous releases. Thank you!
