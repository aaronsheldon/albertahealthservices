WITH
  latestupload AS
  (
    SELECT
      MAX(uploaddate) uploaddate,
      a0.uploaduser,
      a0.uploadrequest
    FROM
      randompseudonym a0
    WHERE
      a0.uploaduser = USER
      AND
      a0.uploadrequest = 21779
    GROUP BY
      a0.uploaduser,
      a0.uploadrequest
  ),
  latestpseudonym AS
  (
    SELECT
      a0.uliabphn,
      MAX(a0.ulipseudonym) ulipseudonym
    FROM
      randompseudonym a0
      INNER JOIN
      latestupload a1
      ON
        a0.uploaduser = a1.uploaduser
        AND
        a0.uploadrequest = a1.uploadrequest
        AND
        a0.uploaddate = a1.uploaddate
    GROUP BY
      a0.uliabphn
  )
SELECT /*+ NO_INDEX (a1) */
  a0.uliabphn,
  MAX(a0.ulipseudonym) ulipseudonym,
  a1.dspn_date dispensedate,
  a1.drug_din registereddin,
  a1.supp_drug_atc_code atcclassification,
  SUM(a1.dspn_amt_qty) suppliedquantity,
  a1.dspn_amt_unt_msr_cd unitscode,
  MAX(a2.long_desc) unitsdescription,
  a1.fac_key_di360 siteidentifier,
  SUM(a1.dspn_day_supply_qty) supplieddays,
  MIN(CASE a1.dspn_triplicate_boo WHEN 'T' THEN 0 ELSE 1 END) standardtherapeutic,
  MAX(CASE a1.dspn_triplicate_boo WHEN 'T' THEN 1 ELSE 0 END) controlledtherapeutic
FROM
  latestpseudonym a0
  INNER JOIN
  ahsdrrconform.cf_pin_dspn a1
  ON
    a0.uliabphn = ab_hzrd_rts_anlys.hazardutilities.cleanphn(a1.rcpt_uli)
  INNER JOIN
  ahsdrrconform.cf_pin_dspn_ref_unt_msr_cd a2
  ON
    a1.dspn_amt_unt_msr_cd = a2.dspn_unt_msr_cd
    AND
    a1.supp_drug_atc_code IS NOT NULL
    AND
    ab_hzrd_rts_anlys.hazardutilities.cleanprid(a1.prscb_prid) IS NOT NULL
    AND
    a1.dspn_prod_id = a1.drug_din
    AND
    a1.drug_triplicate_boo = a1.dspn_triplicate_boo
    AND
    a1.nhp_boo = 'F'
    AND
    a1.dspn_prod_id_tp_code = 'DIN'
    AND
    a1.fac_key_di360 IS NOT NULL
    AND
    a1.dspn_act_tp_code <> 'Z'
    AND
    a1.dspn_amt_qty > 0
    AND
    a1.dspn_day_supply_qty > 0
    AND
    a1.dspn_date BETWEEN greatest(TO_DATE('20080401', 'YYYYMMDD'), COALESCE(a1.rcpt_dob, a1.dspn_date)) AND least(TO_DATE('20180331', 'YYYYMMDD'), TRUNC(SYSDATE, 'MM'))
GROUP BY
  a0.uliabphn,
  a1.dspn_date,
  a1.drug_din,
  a1.supp_drug_atc_code,
  a1.dspn_amt_unt_msr_cd,
  a1.fac_key_di360;
