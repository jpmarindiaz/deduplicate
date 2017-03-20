 # Deduplicate

While working with real life data I have faced quite often the issue of determining if there are duplicated in the data. It is also quite common to question if the new samples are actually new or updates of the records in a dataset. 

To tackle this issues I have created __deduplicate__ which is nothing else than wrapper functions around [dplyr](https://github.com/hadley/dplyr)'s joins and [fuzzyjoin](https://github.com/dgrtwo/fuzzyjoin). 

So far I have the following functions:

- __get_approx_dup_ids__: Get row numbers of duplicate records.
- __get_approx_dups__: Get all duplicates for manual inspection.
- __new_or_dup__: Get if a set of new records are new or duplicates.

By default 

All these functions work with using the naïve approach of creating a unique id out of the multiple columns of the dataset, e.g. FIRSTNAME_LASTNAME_CITY

Planned features include:

- Use of a per-column distance metric rather than a distance metric on built ids.
- Automatic clustering of records
- Automatic merge of records
- Supervised merge with a Shiny App or RStudio add on







