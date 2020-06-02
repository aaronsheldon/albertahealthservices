SELECT
  ab_hzrd_rts_anlys.hazardutilities.cleanphn(a0.rcpt_uli) uliabphn,
  a0.dspn_date dispensedate,
  a0.fac_key_di360 siteidentifier,
  a0.dspn_day_supply_qty dailydoses,
  CASE a0.dspn_triplicate_boo WHEN 'T' THEN 0 ELSE 1 END standardtherapeutic,
  CASE a0.dspn_triplicate_boo WHEN 'T' THEN 1 ELSE 0 END controlledtherapeutic
FROM
  ahsdrrconform.cf_pin_dspn a0
WHERE
  ab_hzrd_rts_anlys.hazardutilities.cleanphn(a0.rcpt_uli) IS NOT NULL
  AND
  a0.supp_drug_atc_code IS NOT NULL
  AND
  ab_hzrd_rts_anlys.hazardutilities.cleanprid(a0.prscb_prid) IS NOT NULL
  AND
  a0.dspn_prod_id = a0.drug_din
  AND
  a0.drug_triplicate_boo = a0.dspn_triplicate_boo
  AND
  a0.nhp_boo = 'F'
  AND
  a0.dspn_prod_id_tp_code = 'DIN'
  AND
  a0.fac_key_di360 IS NOT NULL
  AND
  a0.dspn_act_tp_code <> 'Z'
  AND
  a0.dspn_amt_qty > 0
  AND
  a0.dspn_date BETWEEN COALESCE(a0.rcpt_dob, a0.dspn_date) AND TRUNC(SYSDATE, 'MM')
