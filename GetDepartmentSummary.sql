-- 5. Task 3 – Salary Grade Procedure


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

