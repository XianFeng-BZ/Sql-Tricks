SELECT
     DATE(TIMESTAMPADD( 'DAY',((JULIAN_DAY(DATE(TIMESTAMPADD('YEAR',-CAST(PERIOD AS INT),DATE))
    +(JULIAN_DAY(DATE) - (JULIAN_DAY(DATE(TIMESTAMPADD('YEAR',-CAST(PERIOD AS INT),DATE)))))%7)) )- 2415021, '01/01/1900')) AS 'DATE',
     D.DATE AS 'CUR_DATE',
    PERIOD,
    MIN(CASE WHEN DATE(D.DATE)=DATE(NOW()) THEN
    DATE(TIMESTAMPADD( 'DAY',((JULIAN_DAY(DATE(TIMESTAMPADD('YEAR',-CAST(PERIOD AS INT),DATE))
    +(JULIAN_DAY(DATE) - (JULIAN_DAY(DATE(TIMESTAMPADD('YEAR',-CAST(PERIOD AS INT),DATE)))))%7)) )- 2415021, '01/01/1900')) END) OVER (PARTITION BY PERIOD)  AS 'TODAY'

    FROM
    (SELECT DISTINCT DATE FROM REPORTING.DW_D_DATE
    WHERE DATE(DATE_TRUNC('YEAR',DATE))= DATE(DATE_TRUNC('YEAR',TIMESTAMPADD('DAY',-1,NOW())))
    GROUP BY 1) D
    CROSS JOIN
   (SELECT 0 AS PERIOD UNION SELECT 1 AS PERIOD UNION SELECT 2 AS PERIOD UNION SELECT 3 AS PERIOD UNION SELECT 4 AS PERIOD
    UNION SELECT 5 AS PERIOD UNION SELECT 6 AS PERIOD UNION SELECT 7 AS PERIOD UNION SELECT 8 AS PERIOD
    UNION SELECT 9 AS PERIOD UNION SELECT 10 AS PERIOD UNION SELECT 11 AS PERIOD UNION SELECT 12 AS PERIOD
    UNION SELECT 13 AS PERIOD ) PD
    ORDER BY 1 DESC

-- You convert the previous years to same day this year 