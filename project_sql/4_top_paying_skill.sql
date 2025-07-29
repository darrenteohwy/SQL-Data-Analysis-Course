/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst roles.
- Focuses on roles with specified salaries and in Singapore.
- Why? It helps to reveal how different skills impact salary levels for Data Analyst and helps to
identify the most financially rewarding skills to acquire or improve. 
*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
    AND job_location = 'Singapore'
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25;

/*The key insights in 3 bullet points from ChatGPT:

- Big data and programming skills like Spark, Python, and Linux** command the highest salaries, 
reflecting demand for technical, backend-savvy analysts.
- Niche tools like Looker and Flow** offer high pay likely due to lower supply of talent with 
those skills.
- Core BI tools (SQL, Tableau, Power BI)** and cloud skills (AWS, Azure, GCP) are valuable, 
but combining them with programming or automation boosts earning potential.
*/
