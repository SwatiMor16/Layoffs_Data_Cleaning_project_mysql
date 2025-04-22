# Data Cleaning Project - Layoff Data

## Project Overview

This project focuses on cleaning and standardizing a dataset of company layoffs to prepare it for analysis. The raw data contains inconsistencies, missing values, and duplicates, which are addressed using SQL.

## Data Source

The dataset was gathered from public sources and contains information on company layoffs, including company name, location, industry, number of employees laid off, date, and funding raised.

## Sample Data (Before Cleaning)

Data set is provided as excel file.

## Data Cleaning Steps

The following steps were performed to clean the data:

1.  **Duplicate Removal:**

    *   Identified and removed duplicate rows based on multiple columns such as `company`, `location`, `industry`, `total_laid_off`, `percentage_laid_off`, `date`, `stage`, `country`, and `funds_raised_millions`.
2.  **Data Standardization:**

    *   Removed leading and trailing spaces from the `company` column.
    *   Standardized values in the `industry` column (e.g., consolidated variations of 'Crypto' into a single category).
    *   Standardized values in the `country` column (e.g., consolidated variations of 'United States' into a single category).
3.  **Date Formatting:**

    *   Converted the `date` column to a consistent date format (`YYYY-MM-DD`).
4.  **Missing Value Handling:**

    *   Populated missing `industry` values based on the company if it could be inferred.
    *   Removed rows where both `total_laid_off` and `percentage_laid_off` were null.
5.  **Unnecessary Column Removal:**

    *   Removed the `row_num` column, which was used only for duplicate identification.

## Technologies Used

*   MySQL
*   SQL

## SQL Script

The SQL script used for data cleaning is available in `data_cleaning_script.sql`.

## File Structure


*   `README.md`: This file.
*   `data_cleaning_script.sql`: The SQL script used for data cleaning.
*   `Layoffs_data_before_cleaning.jpg`: Data before cleaning (replace with the actual file).

## How to Use

1.  **Set up your MySQL database:** Make sure you have MySQL installed and running.
2.  **Import the data:** Load the raw layoff data into a table named `layoffs` in your MySQL database.
3.  **Run the SQL script:** Execute the `data_cleaning_script.sql` script to perform the data cleaning steps.



