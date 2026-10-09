create database employees;
use employees;
create table employees (
employee_id int primary key  auto_increment,
employee_name varchar(50),
department varchar(50),
designation varchar(50),
basic_salary decimal(10,2),
joining_date date,
status varchar(50) not null default 'Active');

insert into  employees (employee_name,department,designation,basic_salary,joining_date,status)
values ('Ritika Sukale','Data Analytics', " Data Analyst",20000.00,'2026-01-25','Active'),
       ('Sakshi chavan','HR','Senior HR',30000,'2025-09-24','Inactive'),
       ('mansi gurav','Admin','Admin excutiive',35000,'2025-09-26','Active'),
       ('om rane','AI','Ai Content editor',25000,'2026-08-02','Active'),
       ('deepak patil','HR','junior Hr',26000,'2025-10-10','Active'),
       ('sakshi mishra','HR','Talent Acusition',25000,'2024-01-09','Active'),
       ('mayank patel','customer support','customer_support_enginner',30000,'2025-06-02','Inactive'),
       ( 'Karan Shah', 'IT', 'Junior Developer', 29000, '2024-06-15', 'Active'),
('Pooja Desai', 'Marketing', 'Marketing Manager', 62000, '2021-09-30', 'Active');

select * from employees;
CALL GetEmployeeSalaryReport('HR',25000);
CALL CalculateEmployeeSalary(4);
CALL EmployeeSalaryGrade(1);
call GetDepartmentSummary('HR');