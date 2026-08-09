-- 2. Setup: Employees and Departments Tables
create database if not exists employeedb1;
use employeedb1;

create table if not exists departments (
    dept_id int primary key,
    dept_name varchar(50)
);

create table if not exists employees (
    emp_id int primary key,
    emp_name varchar(50),
    dept_id int,
    salary decimal(10, 2)
);

insert ignore into departments values
(1, 'CSE'),
(2, 'ECE'),
(3, 'EEE');

insert ignore into employees values
(101,'Rahul',1,50000),
(102,'Priya',2,65000),
(103,'Anil',1,55000),
(104,'Sneha',3,70000),
(105,'Kiran',2,48000);

-- 3. Verify the Tables
show tables;
select * from departments;
select * from employees;

-- View 1 – Display All Employees
drop view if exists EmployeeView;

create view EmployeeView as
select *
from employees;

select *
from EmployeeView;

-- View 2 – Selected Columns
drop view if exists EmployeeBasicReview;

create view EmployeeBasicView as
select emp_id, emp_name, salary
from employees;

select *
from EmployeeBasicView;

-- View 3 – High Salary Employees
drop view if exists EmployeeHighestSalary;

create view EmployeeHighestSalary as
select emp_id, emp_name, salary
from employees
where salary > 55000;

select * from EmployeeHighestSalary;

-- View 4 – Employee and Department using JOIN
drop view if exists EmployeeDepartmentView;

create view EmployeeDepartmentView as
select
    emp_id,
    emp_name,
    dept_name,
    salary
from employees
join departments
on employees.dept_id = departments.dept_id;

select * from EmployeeDepartmentView;

-- View 5 – Employees from a Particular Department

drop view if exists CSEEmployees;

create view CSEEmployee as
select
    emp_id,
    emp_name,
    dept_name,
    salary
from employees e
join departments d
on e.dept_id = d.dept_id
where d.dept_name = 'CSE';

select *
from CSEEmployee;

-- View 6 – Department-wise Average Salary
drop view if exists DepartmentSalaryView;

create view DepartmentSalaryView as
select
    dept_name,
    count(emp_id) as EmployeeCount,
    avg(salary) as AverageSalary
from employees e
join departments d
on e.dept_id = d.dept_id
group by d.dept_id, d.dept_name;

select *
from DepartmentSalaryView;

-- View 7 – Departments with Average Salary Above 55000
drop view if exists HighAverageDepartments;

create view HighAverageDepartments as
select
    dept_name,
    avg(salary) as AverageSalary
from employees e
join departments d
on e.dept_id = d.dept_id
group by d.dept_id, d.dept_name
having avg(salary) > 55000;

select *
from HighAverageDepartments;

-- View 8 – Salary Range View
drop view if exists SalaryRangeView;

create view SalaryRangeView as
select
    emp_id,
    emp_name,
    salary
from employees
where salary between 50000 and 70000;

select *
from SalaryRangeView;

-- View 9 – View with Calculated Column

drop view if exists AnnualSalaryView;

create view AnnualSalaryView as
select
    emp_id,
    emp_name,
    salary as MonthlySalary,
    salary * 12 as AnnualSalary
from employees;

select *
from AnnualSalaryView;

-- View 10 – Update Data Through a Simple View

drop view if exists EmployeeSalaryView;

create view EmployeeSalaryView as
select
    emp_id,
    emp_name,
    salary
from employees;

update EmployeeSalaryView
set salary = 60000
where emp_id = 101;

select *
from EmployeeSalaryView;

select *
from employees where emp_id = 101;

-- View 11 – CREATE OR REPLACE VIEW
create or replace view EmployeeBasicView as
select
    emp_name,
    salary
from employees;

select *
from EmployeeBasicView;

-- View 12 – View Definition
show create view EmployeeDepartmentView;

-- View 13 – List All Views
SHOW FULL TABLES
WHERE Table_type = 'VIEW';

-- View 14 – Drop a View
drop view if exists SalaryRangeView;
