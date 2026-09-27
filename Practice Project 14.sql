create table if not exists patients_datasets(
   p_id VARCHAR(100) primary key,
   date date,
   p_name VARCHAR(100),
   age integer,
   weight integer,
   gender VARCHAR(100),
   location VARCHAR(100),
   phone_no integer,
   disease VARCHAR(100),
   doctor_name VARCHAR(100),
   doctor_id integer
);

insert into patients_datasets(p_id, date, p_name, age, weight, gender, location, phone_no, disease, doctor_name, doctor_id)
values ('AP2021', '15-06-2019',	'Sarath','67','76',	'Male',	'Chennai', '5462829', 'Cardiac', 'Mohan','21'),
       ('AP2022', '13-02-2019', 'John', '62', '80',	'Male',	'Banglore', '1234731', 'Cancer', 'Suraj', '22'),
       ('AP2023', '8-1-2018', 'Henry', '43', '65', 'Male', 'Kerala', '9028320',	'Liver', 'Mehta', '23'),
       ('AP2024', '4-2-2020', 'Carl', '56',	'72', 'Female',	'Mumbai', '9293829', 'Asthma', 'Karthik', '24'),
       ('AP2025', '15-09-2017', 'Shikar', '55', '71', 'Male', 'Delhi', '7821281', 'Cardiac','Mohan', '21'),
       ('AP2026', '22-07-2018',	'Piysuh', '47',	'59', 'Male', 'Haryana', '8912819',	'Cancer', 'Suraj', '22'),
       ('AP2027', '25-03-2017',	'Stephen', '69', '55', 'Male', 'Gujarat', '8888211', 'Liver', 'Mehta', '23'),
       ('AP2028', '22-04-2019',	'Aaron', '75', '53', 'Male', 'Banglore', '9012192',	'Asthma', 'Karthik', '24');

---Display the total number of patients in the table

select count(*)
from patients_datasets;

---Write a query to display the patient id and patient name with the current date

select p_id, p_name, DATE('now') as current_date
from patients_datasets;

---Write a query to display the old patient name and the new patient name in uppercase

select p_name, upper(p_name) as new_p_name
from patients_datasets;

---Write a query to display the patients' names along with the total number of characters in their name

select p_name, length(p_name) as characters_in_p_name
from patients_datasets;

---Write a query to combine the patient's name and the doctor's name in a new column

select p_name, doctor_name,
concat(p_name, ',', doctor_name)
from patients_datasets;

---Write a query to extract the year for a given date and place it in a separate column

select date, substr(date, -4) as year
from patients_datasets;

---Write a query to display duplicate entries in the doctor name column

select doctor_name
from patients_datasets
order by doctor_name;