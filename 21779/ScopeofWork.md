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
* One record per dispensing event.
    * Pseudonymized identifier.
    * Dispensing date
    * ATC code.
    * DIN registration.
    * Dispensing units.
    * Dispensing quantity.
    * Days supply.

## Tasks
The following tasks have to be undertaking to fulfill the request:

1. Deliver a workflow in Alteryx that takes a file containing the provincial health numbers of the selected cohort and returns the vital statistics information of the cohort in a separate file for download.
   - [ ] Engineer a query to resolve vital statistics to one record per person by picking the latest edit and only for a specified cohort.
   - [ ] Engineer a workflow of `upload->query->download`.
   - [ ] Unit test the workflow to ensure basic functionality.
   - [ ] Grant provisional access to the web based workflow to stakeholders.
   - [ ] Train stakeholders to use the workflow.
   - [ ] User acceptance testing of the workflow.
   - [ ] Publish to production.
2. Deliver a workflow in Alteryx that takes a file containing the provincial health numbers of the selected cohort and returns the pharmacy dispensing information of the cohort in a separate file for download.
    - [ ] Engineer a query to resolve pharmacy dispensing to one record per event and only for a specified cohort.
    - [ ] Engineer a workflow of `upload->query->download`.
    - [ ] Unit test the workflow to ensure basic functionality.
    - [ ] Grant provisional access to the web based workflow to stakeholders.
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
