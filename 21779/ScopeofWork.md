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

1. Deliever a workflow in Alteryx that takes a file containing the provincial health numbers of the selected cohort and returns the vital statistics information of the cohort in a separate file for download.
   - [ ] Engineer a query to resolve vital statistics to one record per person and only for a specified cohort.
   - [ ] Engineer a workflow of `upload->query->download`.
   - [ ] Unit test the workflow to ensure basic functionality.
   - [ ] Grant provisional access to the web based workflow to stakeholders.
   - [ ] Train stakeholders to use the workflow.
   - [ ] User acceptance testing of the workflow.
   - [ ] Set to production.
2. Deliever a workflow in Alteryx that takes a file containing the provincial health numbers of the selected cohort and returns the pharmacy dispensing information of the cohort in a separate file for download.
    - [ ] Engineer a query to resolve pharmacy dispensing to one record per event and only for a specified cohort.
    - [ ] Engineer a workflow of `upload->query->download`.
    - [ ] Unit test the workflow to ensure basic functionality.
    - [ ] Grant provisional access to the web based workflow to stakeholders.
    - [ ] Train stakeholders to use the workflow.
    - [ ] User acceptance testing of the workflow.
    - [ ] Set to production.
