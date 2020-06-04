# Work Flow Meta-Data

## Vital Statistics
* Source [`vitalstatistics.sql`](vitalstatistics.sql)
* Fields
  * `uliabphn` - `integer` Alberta provincial healthcare number, a unique lifetime identifier of the person.
  * `deceaseddate` - `date` Latest recorded version of the date of death.
  * `recordyear` - `integer` Latest version year.
  * `sex` - `string` Binary biological sex as recorded in vital statistics.
  * `birthdate` - `date` Birthday as recorded in vital statistics.
* Unique key - one record per person
  * `uliabphn`
  
## Pharmacy Dispensing
* Source [`pharmacydispense.sql`](pharmacydispense.sql)
* Fields
  * `uliabphn` - `integer` Alberta provincial healthcare number, a unique lifetime identifier of the person.
  * `dispensedate` - `date` Day the therapy was dispensed to the person.
  * `siteidentifier` - `string` Pharmacy identifier.
  * `registereddin` - `integer` Health Canada registered drug information number of the therapy.
  * `atcclassification` - `string` ATC classification code of the therapy.
  * `suppliedquantity` - `integer` Simple sum of the amount dispensed over records within the unique key.
  * `unitscode` - `string` Short code of the measurement units of the amount dispensed.
  * `unitsdescription` - `string` Long description of the measurement units of the amount dispensed.
  * `supplieddays` - `integer` Simple sum of the days supply dispensed over the record within the unique key.
  * `recordcount` - `integer` Number of records covers by the unique key.
  * `standardtherapeutic` - `integer` Controlled substance schedule of the therapy: 0 triple pad; 1 otherwise.
  * `controlledtherapeutic` - `integer` Controlled substance schedule of the therapy: 1 triple pad; 0 otherwise.  
* Unique key - one record per person-day-pharamcy-therapy-units, to accomodate the possibility a therapy may be dispensed in different units due to limited avaialabilities. Both `DIN` and `ATC` are included as `DIN` registers the product and `ATC` incorporates the therapuetic use of the product.
  * `uliabphn`
  * `dispensedate`
  * `siteidentifier`
  * `registereddin`
  * `atcclassification`
  * `unitscode`
