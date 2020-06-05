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
  * A workflow for uploading the PHNs and one time pads, that first deletes all records for that user and project.
  * A workflow that retrieves data from the vital statistics function into a CSV file.
  * A workflow that retrieves data from the pharmacy dispensing function into a CSV file.
  * A workflow that only resets the pad table for the user and the project, in case of problems.

## Tasks
The following tasks have to be undertaken to fulfill the request:

1. Database engineering.
    - [ ] Create target table for uploading one time pads.
    - [ ] Engineer a query to resolve vital statistics to one record per person by picking the latest edit and only for a specified cohort and wrap in pipelined function.
    - [ ] Unit test vital statistics.
    - [ ] Engineer a query to resolve pharmacy dispensing to one record per event and only for a specified cohort and wrap.
    - [ ] Unit test pharmacy dispensing.
2. Deliver upload workflow
    - [ ] Engineer upload workflow.
    - [ ] Unit test the workflow to ensure basic functionality.
    - [ ] Grant provisional access to the database table and web based workflow to stakeholders.
    - [ ] Train stakeholders to use the workflow.
    - [ ] User acceptance testing of the workflow.
    - [ ] Publish to production.
3. Deliver reset workflow
    - [ ] Engineer reset workflow.
    - [ ] Unit test the workflow to ensure basic functionality.
    - [ ] Grant provisional access to the database table and web based workflow to stakeholders.
    - [ ] Train stakeholders to use the workflow.
    - [ ] User acceptance testing of the workflow.
    - [ ] Publish to production.
4. Deliver a workflow in Alteryx that reads the table containing the provincial health numbers of the selected cohort and returns the vital statistics information of the cohort in a separate file for download.
    - [ ] Engineer a workflow of `query->download`.
    - [ ] Unit test the workflow to ensure basic functionality.
    - [ ] Grant provisional access to the database package and web based workflow to stakeholders.
    - [ ] Train stakeholders to use the workflow.
    - [ ] User acceptance testing of the workflow.
    - [ ] Publish to production.
5. Deliver a workflow in Alteryx that the table containing the provincial health numbers of the selected cohort and returns the pharmacy dispensing information of the cohort in a separate file for download.
    - [ ] Engineer a workflow of `query->download`.
    - [ ] Unit test the workflow to ensure basic functionality.
    - [ ] Grant provisional access to the  database package and web based workflow to stakeholders.
    - [ ] Train stakeholders to use the workflow.
    - [ ] User acceptance testing of the workflow.
    - [ ] Publish to production.

## Estimates
The following estimates are rough approximations that will be subject to change:

|Task|Comments                                                    |Amount|Units|
|----|------------------------------------------------------------|------|-----|
|1.1 |Challenge to find latest edits, small data, fast test cycle.|    16|Hours|
|1.2 |Challenge to authenticate user and access files.            |    16|Hours|
|1.3 |Challenge to authenticate user and access files.            |     8|Hours|
|1.4 |Straight forward.                                           |     1|Hours|
|1.5 |Depends on user experience and connectivity.                |     2|Hours|
|1.6 |Depends on user experience and connectivity.                |     8|Hours|
|1.7 |Straight forward.                                           |     1|Hours|
|2.1 |Challenge to query to large data, slow test cycle.          |    32|Hours|
|2.2 |Challenge to authenticate user and access files.            |    32|Hours|
|2.3 |Challenge to authenticate user and access files.            |    16|Hours|
|2.4 |Straight forward.                                           |     1|Hours|
|2.5 |Depends on user experience and connectivity.                |     2|Hours|
|2.6 |Depends on user experience and connectivity.                |    16|Hours|
|2.7 |Straight forward.                                           |     1|Hours|
|    |Total                                                       |   152|Hours|
