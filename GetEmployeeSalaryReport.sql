-- 3. Task 1 – Employee Salary Report Procedure

create procedure GetEmployeeSalaryReport(
in p_department_name varchar(50),
in p_minimum_salary decimal(10,2)      -- here we provided two input parameter P_department_name and p_minimium_salary to get a input 
)
begin

if p_department_name is null
then
signal sqlstate '45000'
set message_text = 'Department name is required';   -- if any null values appear it will show a error
end if;
	
select
    employee_id as Employee_ID,
    employee_name as Employee_Name,  -- returns the matching values from the table employees
    department as Department,
    designation as Designation,
    basic_salary as Basic_Salary,
    joining_date as Joining_Date
from employees
where department = p_department_name
  and basic_salary >= p_minimum_salary
  and status = 'Active'
order by basic_salary desc;
end