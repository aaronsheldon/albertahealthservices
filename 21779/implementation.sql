
CREATE OR REPLACE PACKAGE BODY 21779 AS

  CURSOR getlatestupload(queryuser IN VARCHAR2) RETURN DATE IS
  SELECT
    MAX(a0.uploaddate) uploadate
  FROM
    randompseudonym a0
  WHERE
    a0.uploadrequest = 21779
    AND
    a0.uploaduser = queryuser
  GROUP BY
    a0.uploadrequest,
    a0.uploaduser;

  FUNCTION getvitalstatistics RETURN vitalstatistics PIPELINED;
  
  FUNCTION getpharmacydispenses RETURN pharmacydispenses PIPELINED;

END 21779
