select * from layoffs;
Create table layoffs_store
like layoffs;
Select * from layoffs_store;
Insert layoffs_store
select * from layoffs;
select * from layoffs_store;

-- REMOVE DUPLICATES
With duplicate_cte as
(
Select * , 
row_number() over(partition by company, location,industry,
 total_laid_Off, `date`,stage,country,funds_raised_millions,
 percentage_laid_off) as row_num
from layoffs_store
)
select * from duplicate_cte
where row_num >1;

Select * from layoffs_store
where company = "Casper";

CREATE TABLE `layoffs_store_table2` (
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

Insert into layoffs_store_table2
Select * , 
row_number() over(partition by company, location,industry,
 total_laid_Off, `date`,stage,country,funds_raised_millions,
 percentage_laid_off) as row_num
from layoffs_store;
Select*from layoffs_store_table2
where row_num>1;

DELETE FROM layoffs_store_table2
WHERE row_num > 1;

Select*from layoffs_store_table2;

-- STANDARDIZING DATA
Select company, trim(company) as Trimmed_company
from layoffs_store_table2;
SELECT * From layoffs_store_table2
where industry like "crypto%";
update layoffs_store_table2 
set industry = "crypto"
where industry like "crypto%";
Select * 
from layoffs_store_table2
where country like "United states%"
order by 1;
Select distinct country , trim(trailing "."  from country)
from layoffs_store_table2
order by 1 ;
Update layoffs_store_table2
set country = trim(trailing "." from country)
where country like "united states%";

-- FORMATING DATE 
SELECT `DATE`,
STR_TO_DATE(`date`,"%m/%d/%Y") AS DATE_UPDATED
FROM layoffs_store_table2;

Update layoffs_store_table2 
set `date` = STR_TO_DATE(`date`,"%m/%d/%Y");
select * from layoffs_store_table2;

Alter table layoffs_store_table2
modify column `date` DATE;


-- WORKING WITH NULL AND BLANK VALUES
select *
from layoffs_store_table2
where  industry = "" ;	
update layoffs_store_table2 t1
set industry = null
where industry = "NULL";
Select *
from layoffs_store_table2 t1
join layoffs_store_table2 t2
	on t1.company = t2.company;
select * 
from layoffs_store_table2 
where company like "bally%";

-- PERCENTAGE AND FUNDS NULL
SELECT * from layoffs_store_table2
where percentage_laid_off is null 
and total_laid_off is null;

Delete from layoffs_store_table2
where percentage_laid_off is null 
and total_laid_off is null;

select * from layoffs_store_table2;

alter table layoffs_store_table2
drop column row_num;




