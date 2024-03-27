select * from hrdata

select sum(employee_count) as employee_count from hrdata
--where education = 'Associates Degree'
--where department = 'Sales'
where education_field='Medical'

select count(attrition) from hrdata
where attrition = 'Yes' and education ='High School' and department = 'R&D'
and education_field='Medical'

select round(((select count(attrition) from hrdata where attrition ='Yes' and department='Sales')/
sum(employee_count))*100,2) as attrition_rate from hrdata
where department ='Sales'

select sum(employee_count) - (select count(attrition) from hrdata  where attrition='Yes') as Active_Employee
from hrdata



select round(avg(age),0) as Avg_age from hrdata

--Attrition by gender

select gender, count(attrition) from hrdata
where attrition='Yes' --and education ='High School'
group by gender
order by count(attrition) desc


--department wise atrrition

select department, count(attrition),
round((cast (count(attrition) as numeric)/ (select count(attrition) from hrdata where attrition = 'Yes' ))*100,2) 
as percent_attrition from hrdata 
where attrition='Yes' 
group by department 
order by count(attrition) desc

--employees by age group 

select age, sum(employee_count) as Employee_Count from hrdata
--where department='R&D'
group by age
order by age


--education wise attrition

select education_field, count(attrition) from hrdata
where attrition='Yes'
group by education_field
order by count(attrition) desc

--attrition rate by gender for different age group


select age_band, gender, count(attrition),
round((cast (count(attrition) as numeric)/ (select count(attrition) from hrdata where attrition = 'Yes'))*100,2) 
as percent_attrition from hrdata 
where attrition='Yes'
group by age_band, gender
order by age_band, gender

CREATE EXTENSION IF NOT EXISTS tablefunc;
--job satisfaction rate
select *
from crosstab(
'select job_role, job_satisfaction, sum(employee_count)
from hrdata
group by job_role, job_satisfaction
order by job_role, job_satisfaction')
AS ct(job_role varchar(50), one numeric, two numeric, three numeric, four numeric)
ORDER BY job_role;








