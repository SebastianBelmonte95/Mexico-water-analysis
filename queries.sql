-- Importing the tablefunc module (PostgreSQL 9.1+)
CREATE EXTENSION IF NOT EXISTS tablefunc;
----------------- 
-- Creating table with id, dam name, location, capcity (name and namo), current storage, fill percentage and log date.
---------------
CREATE TABLE dam_levels(
	dam_id VARCHAR(3) NOT NULL,
	dam_name VARCHAR(100) NOT NULL,
	state VARCHAR(100) NOT NULL,
	name_storage NUMERIC NOT NULL,
	namo_storage NUMERIC NOT NULL,
	current_storage NUMERIC NOT NULL,
	fill_percent  NUMERIC NOT NULL,
	log_date DATE
)

--------- Importing data from a single CSV file into the DB ---------
 COPY dam_levels(dam_id,dam_name,state,name_storage,namo_storage,current_storage,fill_percent,log_date) 
 FROM 'D:\Google Drive\Professional Projects\Portfolio\Data Analysis\Water in Mexico\01 - Jan 2021\Jan01.csv' 
 DELIMITER ',' 
 CSV HEADER;

------------------------ General Query ------------------------------
SELECT * FROM dam_levels
ORDER BY log_date

-------- Total storage and Current Storage by state and date --------
SELECT log_date,state,sum(namo_storage) as state_namo,sum(current_storage) as state_current FROM dam_levels
GROUP BY state,log_date
Order by state,log_date

--Water level comparison per dam, Jan 1st vs May 27th --
SELECT * FROM crosstab(
	'SELECT dam_name,log_date,current_storage
	FROM dam_levels
	WHERE log_date = ''2021-01-01'' OR log_date = ''2021-05-27''
	ORDER BY dam_id'
)
AS levels("Dam_name" VARCHAR(100), "Start" numeric, "End" numeric)

--Water level comparison per state, Jan 1st vs May 27 --
SELECT * FROM crosstab(
	'SELECT state,log_date,sum(current_storage)
	FROM dam_levels
	WHERE log_date = ''2021-01-01'' OR log_date = ''2021-05-27''
	GROUP BY state,log_date
	ORDER BY state'
)
AS levels("State" VARCHAR(100), "Start" numeric, "End" numeric)

-- National water level comparison, Jan 1st vs May 27 --
SELECT * FROM crosstab(
	'SELECT ''Mexico'',log_date,sum(current_storage)
	FROM dam_levels
	WHERE log_date = ''2021-01-01'' OR log_date = ''2021-05-27''
	GROUP BY log_date
	ORDER BY log_date'
)
AS levels("Country" TEXT, "Start" numeric, "End" numeric)

-- Creating state_info table
CREATE TABLE state_info (state_id VARCHAR(2),state VARCHAR(100),population INTEGER)

-- Importing state information data
 COPY state_info(state_id,state,population) 
 FROM 'D:\Google Drive\Professional Projects\Portfolio\Data Analysis\Water in Mexico\population_by_state.csv' 
 DELIMITER ',' 
 CSV HEADER;
-- General query
SELECT * FROM state_info
