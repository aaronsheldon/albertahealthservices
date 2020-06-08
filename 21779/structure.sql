CREATE TABLE randompseudonym
(
  uliabphn INTEGER,
  ulipseudonym INTEGER,
  uploadrequest INTEGER,
  uploaddate DATE GENERATED (SYSDATE),
  uploaduser VARCHAR2(4000) GENERATED (USER)
);
