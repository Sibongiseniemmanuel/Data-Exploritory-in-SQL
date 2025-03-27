select*
from layoffs_staging2;


select max(total_laid_off) as Maximum_ttl,
max(percentage_laid_off) as highest_percent
from layoffs_staging2;

select*
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;

select company,sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select min(`date`), max(`date`)
from layoffs_staging2;

select industry,sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;


select*
from layoffs_staging2;

select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;


select `date`, sum(total_laid_off)
from layoffs_staging2
group by `date`
order by 1 desc;

select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc;

select month(`date`) as `Month`, sum(total_laid_off)
from layoffs_staging2
group by month(`date`)
order by 1 desc;

select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;


-- advance explanatory

SELECT 
    SUBSTRING(`date`, 1, 7) AS `Month`,  -- Extracts Year-Month from the date
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE `date` IS NOT NULL  -- Use `date` directly instead of alias
GROUP BY `Month`
ORDER BY 1 ASC;

with rolling_total as
(
SELECT 
    SUBSTRING(`date`, 1, 7) AS `Month`,  -- Extracts Year-Month from the date
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE `date` IS NOT NULL  -- Use `date` directly instead of alias
GROUP BY `Month`
ORDER BY 1 ASC
)

select `Month`,total_laid_off,
SUM(total_laid_off) over(order by `Month`) as Rolling_total
from rolling_total;


select company,year(`date`),sum(total_laid_off)
from layoffs_staging2
group by company,year(`date`)
order by 3 desc;

-- checking who laid off the most people per year
WITH company_year AS (
    SELECT company, 
           YEAR(`date`) AS years, 
           SUM(total_laid_off) AS total_laid_off
    FROM layoffs_staging2
    GROUP BY company, YEAR(`date`)
), company_year_rank as (
SELECT *, 
       DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Rankings
FROM company_year
WHERE years IS NOT NULL
)
select* from company_year_rank
where Rankings <=5;















































