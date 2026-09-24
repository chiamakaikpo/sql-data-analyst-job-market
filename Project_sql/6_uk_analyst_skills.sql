/*
Question: What skills do UK data analyst and business analyst roles ask for?
- Focus on job postings located in the United Kingdom
- Compare Data Analyst and Business Analyst roles side by side
- Show each skill as a share of postings, so the two roles can be compared fairly
- Why? The first five questions look at remote roles, mostly US-based. This shows
    which skills matter for the UK roles I'm applying for.
*/

WITH uk_postings AS (
    SELECT
        job_id,
        job_title_short
    FROM job_postings_fact
    WHERE
        job_country = 'United Kingdom' AND
        job_title_short IN ('Data Analyst', 'Business Analyst')
),
role_totals AS (
    SELECT
        job_title_short,
        COUNT(*) AS total_postings
    FROM uk_postings
    GROUP BY job_title_short
),
skill_counts AS (
    SELECT
        uk_postings.job_title_short,
        skills_dim.skills,
        COUNT(*) AS skill_postings
    FROM uk_postings
    INNER JOIN skills_job_dim ON uk_postings.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    GROUP BY uk_postings.job_title_short, skills_dim.skills
)

SELECT
    skill_counts.skills,
    ROUND(100.0 * MAX(CASE WHEN skill_counts.job_title_short = 'Data Analyst'
        THEN skill_postings END) / MAX(CASE WHEN role_totals.job_title_short = 'Data Analyst'
        THEN total_postings END), 1) AS data_analyst_pct,
    ROUND(100.0 * MAX(CASE WHEN skill_counts.job_title_short = 'Business Analyst'
        THEN skill_postings END) / MAX(CASE WHEN role_totals.job_title_short = 'Business Analyst'
        THEN total_postings END), 1) AS business_analyst_pct
FROM skill_counts
INNER JOIN role_totals ON skill_counts.job_title_short = role_totals.job_title_short
GROUP BY skill_counts.skills
ORDER BY data_analyst_pct DESC NULLS LAST
LIMIT 10;
