# Why Do Language Learners Drop Out?

An exploratory analysis of the factors associated with learners dropping out before reaching B2, using Python and PostgreSQL.

## Question

Why are language learners dropping out before reaching B2, and what factors are associated with retention?

## Dataset

45,000 learners, 18 variables (study hours, comprehensible input, active use, motivation, consistency, prior and related languages, language difficulty and more).
Source: [Language Learning to Fluency: Who Gets There? (Kaggle)](https://www.kaggle.com/datasets/sergionefedov/language-learning-to-fluency-who-gets-there)

## Key findings

- **37% of learners dropped out** before reaching B2.
- **Study hours and comprehensible input showed the strongest links with dropout.** Learners in the lowest study-hours group dropped out nearly 3× as often as the highest group (52.6% vs 18.7%). Dropout fell from 52.9% to 17.1% from the lowest to the highest comprehensible-input group.
- **Active use matters.** Learners who stayed spent 42.9% of their study time actively using the language, versus 34.9% for those who dropped out.
- **Motivation and consistency** both showed a clear gradient: dropout was 23 percentage points lower for the highest motivation group than for the lowest.
- **Harder languages** (higher FSI category) were associated with more dropout (r = 0.27).
- **Prior languages made little difference**, but knowing a language related to the target was linked to slightly lower dropout (33.7% vs 38.5%).

These are associations, not causes. For example, learners who are about to quit naturally log fewer study hours, so part of the study-hours effect may be dropout itself rather than a reason for it.

## Repository contents

| File | Description |
|------|-------------|
| `language_learner_dropout_analysis.ipynb` | Main analysis: data checks, grouping, dropout by factor, correlation ranking, load to PostgreSQL |
| `Language_learning.sql` | SQL queries: dropout by active use, motivation × consistency, FSI category, and combinations of study hours, active use and comprehensible input |

The dataset is not included. Download `language_learning_fluency.csv` from Kaggle and place it in the same folder as the notebook.

## How to run

1. Install the dependencies: `pip install pandas numpy matplotlib sqlalchemy psycopg2-binary`
2. Put `language_learning_fluency.csv` next to the notebook and run it top to bottom.
3. *(Optional)* To run the SQL file, create a PostgreSQL database called `language_fluency`, set the `PG_PASSWORD` environment variable, and run section 7 of the notebook to create the `language_learners` table.

## Tools

Python (pandas, NumPy, matplotlib), PostgreSQL
