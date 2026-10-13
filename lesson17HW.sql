create table if not exists Courses (
  courseid integer primary key,
  coursename VARCHAR(150),
  department VARCHAR(150)
);

create table if not exists Instructors(
  InstructorId integer,
  InstructorName VARCHAR(150),
  Department VARCHAR(150) references Courses(department)
);

create table if not exists Students(
  student_id integer,
  f_name VARCHAR(150),
  l_name VARCHAR(150),
  dob date,
  major VARCHAR(150) references Instructors(department),
  gpa numeric
);

create table if not exists Enrollments(
  enrollment_id integer,
  student_id integer references Students(student_id),
  courseid integer references Instructors(courseid),
  semester VARCHAR(150),
  grade VARCHAR(150)
);

---Create a view InstructorSchedule that lists each instructor's courses and department

select c.coursename, i.InstructorName, i.Department
from Instructors i 
join Courses c on i.Department = c.department;

create view InstructorSchedule as
 select c.coursename, i.InstructorName, i.Department
 from Instructors i 
 join Courses c on i.Department = c.department;

---Modify the CourseSummary view to list the distinct semesters each course was offered, along with the total student enrolment

---making queries before the view (had to make 2 because if i filtered just by semester it would only show Fall 2023)

select c.coursename, c.courseid, COUNT(e.student_id) as total_students, e.semester
from Enrollments e 
join Students s on e.student_id = s.student_id
join Instructors i on s.major = i.Department 
join Courses c on i.Department = c.department
where e.semester like 'Fall 2023'
group by c.coursename
order by c.courseid;

select c.coursename, c.courseid, COUNT(e.student_id) as total_students, e.semester
from Enrollments e 
join Students s on e.student_id = s.student_id
join Instructors i on s.major = i.Department 
join Courses c on i.Department = c.department
where e.semester like 'Spring 2024'
group by c.coursename
order by c.courseid;

--Now, creating the view:

create view CourseSummary as

  select c.coursename, c.courseid, COUNT(e.student_id) as total_students, e.semester
  from Enrollments e 
  join Students s on e.student_id = s.student_id
  join Instructors i on s.major = i.Department 
  join Courses c on i.Department = c.department
  where e.semester like 'Fall 2023'
  group by c.coursename
  
UNION ALL

  select c.coursename, c.courseid, COUNT(e.student_id) as total_students, e.semester
  from Enrollments e 
  join Students s on e.student_id = s.student_id
  join Instructors i on s.major = i.Department 
  join Courses c on i.Department = c.department
  where e.semester like 'Spring 2024'
  group by c.coursename
  order by c.courseid;

---Update InstructorSchedule to show only courses for the current semester
  
drop view if exists InstructorSchedule;

create view InstructorSchedule as
 select c.coursename, i.InstructorName, i.Department, e.semester
 from Instructors i 
 join Courses c on i.Department = c.department 
 join Students s on c.department = s.major 
 join Enrollments e on s.student_id = e.student_id
 where e.semester like 'Spring 2024';
  
---Create a view EligibleGraduates that lists students eligible for graduation whose GPA is greater than or equal to 3.7

create view EligibleGraduates as
 select student_id, l_name || '' || f_name as student_name, major
 from Students s 
 where gpa >= '3.7';

---Alter EligibleGraduates to include students' GPAs

drop view if exists EligibleGraduates;

create view EligibleGraduates as
 select student_id, l_name || '' || f_name as student_name, major, gpa
 from Students s 
 where gpa >= '3.7';

---Rename CourseSummary to CourseEnrolmentSummary

drop view if exists CourseSummary;

create view CourseEnrolmentSummary as

  select c.coursename, c.courseid, COUNT(e.student_id) as total_students, e.semester
  from Enrollments e 
  join Students s on e.student_id = s.student_id
  join Instructors i on s.major = i.Department 
  join Courses c on i.Department = c.department
  where e.semester like 'Fall 2023'
  group by c.coursename
  
UNION ALL

  select c.coursename, c.courseid, COUNT(e.student_id) as total_students, e.semester
  from Enrollments e 
  join Students s on e.student_id = s.student_id
  join Instructors i on s.major = i.Department 
  join Courses c on i.Department = c.department
  where e.semester like 'Spring 2024'
  group by c.coursename
  order by c.courseid;
  
  
---Drop View EligibleGraduates
  
drop view if exists EligibleGraduates;

---Create a CTE named SemesterCourses to list all courses offered in the current semester

with SemesterCourses as (
  select c.coursename, c.courseid, e.semester as current_semester
  from Enrollments e 
  join Students s on e.student_id = s.student_id
  join Instructors i on s.major = i.Department 
  join Courses c on i.Department = c.department
  where e.semester like 'Spring 2024'
  group by c.coursename
  order by c.courseid
)
select *
from SemesterCourses;