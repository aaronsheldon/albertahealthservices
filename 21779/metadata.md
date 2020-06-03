# Delivered Data Meta Data

## Vital Statistics
* Source [`vitalstatistics.sql`](vitalstatistics.sql)
* Fields
  * `uliabphn` - `integer` Alberta provincial healthcare number, a unique lifetime identifier of the person.
  * `deceaseddata` - `date` Latest record version of the date of death.
* Unique key - one record per person
  * `uliabphn`
  
## Pharmacy Dispensing
* Source [`pharmacydispense.sql`](pharmacydispense.sql)
* Fields
  * `uliabphn` - `integer` Alberta provincial healthcare number, a unique lifetime identifier of the person.
  * `dispensedate` - `date` Day the therapy was dispensed to the person.
  * `siteidentifier` - `string` Pharmacy identifier.
* Unique key - one record per person-day-pharamcy-therapy-units, to accomodate the possibility a therapy may be dispensed in different units due to limited avaialabilities.
  * `uliabphn`
  * `dispensedate`
  * `siteidentifier`
