-- data cleaning


select * from layoffs ;

create table layoffs_staging like layoffs ; -- create schema of new table same as that of layoffs.

-- we will make changes in layoffs_staging so that in case of some mistake we have raw data available
-- with us 

select * from layoffs_staging ; 

insert layoffs_staging    -- inserted all data from layoffs to layoffs_staging
select * from layoffs ;

-- give a row number to distinct rows

select * , row_number() over(
partition by company,industry,total_laid_off,percentage_laid_off,'date') as row_num
from layoffs_staging ;

-- now store the above table by any method you want like ctes or stored procedure

-- to create a cte and find the duplicate 

with duplicate_cte as (
select * , row_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions) as row_num
from layoffs_staging 
) 
delete from duplicate_cte
where row_num > 1 ;        -- now we can't delete data from a cte it is not upgradeable

-- now we will create an another table like layoffs_staging and add another column named row_number

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


insert into layoffs_staging2
select * , row_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions) as row_num
from layoffs_staging  ;

select * from layoffs_staging2 ;

DELETE FROM layoffs_staging2 
WHERE
    row_num > 1;
    
SET SQL_SAFE_UPDATES = 0;

select *  FROM layoffs_staging2 
WHERE
    row_num > 1;
    
-- standardising data 

select company , trim(company)
from layoffs_staging2 ;

update layoffs_staging2
set company = trim(company) ;  -- extra space removed from startpoint and endpoint


select distinct industry from layoffs_staging2 
order by 1;

update layoffs_staging2 
set industry = 'Crypto'
where industry like 'Crypto%' ;

SELECT DISTINCT location from layoffs_staging2
order by 1 ;

SELECT DISTINCT country from layoffs_staging2
order by 1 ;

update layoffs_staging2 
set country = 'United States'
where country like 'United States%' ;

SELECT `date` , str_to_date(`date`, '%m/%d/%Y') 
FROM layoffs_staging2 ;   

update layoffs_staging2
set `date` =  str_to_date(`date`, '%m/%d/%Y') ; -- we noticed that data type of the date is still not changed

select * from layoffs_staging2 ;

alter table layoffs_staging2
modify column `date` date ;  -- now the date type is modified


-- now we can try to populate the data which is missing  and is easily pridictable 

select * from layoffs_staging2 
where industry is null 
OR industry = '' ;

select * from layoffs_staging2
where company = 'Airbnb' ;

update  layoffs_staging2
set industry = 'Travel' 
where company = 'Airbnb' ; 

-- we can do it in another way also  using self join 

select t1.company , t1.industry ,t2.company , t2.industry
from layoffs_staging2 t1 join layoffs_staging2 t2
on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null 
and t1.location = t2.location;

-- now we will update the data 

update  layoffs_staging2 t1 join layoffs_staging2 t2
on t1.company = t2.company
set t1.industry = t2.industry
where (t1.industry is null or t1.industry = '')
and t2.industry is not null 
and t1.location = t2.location;  -- we can notice that the data or table is not updated 

-- what we need to do is set the blank industry as null  and then try to update it 

update layoffs_staging2
set industry = null 
where industry = '' ;


-- now when we run the above updated query again it is  updated

select * from layoffs_staging2 ;

-- we should update the data only when we are 100% sure about that 

-- now  we can remove some unusefull data 

select * from layoffs_staging2 
where total_laid_off is null 
and percentage_laid_off is null ;

delete from layoffs_staging2 
where total_laid_off is null 
and percentage_laid_off is null ;

-- now we can observe that row_num is not usefull so we can delete that column 

alter table layoffs_staging2
drop column row_num ;


select * from layoffs_staging2 ;

-- now it is the cleaned data 







