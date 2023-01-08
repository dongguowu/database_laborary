use employees;

select * from employees limit 5;

describe employees;

select first_name from employees group by first_name limit 6;


select 'Bezalel', count(*) from employees where first_name = 'Bezalel';

select first_name, count(first_name) as 'names_count'from employees where first_name <= 'Zvonko' group by first_name order by first_name desc;

select salary, count(emp_no) as 'emps_with_same_salary' from salaries where salary >= 80000 group by salary order by salary;



select first_name, count(first_name) as 'count_of_first_name' from employees group by first_name having count_of_first_name >= 250 order by count_of_first_name  desc;

describe salaries;
select count(distinct emp_no) from  salaries

select emp_no, avg(salary) from salaries where salary > 120000 group by emp_no order by emp_no;

