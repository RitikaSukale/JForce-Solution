# JForce-Solution
Hi, My Name is Ritika Sukale..and i am applying for the position of data analyst(sql developer)

following are the files and the explanation of that file that i have given

1. Database.sql
This file includes the data that how i had created the database, a table and the inserted data in it..also i had applies a auto_increment in employee_id column so we don't need to take it manually.

2.GetEmployeeSalaryReport
Task 1 – Employee Salary Report Procedure

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

///////////////3.Calculate Employee Salary
create definer=`root`@`localhost` procedure`CalculateEmployeeSalary`(
in p_employee_id int
)
begin
declare v_employee_name varchar(100);
declare v_basic_salary decimal(10,2);   -- given the temporary variable
declare v_hra decimal(10,2);
declare v_da decimal(10,2);
declare v_pf decimal(10,2);
declare v_net_salary decimal(10,2);
declare v_employee_count int default 0;

if p_employee_id is null then
    signal sqlstate '45000'     -- see if there any null values
    set message_text = 'Employee ID is required';
end if;

select COUNT(*)
into v_employee_count
from employees 
where employee_id = p_employee_id;

if v_employee_count = 0 then
    signal sqlstate '45000'
    set message_text = 'Employee ID does not exist';
    end if;

select employee_name, basic_salary     -- fetches data from table
into v_employee_name, v_basic_salary
from employees
where employee_id = p_employee_id;

set v_hra = v_basic_salary * 0.20;
set v_da = v_basic_salary * 0.10;    -- calcultae salary components
set v_pf = v_basic_salary * 0.12;
set v_net_salary =
    v_basic_salary + v_hra + v_da - v_pf;
    
select
    v_employee_name as Employee_Name,
    v_basic_salary as Basic_Salary,  -- display salary report
    v_hra as HRA,
    v_da as DA,
    v_pf as PF,
    v_net_salary as Net_Salary;
end

//////////4.EmployeeSalaryGrade
create procedure `EmployeeSalaryGrade`(
in p_employee_id int      -- here we assign a input that is employee_id
)
begin
declare v_employee_name varchar(100);
declare v_basic_salary decimal(10,2);    -- we declare a temporary variabel that store the calculated value
declare v_salary_grade char(1);
declare v_employee_count int default 0;

if p_employee_id is null then
    signal sqlstate '45000'                 -- see wheathe a employee_id is not null ...if null it shows a error
    set message_text = 'Employee ID is required';
end if;

select COUNT(*)
into v_employee_count    -- check wheather there is emp id ....if there count 1 or if the emp id is not there....then it will not calcualte the further section
from employees
where employee_id = p_employee_id;

if v_employee_count = 0 then
    signal sqlstate '45000'      -- showa the error msg when employee_id is null
    set message_text = 'Employee ID does not exist';
end if;

select employee_name, basic_salary
into v_employee_name, v_basic_salary  -- fetches the data from the employee table
from employees
where employee_id = p_employee_id;


set v_salary_grade =
    case
        when v_basic_salary < 30000 then'C'     -- performs grade calculation
        when v_basic_salary <= 60000 then 'B'
        else 'A'
    end;

SELECT
    v_employee_name AS Employee_Name,
    v_basic_salary AS Basic_Salary,    -- assign a proper name for the result column
    v_salary_grade AS Salary_Grade;
END



//////5.GetDepartmentSummary
Create procedure GetDepartmentSummary(
in p_department_name varchar(50)    -- we accept two input department naae
)
begin
declare v_department_count int default 0;  -- declare a temporary variable

if p_department_name is null
    then
    signal sqlstate '45000'
    set message_text = 'Department name is required';
end if;


select COUNT(*)
into v_department_count
from employees
where department = p_department_name;

if v_department_count = 0 then
    select
        CONCAT(
            'Department does not exist: ',   -- see wheather the department exist or not
            p_department_name
        ) as Message;
else
    
    select
        department as Department,
        COUNT(*) as Total_Employees,
        AVG(basic_salary) as Average_Salary,
        MAX(basic_salary) as Highest_Salary,
        MIN(basic_salary) as Lowest_Salary,
        SUM(basic_salary) as Total_Salary_Expenditure
    from employees
    where department = p_department_name
	group by department;
end if;
end

