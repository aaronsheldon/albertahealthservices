WITH

  -- All available versions of death data
  deathversions AS
  (
    -- Deaths 2015 to 2017
    SELECT
      2017 recordyear,
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
    UNION ALL
  
    -- Deaths 2010 to 2016
    SELECT
      2016 recordyear,
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
    UNION ALL
  
    -- Deaths 2003 to 2010
    SELECT
      2010 recordyear,
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
    UNION ALL
  
    -- Deaths early
    SELECT
      2002 recordyear,
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
  ),

  -- Determine the latest release of each death record
  latestversion AS
  (
    SELECT
      MAX(a0.recordyear) recordyear,
      a0.uliabphn
    FROM
      deathversions a0
    GROUP BY
      a0.uliabphn
  )

-- Return the latest record
SELECT
  a0.recordyear,
  a0.uliabphn,
  a0.sex,
  a0.birthdate,
  a0.deceaseddate
FROM
  deathversions a0
  INNER JOIN
  latestversion a1
  ON
    a0.uliabphn = a1.uliabphn
    AND
    a0.recordyear = a1.recordyear
