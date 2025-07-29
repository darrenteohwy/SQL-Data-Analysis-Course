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

/*Here’s a breakdown of the findings from the top 10 data analyst job postings in Singapore:

Bosch Group dominates the top-paying roles, with three Research Scientist positions averaging SGD 149,653/year,
 suggesting that analyst-adjacent R&D roles in engineering systems command significantly higher salaries.

Most high-paying data analyst roles cluster around the SGD 111K range, offered by firms like ADDX, 2K, FiscalNote,
 and Adyen, across sectors such as fintech, gaming, ESG, and fraud analytics.

Contract roles can still offer competitive pay—for example, a 12-month fixed-term contract at 2K pays the same as 
its full-time counterpart, highlighting demand for specialized short-term data talent. */
