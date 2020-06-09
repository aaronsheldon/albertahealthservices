CREATE OR REPLACE PACKAGE 21779 AUTHID DEFINER AS

  TYPE vitalstatistic IS RECORD
  (
    uliabphn INTEGER
  );
  
  TYPE vitalstatistics IS TABLE OF vitalstatistic;
  
  TYPE pharmacydispense IS RECORD
  (
    uliabphn INTEGER
  );
  
  TYPE pharmacydispenses IS TABLE OF pharmacydispense;

  CURSOR getvitalstatistic RETURN vitalstatistic;
  
  CURSOR getpharmacydispense RETURN pharmacydispense;
  
  CURSOR getlatestupload RETURN DATE;
  
  vitalstatisticsquery CONSTANT VARCHAR2(4000) := '';
  
  pharmacydispensesquery CONSTANT VARCHAR2(4000) := '';
  
  FUNCTION getvitalstatistics RETURN vitalstatistics PIPELINED;
  
  FUNCTION getpharmacydispenses RETURN pharmacydispenses PIPELINED;

END 21779
