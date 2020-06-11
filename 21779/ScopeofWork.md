# Request 21779

## Overview
The Alberta's Tomorrow Project is requesting vital statistics and pharmacy dispensing information be retrieved for a selected cohort of subjects enrolled in the project.

## Inclusion/Exclusion Criteria
The request will be restricted to the following information:

* Include only information about subjects in the submitted cohort.
* Include only vital statistics up to March 31, 2018.
* Include only pharmacy dispensing events occuring between April 1, 2008 and March 31, 2018.
* Include only pharmacy dispensing events with both a valid DIN registration and ATC code.

## Requirments
The following information is required from the stakeholders:

* A select cohort of subjects identified by their provincial healthcare numbers.
* A one time pad from provincial healthcare numbers to pseudonymized identifiers.

## Deliverables
The following information is to be delivered to the stakeholders:

* One record per subject.
    * Pseudonymized identifier.
    * When known the date of death, null otherwise.
    * Meta-data of the delivered vital statistics data.
* One record per dispensing event.
    * Pseudonymized identifier.
    * Dispensing date
    * ATC code.
    * DIN registration.
    * Dispensing units.
    * Dispensing quantity.
    * Days supply.
    * Meta-data of the delivered pharmacy dispensing data.

## Design
The overall goal of the workflow designs are to balance security with utility. On the one hand we want users to to be able to seemless retrieve the data they need. One the other hand we need users to access file shares using integrated authentications and to access databases using manual authentication. For file share access the Alteryx server defers to integrated authentication by default. For database access the problem is complicated by the current configuration of the database which restricts the ability for native SQL cursors to cross schema boundaries. This means we will need to use `OPEN FOR` cursors calling dynamic SQL, and embed the cursor in a pipelined function running under `DEFINER`'s credentials. Access to both the Alteryx workflow and `GRANT`s to the pipelined function will be restricted to only the requesters. The solution will contain the following elements:

* An empty table to store the PHNs and one time pads for each user and project, including a time of last upload.
* A package for the project with `DEFINER` credentials containing two pipelined dynamic SQL functions.
  * A function that takes the user identifier and returns the vital statistics for the subjects uploaded to the pad table by the user.
  * A function that takes the user identifier and returns the pharmacy dispensing for the subjects uploaded to the pad table by the user.
* An Alteryx collection for the project containing four workflows.
  * A workflow for uploading the PHNs and one time pads that only inserts records, so that a full history of uploaded PHNs is recorded.
  * A workflow that retrieves data from the vital statistics function into a CSV file.
  * A workflow that retrieves data from the pharmacy dispensing function into a CSV file.

## Tasks
The following tasks have to be undertaken to fulfill the request:

1. Database engineering.
    - [x] Create target table for uploading one time pads that automatically timestamps and records user.
    - [ ] Engineer a query to resolve vital statistics to one record per person by picking the latest edit and only for a specified cohort and wrap in pipelined function.
    - [ ] Unit test vital statistics.
    - [x] Engineer a query to resolve pharmacy dispensing to one record per event and only for a specified cohort and wrap.
    - [ ] Unit test pharmacy dispensing.
2. Deliver upload-insert workflow
    - [x] Engineer upload workflow.
    - [x] Unit test the workflow to ensure basic functionality.
    - [ ] Grant provisional access to the database table and web based workflow to stakeholders.
    - [ ] Train stakeholders to use the workflow.
    - [ ] User acceptance testing of the workflow.
    - [x] Publish to production collection.
3. Deliver a workflow in Alteryx that reads the table containing the provincial health numbers of the selected cohort and returns the vital statistics information of the cohort in a separate file for download.
    - [ ] Engineer a workflow of `query->download`.
    - [ ] Unit test the workflow to ensure basic functionality.
    - [ ] Grant provisional access to the database package and web based workflow to stakeholders.
    - [ ] Train stakeholders to use the workflow.
    - [ ] User acceptance testing of the workflow.
    - [ ] Publish to production collection.
4. Deliver a workflow in Alteryx that the table containing the provincial health numbers of the selected cohort and returns the pharmacy dispensing information of the cohort in a separate file for download.
    - [ ] Engineer a workflow of `query->download`.
    - [ ] Unit test the workflow to ensure basic functionality.
    - [ ] Grant provisional access to the  database package and web based workflow to stakeholders.
    - [ ] Train stakeholders to use the workflow.
    - [ ] User acceptance testing of the workflow.
    - [ ] Publish to production collection.

## Estimates
The following estimates are rough approximations that will be subject to change:

|Task|Comments                                          |Personal|Compute|External|Units|
|----|--------------------------------------------------|--------|-------|--------|-----|
|1.1 |Challenge to auto-populate with audit information.|       4|      0|       0|Hours|
|1.2 |Draft is partially complete.                      |       4|      1|       0|Hours|
|1.3 |Need to have a few test identifiers.              |       4|      1|       0|Hours|
|1.4 |Draft is partially complete.                      |       4|      8|       0|Hours|
|1.5 |Challenge to query to large data, slow test cycle.|       8|     24|       0|Hours|
|2.1 |Copy over existing authentication workflow.       |       1|      0|       0|Hours|
|2.2 |Need to have a few test identifiers.              |       2|      1|       0|Hours|
|2.3 |Straight forward.                                 |       0|      0|       0|Hours|
|2.4 |Largest part is preparing curriculum.             |       0|      0|       1|Hours|
|2.5 |Depends on user experience and connectivity.      |       0|      1|       1|Hours|
|2.6 |Straight forward.                                 |       0|      0|       0|Hours|
|3.1 |Copy over existing authentication workflow.       |       1|      0|       0|Hours|
|3.2 |Fast test cycle, small query target.              |       4|      1|       0|Hours|
|3.3 |Straight forward.                                 |       0|      0|       0|Hours|
|3.4 |Largest part is preparing curriculum.             |       0|      0|       1|Hours|
|3.5 |Depends on user experience and connectivity.      |       0|      1|       1|Hours|
|3.6 |Straight forward.                                 |       0|      0|       0|Hours|
|4.1 |Copy over existing authentication workflow.       |       1|      0|       0|Hours|
|4.2 |Slow test cycle, large query target.              |       8|     24|       0|Hours|
|4.3 |Straight forward.                                 |       0|      0|       0|Hours|
|4.4 |Largest part is preparing curriculum.             |       0|      0|       1|Hours|
|4.5 |Depends on user experience and connectivity.      |       0|     24|       1|Hours|
|4.6 |Straight forward.                                 |       0|      0|       0|Hours|
|    |Total                                             |      37|     86|       6|Hours|
