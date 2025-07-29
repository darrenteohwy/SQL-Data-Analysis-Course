/*
Question: What are the skills required for the top-paying data analyst job?
- Use the top 10 highest-paying Data Analyst roles that are available in Singapore from the first query.
- Add the specific skills required for each role.
- Why? It provides insights into which high-paying jobs demand skills, helping individuals focus on acquiring the most relevant skills for these roles. 
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
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
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC;



/*Key Insights from the Top Skills in Data Analyst Roles (Singapore, 2023):

Most In-Demand Skills:
Python is the most frequently listed skill (appears in 6 postings), confirming its dominance in data analytics.
Spark, Tableau, and SQL are tied next (each appearing 4 times), indicating a balance between data engineering and visualization needs.

Other Common Tools:
Excel (3 mentions) still holds value, especially in business-facing roles.
R, AWS, Power BI, and Flow are moderately requested, showing some variance in stack preferences across companies.

Less Frequent but Specialized Tools:
Tools like Looker, Hadoop, Linux, and PowerPoint appear only once, suggesting niche or role-specific use.

Tool Diversity:
There's a mix of backend (e.g., Spark, SQL), visualization (e.g., Tableau, Power BI), cloud (e.g., AWS), and business productivity (e.g., Word, Excel) tools, reflecting the multi-disciplinary nature of data analyst roles.

[
  {
    "job_id": 1235922,
    "job_title": "Research Scientist - Energy System",
    "salary_year_avg": "149653.0",
    "company_name": "Bosch Group",
    "skills": "spark"
  },
  {
    "job_id": 1439800,
    "job_title": "Research Scientist - Thermal Systems",
    "salary_year_avg": "149653.0",
    "company_name": "Bosch Group",
    "skills": "python"
  },
  {
    "job_id": 1439800,
    "job_title": "Research Scientist - Thermal Systems",
    "salary_year_avg": "149653.0",
    "company_name": "Bosch Group",
    "skills": "spark"
  },
  {
    "job_id": 1121066,
    "job_title": "Research Scientist - Instrumented Living Spaces",
    "salary_year_avg": "149653.0",
    "company_name": "Bosch Group",
    "skills": "python"
  },
  {
    "job_id": 1121066,
    "job_title": "Research Scientist - Instrumented Living Spaces",
    "salary_year_avg": "149653.0",
    "company_name": "Bosch Group",
    "skills": "spark"
  },
  {
    "job_id": 501111,
    "job_title": "Fraud Data Analyst",
    "salary_year_avg": "111175.0",
    "company_name": "Adyen",
    "skills": "tableau"
  },
  {
    "job_id": 501111,
    "job_title": "Fraud Data Analyst",
    "salary_year_avg": "111175.0",
    "company_name": "Adyen",
    "skills": "looker"
  },
  {
    "job_id": 1295805,
    "job_title": "Data Analyst, Mobile (12 months Fixed Term contract)",
    "salary_year_avg": "111175.0",
    "company_name": "2K",
    "skills": "sql"
  },
  {
    "job_id": 1295805,
    "job_title": "Data Analyst, Mobile (12 months Fixed Term contract)",
    "salary_year_avg": "111175.0",
    "company_name": "2K",
    "skills": "python"
  },
  {
    "job_id": 1295805,
    "job_title": "Data Analyst, Mobile (12 months Fixed Term contract)",
    "salary_year_avg": "111175.0",
    "company_name": "2K",
    "skills": "r"
  },
  {
    "job_id": 1295805,
    "job_title": "Data Analyst, Mobile (12 months Fixed Term contract)",
    "salary_year_avg": "111175.0",
    "company_name": "2K",
    "skills": "spark"
  },
  {
    "job_id": 1295805,
    "job_title": "Data Analyst, Mobile (12 months Fixed Term contract)",
    "salary_year_avg": "111175.0",
    "company_name": "2K",
    "skills": "hadoop"
  },
  {
    "job_id": 1295805,
    "job_title": "Data Analyst, Mobile (12 months Fixed Term contract)",
    "salary_year_avg": "111175.0",
    "company_name": "2K",
    "skills": "tableau"
  },
  {
    "job_id": 1147623,
    "job_title": "Carbon Data Analyst, FiscalNote ESG Solutions",
    "salary_year_avg": "111175.0",
    "company_name": "FiscalNote",
    "skills": "excel"
  },
  {
    "job_id": 1147623,
    "job_title": "Carbon Data Analyst, FiscalNote ESG Solutions",
    "salary_year_avg": "111175.0",
    "company_name": "FiscalNote",
    "skills": "tableau"
  },
  {
    "job_id": 1147623,
    "job_title": "Carbon Data Analyst, FiscalNote ESG Solutions",
    "salary_year_avg": "111175.0",
    "company_name": "FiscalNote",
    "skills": "word"
  },
  {
    "job_id": 1147623,
    "job_title": "Carbon Data Analyst, FiscalNote ESG Solutions",
    "salary_year_avg": "111175.0",
    "company_name": "FiscalNote",
    "skills": "powerpoint"
  },
  {
    "job_id": 1013035,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175.0",
    "company_name": "ADDX",
    "skills": "sql"
  },
  {
    "job_id": 1013035,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175.0",
    "company_name": "ADDX",
    "skills": "python"
  },
  {
    "job_id": 1013035,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175.0",
    "company_name": "ADDX",
    "skills": "aws"
  },
  {
    "job_id": 1013035,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175.0",
    "company_name": "ADDX",
    "skills": "excel"
  },
  {
    "job_id": 1013035,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175.0",
    "company_name": "ADDX",
    "skills": "power bi"
  },
  {
    "job_id": 1013035,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175.0",
    "company_name": "ADDX",
    "skills": "flow"
  },
  {
    "job_id": 226924,
    "job_title": "Data Analyst, Mobile",
    "salary_year_avg": "111175.0",
    "company_name": "2K",
    "skills": "sql"
  },
  {
    "job_id": 226924,
    "job_title": "Data Analyst, Mobile",
    "salary_year_avg": "111175.0",
    "company_name": "2K",
    "skills": "python"
  },
  {
    "job_id": 226924,
    "job_title": "Data Analyst, Mobile",
    "salary_year_avg": "111175.0",
    "company_name": "2K",
    "skills": "r"
  },
  {
    "job_id": 226924,
    "job_title": "Data Analyst, Mobile",
    "salary_year_avg": "111175.0",
    "company_name": "2K",
    "skills": "tableau"
  },
  {
    "job_id": 292547,
    "job_title": "Market Data Specialist, Feeds",
    "salary_year_avg": "109500.0",
    "company_name": "Jane Street",
    "skills": "linux"
  },
  {
    "job_id": 367728,
    "job_title": "Data Analyst",
    "salary_year_avg": "105000.0",
    "company_name": "ADDX",
    "skills": "sql"
  },
  {
    "job_id": 367728,
    "job_title": "Data Analyst",
    "salary_year_avg": "105000.0",
    "company_name": "ADDX",
    "skills": "python"
  },
  {
    "job_id": 367728,
    "job_title": "Data Analyst",
    "salary_year_avg": "105000.0",
    "company_name": "ADDX",
    "skills": "aws"
  },
  {
    "job_id": 367728,
    "job_title": "Data Analyst",
    "salary_year_avg": "105000.0",
    "company_name": "ADDX",
    "skills": "excel"
  },
  {
    "job_id": 367728,
    "job_title": "Data Analyst",
    "salary_year_avg": "105000.0",
    "company_name": "ADDX",
    "skills": "power bi"
  },
  {
    "job_id": 367728,
    "job_title": "Data Analyst",
    "salary_year_avg": "105000.0",
    "company_name": "ADDX",
    "skills": "flow"
  }
]
