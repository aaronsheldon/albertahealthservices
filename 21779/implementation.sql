CREATE OR REPLACE PACKAGE BODY 21779 AS

  FUNCTION getvitalstatistics RETURN vitalstatistics PIPELINED AS
    CURSOR localcursor RETURN vitalstatistic;
    localrecord vitalstatistic;
    localquery CONSTANT VARCHAR2(4000) := '';
  BEGIN
    OPEN localcursor FOR localquery;
    LOOP
      FETCH localcursor INTO localrecord
      EXIT WHEN localcursor%NOTFOUND;
      PIPE ROW (localrecord);
    END LOOP;
  END getvitalstatistics;

  FUNCTION getpharmacydispenses RETURN pharmacydispenses PIPELINED AS
    CURSOR localcursor RETURN pharmacydispense;
    localrecord pharmacydispense;
    localquery CONSTANT VARCHAR2(4000) := '';
  BEGIN
    OPEN localcursor FOR localquery;
    LOOP
      FETCH localcursor INTO localrecord
      EXIT WHEN localcursor%NOTFOUND;
      PIPE ROW (localrecord);
    END LOOP;
  END getpharmacydispenses;

END 21779
