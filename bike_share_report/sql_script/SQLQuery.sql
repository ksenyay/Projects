
WITH bike_share AS (
SELECT * FROM bike_share_yr_0
UNION 
SELECT * FROM bike_share_yr_1)

SELECT 
	dteday,
	season,
	bike_share.yr,
	hr,
	weekday,
	rider_type,
	riders,
	price,
	COGS,
	riders * price AS revenue,
	riders * price - COGS AS profit
FROM bike_share
LEFT JOIN cost_table ON bike_share.yr = cost_table.yr

