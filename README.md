# Job Market Data Analysis SQL-Project 💼📊
# Introduction 🌟
This project focuses on analyzing a Job Market Dataset 📊 to uncover trends, insights, and valuable metrics 📈 for job seekers 🧑‍💼 & recruiters 🤝. The objective was to understand various factors influencing job availability 💼, required skills 🛠️, salary ranges 💰, and demand across industries 🌍.

Through this project, I aim to demonstrate my skills in [SQL-based data analysis 🗂️](Basic_SQL_Analysis) while deriving actionable insights 🔍 from [real-world datasets 📂](data).

# Background 🧐
I analyzed a dataset representing various job roles, industries, locations, salary ranges, and skill requirements.
The insights gained could be used to:
🎯 Recognize in-demand skills and industries.
💰 Identify trends in salary distributions by location and role.
🗺️ Understand geographical hotspots for opportunities.

### The questions I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools Used 🛠️
The project utilized the following tools and technologies:

1. SQL 🗄️: To query and analyze the dataset effectively.
2. PostgreSQL 🛢️: To store and manipulate the dataset.
3. VS Code 💻: To write and organize queries and outputs.
4. Version Control ⚙️: Git and GitHub to track and share progress.

# The Analysis 🔍

This project aimed to uncover key trends and insights into the job market using a systematic SQL-driven approach. Each query was designed to answer specific questions about job roles, salaries, and in-demand skills. Below is an overview of my analysis process:

## 1.Top-Paying Job Roles 💰

To identify the most lucrative positions, I focused on analyzing job postings with the highest annual salaries across various locations and industries. By filtering for positions offering remote flexibility, the query revealed which roles are the most financially rewarding in the modern job market.

``` /*
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
```

## 2. Skills for High-Salary Jobs 🛠️
Next, I explored the specific skills associated with top-paying positions. By joining job postings with skill requirements, I identified the critical capabilities employers value for well-compensated roles.

```/*
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
```

## 3. Most In-Demand Skills 📈

Understanding demand is key to identifying valuable skills for job seekers. This query revealed the most frequently requested skills in the dataset.
```/*
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
```
## 4. Skills and Salaries 💡

To uncover the relationship between skills and compensation, I analyzed average salaries for jobs requiring specific skill sets.

```
/*
Question: What are the top skills based on salary?
*/

SELECT skills, ROUND(avg(salary_year_avg),2) AS Avg_Yearly_salary
    FROM job_postings_fact jpf

INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dm sd ON sjd.skill_id = sd.skill_id

WHERE salary_year_avg IS NOT NULL

GROUP BY skills

ORDER BY Avg_Yearly_salary DESC
LIMIT 10;

/*- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/
SELECT skills, ROUND(avg(salary_year_avg),2) AS Avg_Yearly_salary
    FROM job_postings_fact jpf

INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dm sd ON sjd.skill_id = sd.skill_id

WHERE salary_year_avg IS NOT NULL 
    AND job_title_short = 'Data Analyst'

GROUP BY skills

ORDER BY Avg_Yearly_salary DESC
LIMIT 10;
```
## 5. Optimal Skills to Learn 🎯

Finally, I identified the sweet spot between skill demand and salary potential. These insights can guide job seekers in prioritizing their learning paths.

```
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
```
# What I Learned 📚

This project allowed me to strengthen my SQL expertise and apply it to a real-world dataset. Here’s what I gained:

* Advanced Querying: Mastered joins, subqueries, and window functions to perform in-depth data analysis.
* Data Aggregation: Learned to summarize and analyze trends using group-based calculations and filtering techniques.
* Insight Extraction: Developed an analytical mindset for translating raw data into actionable insights relevant to stakeholders.

# Conclusion 🏁

This project was a valuable exploration into the job market landscape. It provided:

* A clear understanding of top-paying roles and their skill requirements.
* Insights into the most in-demand skills for job seekers.
* Strategic guidance for professionals to enhance their career prospects.

By combining technical expertise with data-driven insights, this analysis highlights the importance of continuous skill development in a competitive and evolving job market.


