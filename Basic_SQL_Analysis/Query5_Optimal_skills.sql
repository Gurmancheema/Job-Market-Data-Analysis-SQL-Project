/*
Question: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
*/

SELECT skills, ROUND(AVG(salary_year_avg),2) AS Avg_Yearly_salary,
                COUNT(sjd.job_id) AS demand_count
    FROM job_postings_fact jpf

INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dm sd ON sjd.skill_id = sd.skill_id

WHERE salary_year_avg IS NOT NULL

GROUP BY skills

ORDER BY Avg_Yearly_salary DESC, demand_count DESC

LIMIT 15;

/*- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/

SELECT skills, ROUND(AVG(salary_year_avg),2) AS Avg_Yearly_salary,
                COUNT(sjd.job_id) AS demand_count
    FROM job_postings_fact jpf

INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dm sd ON sjd.skill_id = sd.skill_id

WHERE salary_year_avg IS NOT NULL
        AND job_location = 'Anywhere'
        AND job_title_short = 'Data Analyst'

GROUP BY skills

ORDER BY Avg_Yearly_salary DESC, demand_count DESC

LIMIT 15;