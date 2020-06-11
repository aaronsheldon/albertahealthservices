CREATE OR REPLACE PACKAGE 21779 AUTHID DEFINER AS

  TYPE vitalstatistic IS RECORD
  (
    uliabphn INTEGER,
    ulipseudonym INTEGER,
    deceaseddate DATE
  );

  TYPE pharmacydispense IS RECORD
  (
    uliabphn INTEGER,
    ulipseudonym INTEGER,
    dispensedate DATE,
    registereddin INTEGER,
    atcclassification VARCHAR2(8),
    suppliedquantity INTEGER,
    unitscode VARCHAR2(64),
    unitsdescription VARCHAR2(2048),
    siteidentifier VARCHAR2(4),
    supplieddays INTEGER,
    standardtherapeutic INTEGER,
    controlledtherapeutic INTEGER
  );

  TYPE vitalstatistics IS TABLE OF vitalstatistic;

  TYPE pharmacydispenses IS TABLE OF pharmacydispense;

  FUNCTION getvitalstatistics RETURN vitalstatistics PIPELINED;
  
  FUNCTION getpharmacydispenses RETURN pharmacydispenses PIPELINED;

END 21779
