CREATE TABLE randompseudonym
(
  uliabphn INTEGER,
  ulipseudonym INTEGER,
  uploadrequest INTEGER,
  uploaddate DATE GENERATED (SYSDATE),
  uploaduser VARCHAR2(4000) GENERATED (USER)
);

COMMENT ON TABLE randompseudonym IS 'Historical record of all uploaded psuedonyms of Alberta provincial healthcare numbers.';
COMMENT ON COLUMN randompseudonym.uliabphn IS 'Reference Alberta provincial healthcare number.';
COMMENT ON COLUMN randompseudonym.ulipseudonym IS 'Pseudonym pad of the referenced Alberta provincial healthcare number.';
COMMENT ON COLUMN randompseudonym.uploadrequest IS 'Identifier of the request or project to which the pseudonyms apply.';
COMMENT ON COLUMN randompseudonym.uploaddate IS 'Timestamp of when the pseudonyms where uploaded.';
COMMENT ON COLUMN randompseudonym.uploaduser IS 'User that uploaded the pseudonyms.';
