--Altering the constraints of the tables w.r.t data architecture

ALTER TABLE company_dim ADD CONSTRAINT pk_company_id PRIMARY KEY (company_id);


ALTER TABLE job_postings_fact ADD CONSTRAINT pk_job_id PRIMARY KEY (job_id);

ALTER TABLE skills_dm ADD CONSTRAINT pk_skill_id PRIMARY KEY (skill_id);

ALTER TABLE skills_job_dim ADD CONSTRAINT pk_job_skill_id PRIMARY KEY (job_id,skill_id);


--Since the primary keys are added to the tables, let's now alter the tables for foreign keys

ALTER TABLE job_postings_fact ADD CONSTRAINT fk_company_id FOREIGN KEY (company_id) REFERENCES company_dim(company_id);

ALTER TABLE skills_job_dim ADD CONSTRAINT fk_job_id FOREIGN KEY (job_id) REFERENCES job_postings_fact(job_id);

ALTER TABLE skills_job_dim ADD CONSTRAINT fk_skill_id FOREIGN KEY (skill_id) REFERENCES skills_dm(skill_id);