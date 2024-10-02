-- Creating a join table --

SELECT * FROM absenteeism_at_work as a
LEFT JOIN compensation AS c ON c.id = a.id
LEFT JOIN reasons AS r ON a.reason_for_absence = r.number;

-- Finding the healthiest employees --

SELECT * FROM absenteeism_at_work
WHERE body_mass_index BETWEEN 18.5 AND 24.9 
	AND Social_drinker = 0 
	AND Social_smoker = 0 
	AND CAST(Absenteeism_time_in_hours AS tinyint) < (SELECT AVG(CAST(Absenteeism_time_in_hours AS tinyint)) FROM absenteeism_at_work);

-- Compensation for non-smokers --

-- Budget: USD 983,221
-- Working hours per year: 1,426,880 (5*8*52*686)
-- Increase per hour: USD 0.68 per hour (983,221/1,426,880)
-- Increase per year: USD 1,414.40 (5*8*52*0.68)

SELECT COUNT(*) AS nonsmokers FROM absenteeism_at_work
WHERE Social_smoker = 0;

-- Optimizing the query --

SELECT a.id,
	   r.reason,
	   body_mass_index,
	   CASE WHEN body_mass_index < 18.5 THEN 'underweight' 
		WHEN body_mass_index BETWEEN 18.5 AND 25 THEN 'healthy'
		WHEN body_mass_index BETWEEN 25 AND 30 THEN 'overweight'
		WHEN body_mass_index > 30 THEN 'obese'
		ELSE 'Unknown' END AS bmi_status,
	   CASE WHEN seasons=1 THEN 'winter'	
		WHEN seasons=2 THEN 'spring' 
		WHEN seasons=3 THEN 'summer' 
		WHEN seasons=4 THEN 'fall' 
		ELSE 'Unknown' END AS season_of_absence,
           CASE WHEN age <= 27 THEN 'Gen Z'
                WHEN age BETWEEN 28 AND 43 THEN 'Millenials'
                WHEN age BETWEEN 44 AND 59 THEN 'Gen X'
                WHEN age >= 60 THEN 'Boomers' END AS age_group,
       seasons,
	   month_of_absence,
	   day_of_the_week,
	   transportation_expense,
	   education,
	   son,
	   social_drinker,
	   social_smoker,
	   pet,
	   disciplinary_failure,
	   age,
           work_load_Average_day,
	   absenteeism_time_in_hours,
           comp_hr,
           Distance_from_Residence_to_Work

FROM absenteeism_at_work as a
LEFT JOIN compensation AS c ON c.id = a.id
LEFT JOIN reasons AS r ON a.reason_for_absence = r.number
WHERE absenteeism_time_in_hours > -7 AND absenteeism_time_in_hours < 17; -- Defining outliers (data from Python)