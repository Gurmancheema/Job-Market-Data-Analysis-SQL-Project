-- Let's load the data into the empty tables
-- Data is located in the "data" folder as excel files

--1. Copying "job_postings_fact" data from excel file into the empty table "job_postings_fact"
-- syntax --> COPY "table_name" FROM "path_of_file" DELIMITER "," CSV HEADER;
COPY company_dim FROM 'D:\GitHubProjects\SQL-Project\data\company_dim.csv' DELIMITER ',' CSV HEADER;


COPY job_postings_fact FROM 'D:\GitHubProjects\SQL-Project\data\job_postings_fact.csv' DELIMITER ',' CSV HEADER;


COPY skills_dm FROM 'D:\GitHubProjects\SQL-Project\data\skills_dim.csv' DELIMITER ',' CSV HEADER;


COPY skills_job_dm FROM 'D:\GitHubProjects\SQL-Project\data\skills_job_dim.csv' DELIMITER ',' CSV HEADER;