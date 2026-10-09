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