create database test_db;

use test_db;

# numeric functions

select abs(-4);

select mod(10, 4) as remainder;

select power(4, 2);

select sqrt(4);

select greatest(4, 44, 444, 4444);

select least(4, 44, 444, 4444);

select truncate (4.48, 1);

select round (4.48, 1);

# students table

create table students
(id int primary key,
first_name varchar(40),
age int, gender char(1), dob date, hometown varchar(20));

insert into students values
(1, 'Dan', 22, 'M', '2001-06-08', 'Hitchin'),
(2, 'Test1', 40, 'F', '1989-12-22', 'Seoul'),
(3, 'Test2', '88', 'M', '2000-01-01', 'Seoul');

select * from students;

select first_name, age from students where age < 30;

select * from students where age < 30 and hometown = 'Hitchin';

select id, dob from students where gender = 'M' or gender = 'F';

select * from students where not gender = 'M';

# group by

select hometown, count(id) as total_students
from students group by hometown;

# having

select hometown, count(id) as total_students
from students group by hometown
having count(id) > 1;

# order by

select * from students order by age desc;

# string functions

select upper('Test') as upper_case;

select lower('Test') as lower_case_1;

select lcase('TEST') as lower_case_2;

select character_length('Test') as char_length;

select first_name, char_length(first_name) as name_length
from students;

select concat('Test', 'of', 'concat function');

select concat('Test', ' of', ' concat function') as with_spaces;

select id, first_name, concat(first_name, ' ', age) as name_age
from students;

select reverse('Test');

select reverse(first_name) from students;

select replace('Test is spelled t-a-s-t', 't-a-s-t', 't-e-s-t');

select ltrim('    Test    ');

select length('    Test    ');

select length(ltrim('    Test    '));

select length(rtrim(ltrim('    Test    ')));

select position('e' in 'Test');

select position('word' in 'Test word sentence');

select ascii('a');

select ascii('4');