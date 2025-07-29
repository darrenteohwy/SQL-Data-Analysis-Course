/*
Answer: What are the most optimal skills to learn (highest demand and salary)?
- Identify skills in high demand and associated with high salaries for Data Analyst roles.
- Focus on roles with specified salaries and in Singapore.
- Why? Target skills that offer job security and financial benefits, offering a strategic advantage
in career development.
*/

/* More concise updated query*/
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Singapore' AND
    salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id
ORDER BY
    demand_count DESC, 
    avg_salary DESC
LIMIT 25;



/* Initial CTEs to calculate demand and average salary for each skill
WITH skill_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Singapore' AND
        salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
),  skill_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Singapore' AND
        salary_year_avg IS NOT NULL
    GROUP BY skills_job_dim.skill_id
)

SELECT
    skill_demand.skill_id,
    skill_demand.skills,
    demand_count,
    avg_salary
FROM 
    skill_demand
INNER JOIN skill_salary ON skill_demand.skill_id = skill_salary.skill_id
ORDER BY
    demand_count DESC, 
    avg_salary DESC
LIMIT 25; */

