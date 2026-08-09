create database if not exists employeedb1;
use employeedb1;

-- 2
create table if not exists employees (
	emp_id int primary key,
    emp_name varchar(50),
    dept_id int,
    salary decimal(10, 2)
);

-- 3
insert into employees values
(101,'Rahul',1,50000),
(102,'Priya',2,65000),
(103,'Anil',1,55000),
(104,'Sneha',3,70000),
(105,'Kiran',2,48000);

-- 4
select * from employees;

-- procedure 1
drop procedure if exists GetEmployees;
delimiter //
create procedure getEmployees()
begin 
	select * from employees;
end //

delimiter //

call GetEmployees();

-- procedure 2
DROP PROCEDURE IF EXISTS GetEmployeeById;
DELIMITER $$

CREATE PROCEDURE GetEmployeeById(IN eid INT)
BEGIN
    SELECT * FROM employees
    WHERE emp_id = eid;
END $$

DELIMITER ;

CALL GetEmployeeById(102);

-- procedure 3
drop procedure if exists IncreaseSalary;
delimiter //

create procedure IncreaseSalary(
	in eid int,
    in amount decimal(10, 2)
)
begin 
	update employees
    set salary = salary + amount
    where emp_id = eid;
end //

delimiter ;

select * from employees;

call IncreaseSalary(101, 5000);
select * from employees;

-- Procedure 4 – Aggregate Function
drop procedure if exists AvgSalary;
delimiter //
create procedure AvgSalary()
begin 
	select avg(salary) as AverageSalary
    from employees;
end //

delimiter //

call AvgSalary();

-- Procedure 5 – JOIN

create table if not exists departments (
	dept_id int primary key,
    dept_name varchar(50)
);

insert ignore into departments values
(1, 'CSE'), (2, 'ECE'), (3, 'EEE');

drop procedure if exists EmployeeDepartment;
delimiter //

create procedure EmployeeDepartment()
begin
    select e.emp_name, d.dept_name, e.salary
    from employees e
    join departments d on e.dept_id=d.dept_id;
END //

delimiter ;

call EmployeeDepartment();

-- Procedure 6 – GROUP BY and AVG

drop procedure if exists DepartmentAverageSalary;
delimiter //

create procedure DepartmentAverageSalary ()
begin
    select d.dept_name,
           count(e.emp_id) as EmployeeCount,
           avg(e.salary) as AverageSalary
    from employees e
    join departments d on e.dept_id=d.dept_id
    group by d.dept_id, d.dept_name;
end //

delimiter ;

call DepartmentAverageSalary();

-- Procedure 7 – IF...ELSE
drop procedure if exists SalaryStatus;
delimiter //

create procedure SalaryStatus(in eid int)
begin
    declare sal decimal(10, 2);

    select salary into sal
    from employees
    where emp_id = eid;

    if sal >= 60000 then
        select 'High Salary' as Status;
    else
        select 'Low Salary' as Status;
    end if;
end //

delimiter ;

call SalaryStatus(102);

-- Procedure 8 – OUT Parameter
drop procedure if exists EmployeeCount;
delimiter //

create procedure EmployeeCount(out total int)
begin
    select count(*) into total
    from employees;
end //

delimiter ;

call EmployeeCount(@total);
select @total as TotalEmployees;

-- Procedure 9 – INOUT Parameter
drop procedure if exists AddBonus;
delimiter //

create procedure AddBonus(inout bonus decimal(10, 2))
begin
    set bonus = bonus + 5000;
end //

delimiter //

set @bonus = 10000;
call AddBonus(@bonus);
select @bonus as UpdatedBouns;

-- Procedure 10 – Transaction
DROP PROCEDURE IF EXISTS TransferSalaryAmount;
DELIMITER $$

CREATE PROCEDURE TransferSalaryAmount(
    IN fromEmp INT,
    IN toEmp INT,
    IN amount DECIMAL(10,2)
)
BEGIN
    START TRANSACTION;

    UPDATE employees
    SET salary=salary-amount
    WHERE emp_id=fromEmp;

    UPDATE employees
    SET salary=salary+amount
    WHERE emp_id=toEmp;

    COMMIT;
END $$

DELIMITER ;

CALL TransferSalaryAmount(101,102,2000);
SELECT * FROM employees WHERE emp_id IN (101,102);

-- Useful Procedure Commands

SHOW PROCEDURE STATUS
WHERE Db='employeedb1';

SHOW CREATE PROCEDURE GetEmployees;

DROP PROCEDURE IF EXISTS GetEmployees;
