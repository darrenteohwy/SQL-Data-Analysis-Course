/*
Question: What are the top-paying data analyst job?
- Identify the top 10 highest-paying Data Analyst roles that are available in Singapore.
- Focuses on job postings with specified salaries (remove any null values)
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into the final question which is the most optimal roles that people should be pursuing to have the highest chance and pay.
*/
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Singapore' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;

