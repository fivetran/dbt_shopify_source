# (ARCHIVED) Shopify Source dbt Package

<p align="left">
    <a alt="License"
        href="https://github.com/fivetran/dbt_shopify_source/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" /></a>
    <a alt="dbt-core">
        <img src="https://img.shields.io/badge/dbt_Core™_version->=1.3.0_,<2.0.0-orange.svg" /></a>
    <a alt="Maintained?">
        <img src="https://img.shields.io/badge/Maintained%3F-no-green.svg" /></a>
    <a alt="PRs">
        <img src="https://img.shields.io/badge/Contributions-closed-blueviolet" /></a>
</p>

> This package was archived on 2025-MM-DD and is no longer maintained.  
> All models from this package are now maintained in [`dbt_shopify`](https://github.com/fivetran/dbt_shopify).

## Why the change?
- **Simpler installation** - only one package to install 
- **Fewer version conflicts** - staging and transform models are always in sync  
- **Easier troubleshooting** - everything is in one place, so issues are clearer to debug  
- **Cleaner documentation** - one README, one changelog, one set of docs to follow  
- **Ongoing improvements** - all updates and new features will be made in the transform package

## What should I do?
- Remove this source package from your `packages.yml`
- Install the transform package by following the instructions in the 
  [dbt_shopify README](https://github.com/fivetran/dbt_shopify/blob/main/README.md#step-2-install-the-package-skip-if-also-using-the-shopify_holistic_reporting-package)
- Run `dbt clean && dbt deps` to refresh your dependencies

## Migration notes
- Model names, schemas, and behavior are the same as before (moved 1:1 to the transform repo).  
- If you previously referenced models from this source package, switch references to the transform package namespace.  
- If you had custom overrides (seeds, macros, or config) that pointed to this package, update the package name from `shopify_source` to `shopify`.  

## Versioning & changelog
- This source package is **frozen** as of `v0.20.0` on <2025YYY-MM-DD>.  

## Support
- This package is archived and no longer accepts new issues or pull requests.  All open issues from this repository have been copied over to the [`dbt_shopify`](https://github.com/fivetran/dbt_shopify) repository, where they will continue to be tracked.  
- For any new questions, bug reports, or feature requests, open an issue in [`dbt_shopify`](https://github.com/fivetran/dbt_shopify).  
