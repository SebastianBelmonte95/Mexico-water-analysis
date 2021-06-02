import os
import psycopg2
# Starting connection with the database in postgreSQL

conn = psycopg2.connect(
    "host=localhost dbname={} user=postgres password=password".format("Water_in_Mexico"))
cur = conn.cursor()

# Clearing all data from the table so it doesn't overlap
cur.execute("TRUNCATE TABLE dam_levels")
conn.commit()

# Iterating all files for each folder in the current working directory

for folder, sub_folders, files in os.walk(os.getcwd() + "\\Dam levels"):
    for file in files:
        file_path = folder + '\\' + file
        with open(file_path, 'r', encoding="utf-8") as f:
            next(f)  # Skip the header row.

            # Import data from CSV files to DB
            cur.copy_from(f, 'dam_levels', sep=',')
        conn.commit()
cur.close()
conn.close()
