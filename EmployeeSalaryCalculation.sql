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