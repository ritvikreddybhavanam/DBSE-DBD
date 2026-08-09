--  First Trigger Example – AFTER INSERT

create table employees (
    emp_id int primary key,
    emp_name varchar(50),
    dept_id int,
    salary decimal(10, 2)
);

-- Create an audit table:

create table employee_audit (
    audit_id int auto_increment primary key,
    emp_id int,
    emp_name varchar(50),
    action_type varchar(20),
    action_time timestamp default current_timestamp
);

-- Now create the trigger
delimiter $$

create trigger after_employee_insert
after insert on employees
for each row
    begin
        insert into employee_audit
            (emp_id, emp_name, action_type)
        values
            (NEW.emp_id, NEW.emp_name, 'INSERT');
    end $$
delimiter ;

-- Now insert an employee
insert into employees
values (106, 'Arjun', 1, 52000);

--  Second Trigger Example – AFTER DELETE

delimiter $$
create trigger after_employee_delete
after delete on employees
for each row
    begin
        insert into employee_audit
        (emp_id, emp_name, action_type)
        values
        (OLD.emp_id, OLD.emp_name, 'DELETE');
    end $$

delimiter ;

--  Third Trigger Example--AFTER UPDATE Trigger:

delimiter $$
create trigger after_employee_update
after update on employees
for each row
    begin
        insert into employee_audit
        (emp_id, emp_name, action_type)
        values
        (NEW.emp_id, NEW.emp_name, 'UPDATE');
    end $$

delimiter ;

--  Fourth Trigger Example--BEFORE INSERT Trigger:
delimiter $$
create trigger check_salary
before insert on employees
for each row
    begin
        if NEW.salary < 20000 then
            signal sqlstate '45000'
            set message_text  = 'Salary cannot be less than 20000';
        end if;
    end $$

delimiter ;

--  Fifth Trigger Example--BEFORE UPDATE Trigger:

delimiter $$
create trigger prevent_salary_reduction
before update on employees
for each row
    begin
        if NEW.salary < OLD.salary then
            signal sqlstate '45000'
            set message_text = 'Salary reduction is not allowed';
        end if;
    end $$

delimiter ;

