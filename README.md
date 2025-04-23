# Data Cleaning & EDA Project – Layoff Data Analysis

## Project Overview

This project focuses on cleaning, standardizing, and exploring a dataset of company layoffs. The raw data contained inconsistencies, missing values, and duplicates, which were addressed using SQL. Exploratory Data Analysis (EDA) was then performed to uncover trends and insights in the cleaned data.

## Data Source

The dataset was compiled from public sources and contains information on company layoffs including company name, location, industry, the number of employees laid off, date, and funding raised.

## Data Cleaning Steps

The following steps were performed to clean the data using SQL:

1.  **Duplicate Removal:**

    *   Identified and removed duplicate rows based on multiple columns using SQL window functions.
2.  **Data Standardization:**

    *   Standardized company names, industry classifications, and country names.
3.  **Date Formatting:**

    *   Converted date column to a consistent `YYYY-MM-DD` format.
4.  **Missing Value Handling:**

    *   Imputed missing `industry` values based on company information.
    *   Removed rows where both `total_laid_off` and `percentage_laid_off` were null.

## Exploratory Data Analysis (EDA)

After cleaning, EDA was conducted using SQL to discover key trends:

*   **Layoff Timeline Analysis:** Identified peak layoff months and years.
*   **Industry Analysis:** Determined which industries were most heavily impacted by layoffs.
*   **Company Analysis:** Ranked companies by total layoff count.
*   **Geographic Analysis:** Analyzed layoff distribution by country.
*   **Rolling Totals:** Calculated cumulative layoff counts to identify long-term trends.

## Technologies Used

*   MySQL
*   SQL

## SQL Scripts

*   `data_cleaning_script.sql`: Contains the SQL script used for data cleaning.
*   `EDA.sql`: Contains the SQL script used for exploratory data analysis.


## File Structure


*   `README.md`: This file.
*   `data_cleaning_script.sql`: SQL script for cleaning the data.
*   `EDA.sql`: SQL script for the exploratory data analysis.

## How to Use

1.  **Set up your MySQL database:** Ensure MySQL is installed and running.
2.  **Import the data:** Load the raw layoff data into a table named `layoffs` in your MySQL database.
3.  **Run the SQL scripts:**
    *   Execute `data_cleaning_script.sql` to clean the data.
    *   Execute `eda_code.sql` to perform the exploratory data analysis.

