select * from language_learners limit 10
---Is the amount of active language use associated with learner retention?
SELECT
    CASE
        WHEN active_use_share < 0.25 THEN 'Low'
        WHEN active_use_share < 0.50 THEN 'Moderate'
        WHEN active_use_share < 0.75 THEN 'High'
        ELSE 'Very High'
    END AS active_use_group,

    COUNT(*) AS learners,

    ROUND(AVG(dropped_out) * 100, 2) AS dropout_rate

FROM language_learners

GROUP BY active_use_group

ORDER BY dropout_rate;
--
WITH grouped_learners AS (
    SELECT
        CASE
            WHEN motivation <= 3 THEN 'Low'
            WHEN motivation <= 6 THEN 'Medium'
            WHEN motivation <= 8 THEN 'High'
            WHEN motivation <= 10 THEN 'Very High'
        END AS motivation_group,

        CASE
            WHEN consistency <= 3 THEN 'Low'
            WHEN consistency <= 6 THEN 'Medium'
            WHEN consistency <= 8 THEN 'High'
            WHEN consistency <= 10 THEN 'Very High'
        END AS consistency_group,

        dropped_out
    FROM language_learners
)

SELECT
    motivation_group,
    consistency_group,
    COUNT(*) AS learners,
    ROUND(AVG(dropped_out) * 100, 2) AS dropout_rate
FROM grouped_learners
GROUP BY
    motivation_group,
    consistency_group
ORDER BY dropout_rate DESC;

-- HARDER language = dropout?
 
SELECT fsi_category,
	COUNT(*) AS learners,
	SUM(dropped_out) AS dropouts,
	round(AVG(dropped_out)*100, 2) AS dropout_rate
FROM language_learners
GROUP BY fsi_category
ORDER BY fsi_category ASC;

--Among learners who study similar amounts, does active language use relate to dropout?
WITH learner_groups AS (
    SELECT
        CASE
            WHEN total_study_hours < 500 THEN 'Low study hours'
            ELSE 'High study hours'
        END AS study_group,

        CASE
            WHEN active_use_share < 0.5 THEN 'Low active use'
            ELSE 'High active use'
        END AS active_use_group,

        dropped_out
    FROM language_learners
)

SELECT
    study_group,
    active_use_group,
    COUNT(*) AS learners,
    ROUND(AVG(dropped_out) * 100, 2) AS dropout_rate
FROM learner_groups
GROUP BY study_group, active_use_group
ORDER BY dropout_rate desc;
--How does dropout vary depending on how much learners study, how much active use they do, and how much comprehensible input they receive?
WITH learner_groups AS (
    SELECT
        CASE
            WHEN total_study_hours < 500 THEN 'Low study hours'
            ELSE 'High study hours'
        END AS study_group,

        CASE
            WHEN active_use_share < 0.5 THEN 'Low active use'
            ELSE 'High active use'
        END AS active_use_group,

        CASE
            WHEN comprehensible_input_hours < 250 THEN 'Low input'
            ELSE 'High input'
        END AS input_group,

        dropped_out
    FROM language_learners
)

SELECT
    study_group,
    active_use_group,
    input_group,
    COUNT(*) AS learners,
    ROUND(AVG(dropped_out) * 100, 2) AS dropout_rate
FROM learner_groups
GROUP BY
    study_group,
    active_use_group,
    input_group
ORDER BY dropout_rate DESC;