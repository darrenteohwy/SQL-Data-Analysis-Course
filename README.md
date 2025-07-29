# SQL Data Analysis Course
Followed a SQL Data Analysis Course Youtube Series by the talented Mr Luke Barousse. Appreciate the high-quality course and invaluable teachings by him.
# Introduction
Diving into the data jobs market! Focusing on data analyst roles, this project explores the top-paying jobs, in-demand skills, and where high demand meets high salary in data analytics in Singapore.

Check out all the SQL queries here: [project_sql folder](/project_sql/)  

# Background
This project analyzes the top 10 data analyst job postings in Singapore from 2023 to uncover trends in skill demand and salary potential. By examining the frequency of technical skills and their associated average salaries, we aim to identify which tools and platforms are most valued in the current job market.

The dataset was obtained from Mr Luke Barousse's SQL Beginner's Course includes:
Job titles, company names, and salary data

Individual skills listed per job posting

Average salary rankings for the top 25 most in-demand skills

This analysis provides insight into how specific skills — such as Python, Spark, and BI tools — contribute to higher-paying analyst roles and helps professionals prioritize skills for career growth.

## The questions that I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst jobs in Singapore?
2. What are the skils required for these top-paying data analyst jobs in Singapore?
3. What are the skills most in-demand for data analysts in Singapore?
4. Which skills are associated with higher salaries in Singapore's data analyst scene?
5. What are the most optimal skills to learn?

# Tools Used
For this project, I utilized several key tools:
- **SQL** : The primary backbone tool for this project's analysis, which allowed me to query the database and discover critical insights.
- **PostgreSQL** : The chosen database management system that was used due to it's high popularity. PostgreSQL is ideal for handling the job posting data.
- **Visual Code Studio** : My favourite IDE for coding, especially for database management and executing SQL files.
- **Git & GitHub** : Essential for version control and sharing my SQL scripts and analysis. They allow me to ensure collaboration and project tracking.

# Analysis
Each query for this project is aimed to investigate a specific aspect of the data analyst job market in Singapore. Here's the breakdown of each query and how it answers the overarching problem questions:

### 1. Top Paying Data Analysts Jobs In Singapore
To identify the top-paying data analyst roles in Singapore, I filtered the data analyst positions by average yearly salary and location, focusing on Singapore based roles. This query highlights the high paying opportunities in the field.

``` sql
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
```
Here’s a breakdown of the findings from the top 10 data analyst job postings in Singapore:

- Bosch Group dominates the top-paying roles, with three Research Scientist positions averaging SGD 149,653/year, suggesting that analyst-adjacent R&D roles in engineering systems command significantly higher salaries.

- Most high-paying data analyst roles cluster around the SGD 111K range, offered by firms like ADDX, 2K, FiscalNote, and Adyen, across sectors such as fintech, gaming, ESG, and fraud analytics.

- Contract roles can still offer competitive pay: for example, a 12-month fixed-term contract at 2K pays the same as its full-time counterpart, highlighting demand for specialized short-term data talent.

![Top Paying Data Analysts Job in Singapore](assets\Top_10_Data_Analyst_Roles_in_Singapore_by_Average_Yearly_Salary_2023.png)
*Bar graph visualizing the salary for the top 10 salaries for data analysts in Singapore in 2023; ChatGPT generated this graph based on the SQL query results.*

### 2. Skills required for top-paying data analyst jobs in Singapore
To understand the skills needed for the top-paying jobs, I joined the job postings data with the skills data, providing insights into what employers value for high compensation roles.

``` sql
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
```
Key Insights from the Top Skills in Data Analyst Roles (Singapore, 2023):

- Most In-Demand Skills:
Python is the most frequently listed skill (appears in 6 postings), confirming its dominance in data analytics.
Spark, Tableau, and SQL are tied next (each appearing 4 times), indicating a balance between data engineering and visualization needs.

- Other Common Tools:
Excel (3 mentions) still holds value, especially in business-facing roles.
R, AWS, Power BI, and Flow are moderately requested, showing some variance in stack preferences across companies.

- Less Frequent but Specialized Tools:
Tools like Looker, Hadoop, Linux, and PowerPoint appear only once, suggesting niche or role-specific use.

- Tool Diversity:
There's a mix of backend (e.g., Spark, SQL), visualization (e.g., Tableau, Power BI), cloud (e.g., AWS), and business productivity (e.g., Word, Excel) tools, reflecting the multi-disciplinary nature of data analyst roles.

![Top skills required by top-paying data analysts jobs in Singapore](assets\Top_15_Wanted_Skills_in_Top_10_Data_Analyst_Roles_Singapore.png)
*Bar graph visualizing the top 15 skills needed by the top 10 data analysts based on salary in Singapore in 2023; ChatGPT generated this graph based on the SQL query results.*

### 3. Most in-demand skills wanted for data analytics in Singapore
This query helped to identify the skills most frequently requested by data analysts jobs in Singapore.

```sql
SELECT
    skills,
    COUNT(skills_job_dim.skill_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Singapore' AND
    salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5
```
Key Insights:

- SQL leads with 15 mentions, confirming its role as the backbone of data analysis—essential for querying and managing data from relational databases.

- Python (12 mentions) is the top programming language for data analytics, used for automation, data wrangling, and advanced analytics.

- Tableau and Excel (8 each) tie as key tools for data visualization and business reporting—Excel for quick analysis, Tableau for dashboarding.

- R (6 mentions) still holds relevance, particularly in roles involving statistics-heavy or academic-style analysis, but has slightly less demand than Python.

| Skill   | Demand Count |
|---------|--------------|
| SQL     | 15           |
| Python  | 12           |
| Tableau | 8            |
| Excel   | 8            |
| R       | 6            |
*Table of the top 5 most demanded skills in data analyst job listings*

### 4. Skills associated with high-paying data analyst jobs in Singapore
Exploring the average yearly salaries associated with different skills help to reveal which skills are the highest paying.

``` sql
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
```
Key Insights:
- Big data and backend skills like Spark, Linux, and Python command the highest salaries, reflecting their importance in data infrastructure and engineering-heavy analyst roles.

- Niche tools such as Looker, Flow, and Qlik offer high pay, likely due to lower supply of skilled professionals.

- Traditional BI tools (SQL, Tableau, Power BI) and cloud platforms (AWS, Azure, GCP) are valuable but yield slightly lower average salaries unless paired with programming or automation skills.

| Skill       | Avg. Salary (SGD) |
|-------------|-------------------|
| Spark       | 121,027           |
| Looker      | 111,175           |
| Linux       | 109,500           |
| Word        | 105,838           |
| PowerPoint  | 105,838           |
| Flow        | 105,558           |
| Python      | 103,713           |
| Excel       | 100,569           |
| Qlik        | 100,500           |
| Zoom        | 100,500           |
| NumPy       | 100,500           |
| Slack       | 100,500           |
| Pandas      | 100,500           |
| SAS         | 100,500           |
| SPSS        | 99,500            |
| JavaScript  | 98,500            |
| Tableau     | 95,088            |
| R           | 94,676            |
| AWS         | 92,435            |
| SQL         | 87,644            |
| Power BI    | 87,058            |
| Hadoop      | 84,338            |
| Outlook     | 79,200            |
| Azure       | 72,750            |
| GCP         | 72,750            |
*This table ranks the top 25 skills based on the average salary offered in job postings. It highlights how certain technical or niche skills can significantly influence compensation.*

### 5.Most Optimal Skills to Learn
Combining the insights from demanded skills and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries associated with them. This offers a strategic approach to learn skills that can improve hireability for data analyst jobs in Singapore.
``` sql
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
```
Key Takeaways:
- SQL and Python are the most in-demand skills, but Spark and Looker lead in salary, indicating high pay for more specialized or technical roles.

- Excel and Tableau remain highly requested and offer solid mid-range salaries, reinforcing their role in everyday analytics.

- Tools like Flow, Linux, and Looker offer high salaries despite lower demand, suggesting a niche advantage for those who master them.

| Skill       | Demand Count | Avg. Salary (SGD) |
|-------------|---------------|-------------------|
| SQL         | 15            | 87,644            |
| Python      | 12            | 103,713           |
| Excel       | 8             | 100,569           |
| Tableau     | 8             | 95,088            |
| R           | 6             | 94,676            |
| Spark       | 5             | 121,027           |
| AWS         | 5             | 92,435            |
| Flow        | 3             | 105,558           |
| Power BI    | 3             | 87,058            |
| Word        | 2             | 105,838           |
| PowerPoint  | 2             | 105,838           |
| SPSS        | 2             | 99,500            |
| Hadoop      | 2             | 84,338            |
| GCP         | 2             | 72,750            |
| Azure       | 2             | 72,750            |
| Looker      | 1             | 111,175           |
| Linux       | 1             | 109,500           |
| SAS         | 1             | 100,500           |
| Slack       | 1             | 100,500           |
| Qlik        | 1             | 100,500           |
| Pandas      | 1             | 100,500           |
| NumPy       | 1             | 100,500           |
| Zoom        | 1             | 100,500           |
| JavaScript  | 1             | 98,500            |
*This table presents a dual view of demand and salary for key data analyst skills. It highlights which tools are most sought after and which ones command the highest pay, helping professionals balance market demand with career growth opportunities.*



# What I Learned
This project marks my first step into learning SQL and exploring real-world job data. Here’s what I gained from the experience:

- Understanding SQL’s Importance: I learned why SQL is one of the most in-demand skills for data analysts, and how it plays a key role in accessing and analyzing data.

- Interpreting Job Market Data: I practiced analyzing datasets related to job postings to uncover trends in skill demand and salary expectations.

- Working with Real Data: I explored how different tools (like Python and Excel) can be used alongside SQL to clean, analyze, and visualize data for clearer insights. I also used SQLite and PostgreSQL to manage the SQL database.

This project helped me build a foundation in SQL while connecting it to practical, career-relevant questions. I’m excited to continue learning and applying SQL in future projects!

# Conclusions
My conclusion to this valuable first SQL course and capstone project.
## Insights
1. Top-paying data analyst jobs:
Salaries mostly range from SGD 110K to 150K, including high-paying specialized and contract roles.

2. Skills for top-paying jobs:
Python, Spark, Tableau, and SQL dominate, showing the value of programming, big data, and visualization.

3. Most in-demand skills:
SQL leads, followed by Python, Tableau, Excel, and R.

4. Skills linked to higher salaries:
Spark, Linux, Looker, and Python offer top pay; traditional BI and cloud tools also pay well when paired with coding skills.

5. Optimal skills to learn:
Prioritize SQL and Python, then add specialized tools like Spark, Looker, and visualization platforms such as Tableau and Excel.

## Closing Thoughts
This project strengthened my SQL skills while providing practical insights into Singapore’s data analyst job market. It emphasized balancing foundational and specialized skills to boost career prospects and salary potential. I’m motivated to continue building my data analytics expertise through real-world projects and deeper learning. I would like to thank Mr Luke Barousse for his guidance through his course and I look forward to building more projects and progressing in the world of data.