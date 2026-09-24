# Data Analyst Job Market Analysis (SQL)

I used SQL to explore the 2023 job market for **remote data analyst roles**. I wanted to know which roles pay best, which skills they ask for, and which skills are both in demand and well paid.

## Questions

1. What are the top-paying remote data analyst jobs?
2. What skills do those top-paying jobs require?
3. Which skills are most in demand for data analysts?
4. Which skills are linked to the highest salaries?
5. Which skills are worth learning first because they're both in demand and well paid?

## Tools

- **PostgreSQL**: database and queries
- **VS Code**: writing and running queries
- **Git & GitHub**: version control

## Data

The data is job postings from 2023, stored in four tables in a star schema:

| Table | Contents |
|---|---|
| `job_postings_fact` | One row per posting: title, location, schedule, salary, remote flag, date |
| `company_dim` | Company names |
| `skills_dim` | Skill names and types |
| `skills_job_dim` | Links each posting to the skills it asks for |

The scripts in [`sql_load/`](sql_load) create the database and tables and load the data.

## The analysis

Each query is in [`Project_sql/`](Project_sql), with the question and its purpose written at the top.

### 1. Top-paying jobs ([query](Project_sql/1_top_paying_jobs.sql))
Filters to remote data analyst postings with a stated salary, joins company names, and returns the 10 highest-paying roles.

### 2. Skills for top-paying jobs ([query](Project_sql/2_top_paying_job_skills.sql))
Uses the result of query 1 as a CTE and joins it to the skills tables to see what those roles ask for.
- **SQL** was the most requested skill, appearing in 8 of the top roles
- **Python** followed with 7
- **Tableau** was next with 6
- R, Snowflake, pandas and Excel also came up

### 3. Most in-demand skills ([query](Project_sql/3_top_demanded_skills.sql))
Counts how often each skill appears across all remote data analyst postings and returns the top 5.

### 4. Top-paying skills ([query](Project_sql/4_top_paying_skills.sql))
Averages salary by skill for data analyst roles that list a salary, and returns the top 25.
- **Analysts are moving towards engineering:** high-paying roles feature pipeline tools like PySpark, Databricks and Airflow
- **Analytics is merging with ML and cloud:** scikit-learn and Google Cloud Platform show up among the top earners
- **Engineering plus analytics pays most:** DevOps tools such as GitLab and Kubernetes are linked to the highest salaries

### 5. Optimal skills ([query](Project_sql/5_optimal_skills.sql))
Combines demand counts and average salary (two CTEs joined on skill) to find skills that score well on both.

## SQL techniques used

- `INNER JOIN` and `LEFT JOIN` across fact and dimension tables
- Common table expressions (`WITH`) to build queries step by step
- Aggregation with `COUNT`, `AVG`, `ROUND` and `GROUP BY`
- Filtering with `WHERE` and `IS NOT NULL`, sorting with `ORDER BY` and `LIMIT`

## What I learned

- How to design joins across a star schema to answer a business question
- How to break a complex question into CTEs so each step is easy to check
- How to turn query results into practical recommendations, such as which skills to prioritise

## Conclusion

For remote data analyst roles, **SQL, Python and a visualisation tool (Tableau or Power BI)** are the core skills. The highest salaries go to analysts who also have engineering and cloud skills. I'm using this to shape my own development alongside my background in supply chain and procurement.

---

Part of my portfolio: [chiamakaikpo.github.io](https://chiamakaikpo.github.io)
