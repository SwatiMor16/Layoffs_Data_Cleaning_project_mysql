-- Exploratory Data Analysis

select * from layoffs_staging2 ;

select  max(total_laid_off) , min(total_laid_off) , MAX(percentage_laid_off) 
from layoffs_staging2 ;

SELECT * from layoffs_staging2 
where percentage_laid_off = 1
order by total_laid_off desc ;

SELECT * from layoffs_staging2 
where percentage_laid_off = 1
order by funds_raised_millions desc ;

select company , sum(total_laid_off)
from layoffs_staging2
group by company 
order by 2 desc ;   # Amazon

select min(`date`) , max(`date`) 
from layoffs_staging2 ;

select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc ;  # Consumer

select country , sum(total_laid_off)
from layoffs_staging2
group by country 
order by 2 desc ;   # United States

select YEAR(`date`) , sum(total_laid_off)
from layoffs_staging2
group by YEAR(`date`) 
order by 1 desc ; -- most recent

select stage , sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc ;

select substring(`date`,1,7) as `month` , sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7)   is not null
group by `month` 
order by `month` asc;

with Rolling_Total as (
select substring(`date`,1,7) as `month` , sum(total_laid_off) as sum_laid_off
from layoffs_staging2
where substring(`date`,1,7)   is not null
group by `month` 
order by `month` asc
)
select `month` , sum_laid_off ,sum(sum_laid_off) over (order by `month`) as rolling_total  from Rolling_Total ;

select company , YEAR(`date`) , SUM(total_laid_off )
from layoffs_staging2
group by company , YEAR(`date`)
order by 3 DESC ;

WITH Company_year(company, years,sum_laid_off) as (
select company , YEAR(`date`) , SUM(total_laid_off )
from layoffs_staging2
group by company , YEAR(`date`)
order by 3 DESC )
select * , dense_rank() over(partition by years order by sum_laid_off desc) as ranking
 from Company_year
 where years is not null 
 order by ranking asc ;
 
 
 WITH Company_year(company, years,sum_laid_off) as (
select company , YEAR(`date`) , SUM(total_laid_off )
from layoffs_staging2
group by company , YEAR(`date`)
order by 3 DESC ), company_year_rank as
(select * , dense_rank() over(partition by years order by sum_laid_off desc) as ranking
 from Company_year
 where years is not null 
 order by ranking asc )
 select * from company_year_rank
 where ranking <= 5 
 order by years;

