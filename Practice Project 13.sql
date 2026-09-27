create table if not exists student_datasets(
 s_id integer primary key autoincrement,
 s_fname VARCHAR(150),
 s_lname VARCHAR (150),
 student_class integer,
 age integer
);

create table if not exists marksheet_datasets(
 ranking integer primary key,
 s_id integer references student_datasets,
 score integer,
 year DATE,
 class integer
);

insert into student_datasets(s_fname, s_lname, student_class, age)
 values('Krishna', 'Gee', '10', '18'),
       ('Stephen', 'Christ', '10', '17'),
       ('Kailash', 'Kumar', '10', '18'),
       ('Ashish', 'Jain', '10', '16'),
       ('Khusbu', 'Jain', '10', '17'),
       ('Madhan', 'Lal', '10', '16'),
       ('Saurab', 'Kothari', '10', '15'),
       ('Vinesh', 'Roy', '10', '14'),
       ('Rishika', 'R', '10', '15'),
       ('Sara', 'Rayan', '10', '16'),
       ('Rosy', 'Kumar', '10', '16');

insert into marksheet_datasets(score, year, class, ranking, s_id)
values('989', '2014', '10', '1', '1'),
      ('454', '2014', '10', '10', '2'),
      ('880', '2014', '10', '4', '3'),
      ('870', '2014', '10', '5', '4'),
      ('720', '2014', '10', '7', '5'),
      ('670', '2014', '10', '8', '6'),
      ('900', '2014', '10', '3', '7'),
      ('540', '2014', '10', '9', '8'),
      ('801', '2014', '10', '6', '9'),
      ('420', '2014', '10', '11', '10'),
      ('970', '2014', '10', '2', '11'),
      ('720', '2014', '10', '12', '12');

---Write a query to display the student ID and first name of every student in the students table whose age is greater than or equal to 16 and whose last name is Kumar

select s_id, s_fname, s_lname
from student_datasets
where age >= 16 and s_lname = 'Kumar';

---Write a query to display the details of every student from the marksheet table whose score is between 800 and 1000

select student_datasets.s_id, student_datasets.s_fname, student_datasets.s_lname, student_datasets.student_class, student_datasets.student_class, student_datasets.age
from student_datasets
join marksheet_datasets on student_datasets.s_id = marksheet_datasets.s_id
where score between 800 and 1000;

---Write a query to increase the score in the marksheet table by five and create a new score column to display this new score 

select *, score +5 as new_score
from marksheet_datasets;

---Write a query to display the marksheet table in descending order of the score 

select *
from marksheet_datasets
order by score DESC;

---Write a query to display the details of every student whose first name starts with an ‘a’ 

select *
from student_datasets
where s_fname like 'A%';
