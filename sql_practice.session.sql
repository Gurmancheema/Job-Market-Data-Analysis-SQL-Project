CREATE TABLE company_dim (
    company_id INT,
    name VARCHAR(20),
    link TEXT,
    link_google TEXT,
    thumbnail TEXT
);

CREATE TABLE job_postings_fact(
    job_id INT,
    company_id INT,
    job_title_short VARCHAR(30),
    job_title VARCHAR(50),
    job_location VARCHAR(50),
    job_via VARCHAR(30),
    job_schedule_type VARCHAR(30),
    job_work_from_home BOOLEAN,
    search_location TEXT,
    job_posted_date DATE,
    job_no_degree_mention BOOLEAN,
    job_health_insurance BOOLEAN,
    job_country TEXT,
    salary_rate TEXT,
    salary_year_avg NUMERIC,
    salary_hour_avg NUMERIC
);

CREATE TABLE skills_dm(
    skill_id INT,
    skills TEXT,
    type TEXT
);

CREATE TABLE skills_job_dim(
    job_id INT,
    skill_id INT
);