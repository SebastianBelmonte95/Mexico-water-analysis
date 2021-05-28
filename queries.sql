----------------- 
--Creating table with dam name, location, capcity (name and namo), current storage, fill percentage and log date.
-----------------
-- CREATE TABLE dam_levels(
-- 	dam_id VARCHAR(3) NOT NULL,
-- 	dam_name VARCHAR(100) NOT NULL,
-- 	state VARCHAR(100) NOT NULL,
-- 	name_storage NUMERIC NOT NULL,
-- 	namo_storage NUMERIC NOT NULL,
-- 	current_storage NUMERIC NOT NULL,
-- 	fill_percent  NUMERIC NOT NULL,
-- 	log_date DATE
-- )

-------- Importing data from CSV files into the DB --------
--  COPY dam_levels(dam_id,dam_name,state,name_storage,namo_storage,current_storage,fill_percent,log_date) 
--  FROM 'D:\Google Drive\Professional Projects\Portfolio\Data Analysis\Water in Mexico\01 - Jan 2021\Jan01.csv' 
--  DELIMITER ',' 
--  CSV HEADER;

-------- Total storage and Current Storage by state and date --------
-- SELECT log_date,state,sum(namo_storage) as state_namo,sum(current_storage) as state_current FROM dam_levels
-- GROUP BY state,log_date
-- Order by state,log_date

SELECT * FROM dam_levels
WHERE dam_name='Chincua'
ORDER BY log_date

