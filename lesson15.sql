create table if not exists xyz_employee (
 emp_id integer,
 f_name varchar(150),
 l_name varchar(150),
 job_id varchar(150),
 salary integer,
 manager_id integer,
 dept_id integer
);

---imported the values to the table by right clicking the table, importing the sheet file

select concat(f_name, ',', l_name) as emp_name, salary
from xyz_employee xe 
where salary > '85000'
order by salary desc;

---now as per asked on the excercise, using SELF JOIN to compare the salaries

select e1.f_name
from xyz_employee as e1
join xyz_employee as e2 on e1.salary > e2.salary
where e2.f_name = 'Calvin';

---Display ID and Last Name Above Average Salary (Using Subqueries)

select emp_id, l_name, avg(salary)
from xyz_employee
group by emp_id
having salary > (
select avg(salary)
from xyz_employee xe 
)
;

---Display ID and First Name Above MW789 (Sorted by Salary Using Set Operations)

select job_id, f_name
from xyz_employee
group by job_id
having salary > (
select salary
from xyz_employee xe 
where job_id = 'MW789'
)
EXCEPT 
select job_id, f_name
from xyz_employee xe
group by job_id
having job_id = 'MW789';

---Display Top Three Earners (Using Joins and Subqueries)

select distinct e1.f_name, e1.emp_id, e1.salary
from (select *
      from xyz_employee xe) e1
join xyz_employee as e2 on e1.salary > e2.salary
order by e1.salary desc
limit 3;


