/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
*/


SELECT
        skills,
        COUNT(sjd.job_id) AS demand_count
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dm sd ON sjd.skill_id = sd.skill_id

WHERE job_title_short ='Data Analyst'

GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;

/*- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

SELECT
        skills,
        COUNT(sjd.job_id) AS demand_count
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dm sd ON sjd.skill_id = sd.skill_id

GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;

