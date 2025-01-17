/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/
WITH top_paying_jobs AS (
    SELECT job_id,
        job_title,
        job_title_short,
        job_location,
        job_schedule_type,
        salary_year_avg,
        name AS company_name
         
FROM job_postings_fact jf

JOIN company_dim cd ON jf.company_id = cd.company_id

WHERE job_title_short = 'Data Analyst' AND job_location ='Anywhere' AND salary_year_avg IS NOT NULL

ORDER BY salary_year_avg DESC
LIMIT 10

)


SELECT tpj.*,
        skills
FROM top_paying_jobs tpj

LEFT JOIN skills_job_dim sjd ON tpj.job_id = sjd.job_id
LEFT JOIN skills_dm sd ON sjd.skill_id = sd.skill_id

ORDER BY salary_year_avg DESC;