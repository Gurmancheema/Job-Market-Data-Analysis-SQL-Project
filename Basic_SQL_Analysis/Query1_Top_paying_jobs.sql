/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
*/


SELECT job_title,
        job_title_short,
        job_location,
        job_schedule_type,
        salary_year_avg
         
FROM job_postings_fact

WHERE job_title_short = 'Data Analyst' AND job_location ='Anywhere' AND salary_year_avg IS NOT NULL

ORDER BY salary_year_avg DESC

LIMIT 10;


/* 
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
*/

SELECT job_title,
        job_title_short,
        job_location,
        job_schedule_type,
        salary_year_avg,
        name AS company_name
         
FROM job_postings_fact jf

JOIN company_dim cd ON jf.company_id = cd.company_id

WHERE job_title_short = 'Data Analyst' AND job_location ='Anywhere' AND salary_year_avg IS NOT NULL

ORDER BY salary_year_avg DESC

LIMIT 10;