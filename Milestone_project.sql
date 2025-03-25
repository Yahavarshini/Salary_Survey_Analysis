Create database salary_survey;
use salary_survey;
select count(*) from salary_details;
select * from salary_details;

-- 1. Average Salary by Industry and Gender 
select Industry,gender,Round(avg(Total_Salary),2) as Average_Salary
from  salary_details
group by industry,gender
order by Average_Salary desc;

-- 2. Total Salary Compensation by Job Title 
select job_title,
round(sum(Total_salary),2) as Total_Salary_Compensation
from  salary_details
group by job_title
order by Total_Salary_Compensation desc;

-- 3. Salary Distribution by Education Level 
select Highest_Level_of_Education,
round(Avg(Total_salary),2) as Average_Salary,
round(min(Total_salary),2) as Minimum_Salary,
round(max(Total_salary),2) as Maximum_Salary
from  salary_details
group by Highest_Level_of_Education;

-- 4. Number of Employees by Industry and Years of Experience 
select Industry,Experience_in_Field,
count(Industry) as Number_of_Employees
from  salary_details
group by Experience_in_Field,Industry
order by Number_of_Employees desc;

-- 5. Median Salary by Age Range and Gender 
with salary_ranked as (
select age_range,gender,total_salary,
row_number() over (partition by age_range, gender order by total_salary) as row_num,
count(*) over (partition by age_range, gender) as total_rows
from salary_details
)
select age_range, gender, 
round(avg(total_salary), 2) as median_salary
from salary_ranked
where row_num = floor((total_rows + 1) / 2) or row_num = ceil((total_rows + 1) / 2)
group by age_range, gender
order by median_salary desc;

-- 6. Job Titles with the Highest Salary in Each Country 
with ranked_salary as (
select job_title, country, 
round(total_salary, 2) as highest_salary,
rank() over (partition by country order by total_salary desc) as rank_by_country
from salary_details
)
select job_title, country, highest_salary
from ranked_salary
where rank_by_country = 1
order by highest_salary desc;

-- 7. Average Salary by City and Industry 
select Industry,City,
round(Avg(Total_salary),2) as Average_Salary
from  salary_details
group by Industry,City
order by Average_Salary desc;

-- 8. Percentage of Employees with Additional Monetary Compensation by Gender
select gender,
round((count(case when Additional_Monetary_Compensation > 0 then 1 end) * 100 / count(*)),2)
as Percentage_of_Employees
from  salary_details
group by gender;

-- 9. Total Compensation by Job Title and Years of Experience
select Job_Title,Experience_in_Field,
round(sum(Total_salary),2) as Total_Salary_Compensation
from  salary_details
group by Job_Title,Experience_in_Field
order by Total_Salary_Compensation desc;

-- 10. Average Salary by Industry, Gender, and Education Level
select Industry,Gender,
Highest_Level_of_Education,
round(Avg(Total_salary),2) as Average_Salary
from  salary_details
group by Industry,Gender,Highest_Level_of_Education
order by Average_Salary desc;









