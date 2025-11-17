# 🎬 MovieLens Analytics Pipeline: ELT with dbt & Snowflake

![dbt](https://img.shields.io/badge/dbt-FF694B?style=for-the-badge&logo=dbt&logoColor=white)
![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=for-the-badge&logo=Snowflake&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![AWS S3](https://img.shields.io/badge/AWS_S3-569A31?style=for-the-badge&logo=amazon-s3&logoColor=white)

## 📖 Overview

This project implements a modern **ELT (Extract, Load, Transform)** data pipeline designed to analyze the MovieLens dataset. By leveraging **Snowflake** for data warehousing and **dbt (data build tool)** for transformation, this pipeline turns raw CSV data into structured, analytics-ready dimensional models suitable for BI tools like Power BI, Tableau, or Looker.

## 🏗 Architecture

![Architecture Diagram](./architecture.jpg)
*High-level Data Flow Diagram*

The pipeline follows a layered architecture pattern:

1.  **Extract & Load:** Raw CSV data (Movies, Ratings, Tags, etc.) is onboarded from local sources/S3 into **Snowflake**.
2.  **Raw Layer:** Data lands in the `RAW` schema in its original format.
3.  **Transformation (dbt):**
    * **Staging Layer:** Cleaning, type casting, and column renaming (e.g., `movieId` → `movie_id`).
    * **Dimension & Fact Layer:** Star Schema modeling to create reusable business concepts.
    * **Mart Layer:** Aggregated tables specifically built for reporting needs.
4.  **Reporting:** The final database serves as the clean source for BI dashboards.

## 📂 Tech Stack

* **Data Warehouse:** Snowflake
* **Transformation:** dbt Core (SQL-based modeling)
* **Orchestration:** dbt CLI
* **Language:** SQL (Dialect: Snowflake) & Python (Config)
* **Version Control:** Git / GitHub

## 🔄 Data Flow & Modeling

The project is organized into specific layers based on dbt best practices:

### 1. Staging Layer (`models/staging/`)
* **Naming:** `src_*.sql`
* **Purpose:** 1:1 mapping with source tables, lightweight cleaning, and standardization.
* **Key Models:** `src_genome_scores`, `src_genome_tags`.

### 2. Dimension Layer (`models/dim/`)
* **Naming:** `dim_*.sql`
* **Purpose:** Descriptive context tables (Who, What, Where).
* **Key Models:**
    * `dim_movies`: Enriched movie metadata (titles, genres).
    * `dim_users`: User demographic information.
    * `dim_genome_tags`: Definitions of genome tag IDs.
    * `dim_movies_with_tags`: Denormalized view of movies and their associated tags.

### 3. Fact Layer (`models/fct/`)
* **Naming:** `fct_*.sql` / `ep_*.sql`
* **Purpose:** Transactional data and measurements (How many, How much).
* **Key Models:**
    * `fct_ratings`: The core transactional table linking users, movies, and ratings.
    * `fct_genome_scores`: Relevance scores linking movies to genome tags.
    * `ep_movies_with_tags`: Ephemeral/Intermediate logic used to calculate complex tag associations.

### 4. Mart Layer (`models/mart/`)
* **Naming:** `mart_*.sql`
* **Purpose:** Business-specific aggregates ready for dashboard consumption.
* **Key Models:**
    * `mart_movie_releases`: Aggregated metrics focusing on release timelines and trends.

## 🚀 Getting Started

### Prerequisites
* Python 3.9+
* Snowflake Account
* dbt-snowflake adapter installed

### Installation

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/your-username/movielens-dbt-snowflake.git](https://github.com/your-username/movielens-dbt-snowflake.git)
    cd movielens-dbt-snowflake
    ```

2.  **Install dependencies:**
    ```bash
    pip install dbt-snowflake
    dbt deps
    ```

3.  **Configure Profile:**
    Update your `~/.dbt/profiles.yml` with your Snowflake credentials.

### Running the Pipeline

* **Test the connection:**
    ```bash
    dbt debug
    ```
* **Run the models:**
    ```bash
    dbt run
    ```
* **Test data integrity:**
    ```bash
    dbt test
    ```
* **Generate Documentation:**
    ```bash
    dbt docs generate && dbt docs serve
    ```

## 📈 Future Improvements
* Add CI/CD pipelines using GitHub Actions.
* Implement `dbt-expectations` for deeper data quality testing.
* Connect a live Power BI dashboard to the final schema.

---
*Created by Akshay Deshneni*
