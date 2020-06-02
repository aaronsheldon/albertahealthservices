WITH

  -- Deaths 2015 to 2017
  events00 AS
  (
    SELECT
      ab_hzrd_rts_anlys.hazardutilities.cleanphn(a0.stkh_num_1) uliabphn,
      ab_hzrd_rts_anlys.hazardutilities.cleansex(a0.sex) sex,
      CASE
        WHEN a0.birth_date < add_months(a0.dethdate, -12 * (1 + COALESCE(a0.age_yrs, a0.age))) THEN
          CAST(NULL AS DATE)
        ELSE
          a0.birth_date
      END birthdate,
      a0.dethdate deceaseddate
    FROM
      vital_stats_dsp.ahs_dth_2015_2017 a0
    WHERE
      ab_hzrd_rts_anlys.hazardutilities.cleanphn(a0.stkh_num_1) IS NOT NULL
      AND
      a0.dethdate BETWEEN COALESCE(a0.birth_date, a0.dethdate) AND TRUNC(SYSDATE, 'MM')
  ),
  
  -- Deaths 2010 to 2016
  events01 AS
  (
    SELECT
      ab_hzrd_rts_anlys.hazardutilities.cleanphn(a0.stkh_num_1) uliabphn,
      ab_hzrd_rts_anlys.hazardutilities.cleansex(a0.sex) sex,
      CASE
        WHEN a0.birth_date < add_months(a0.dethdate, -12 * (1 + COALESCE(a0.age_yrs, a0.age))) THEN
          CAST(NULL AS DATE)
        ELSE
          a0.birth_date
      END birthdate,
      a0.dethdate deceaseddate
    FROM
      vital_stats_dsp.ex_ah_dth_2010_2016 a0
    WHERE
      ab_hzrd_rts_anlys.hazardutilities.cleanphn(a0.stkh_num_1) IS NOT NULL
      AND
      a0.dethdate BETWEEN COALESCE(a0.birth_date, a0.dethdate) AND TRUNC(SYSDATE, 'MM')
  ),
  
  -- Deaths 2003 to 2010
  events02 AS
  (
    SELECT
      ab_hzrd_rts_anlys.hazardutilities.cleanphn(a0.stkh_num_1) uliabphn,
      ab_hzrd_rts_anlys.hazardutilities.cleansex(a0.sex) sex,
      CASE
        WHEN a0.birth_date < add_months(a0.dethdate, -12 * (1 + COALESCE(a0.age_yrs, a0.age))) THEN
          CAST(NULL AS DATE)
        ELSE
          a0.birth_date
      END birthdate,
      a0.dethdate deceaseddate
    FROM
      vital_stats_dsp.ahs_dth_2003_2010 a0
    WHERE
      ab_hzrd_rts_anlys.hazardutilities.cleanphn(a0.stkh_num_1) IS NOT NULL
      AND
      a0.dethdate BETWEEN COALESCE(a0.birth_date, a0.dethdate) AND TRUNC(SYSDATE, 'MM')
  ),

  -- Deaths early
  events03 AS
  (
    SELECT
      ab_hzrd_rts_anlys.hazardutilities.cleanphn(a0.primary_uli) uliabphn,
      ab_hzrd_rts_anlys.hazardutilities.cleansex(a0.sex) sex,
      CASE
        WHEN a0.birth_date < add_months(a0.dethdate, -12 * (1 + COALESCE(a0.age_yrs, a0.age))) THEN
          CAST(NULL AS DATE)
        ELSE
          a0.birth_date
      END birthdate,
      a0.dethdate deceaseddate
    FROM
      vital_stats_dsp.ex_vs_deaths_phn a0
    WHERE
      hazardutilities.cleanphn(a0.primary_uli) IS NOT NULL
      AND
      a0.dethdate BETWEEN COALESCE(a0.birth_date, a0.dethdate) AND TRUNC(SYSDATE, 'MM')
  )
