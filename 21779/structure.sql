CREATE TABLE randompseudonym
(
  uliabphn INTEGER,
  ulipseudonym INTEGER,
  uploaddate DATE GENERATED (SYSDATE),
  uploaduser VARCHAR2(4000) GENERATED (USER),
  uploadrequest INTEGER,
  uploadcount INTEGER
);
