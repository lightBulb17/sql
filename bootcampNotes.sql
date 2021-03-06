-- SELECT customer_id,amount,payment_date  
-- FROM payment
-- WHERE amount <= 1 OR amount >=8;
--  SELECT * FROM payment
--  select cusotmer_id, staff_id from payment
-- select count(*) from payment;
-- select count(distinct amount) from payment
-- select first_name,last_name from customer
-- order by first_name ASC,
-- last_name ASC;
-- select * from customer;
-- select customer_id, amount from payment
-- order by amount desc
-- limit 10;
-- challenge
-- select film_id ,title from film
-- order by film_id asc
-- limit 5;
-- select amount,payment_date from payment
-- where payment_date between '2007-02-07' and '2007-02-15'
-- time stamps 
-- limit 5;
-- where amount not between 8 and 9;
-- select * from city
-- where country_id between 99 and 100
-- order by city desc 
-- limit 3;

-- IN STATEMENT BELOW
select customer_id, rental_id, return_date
from rental 
where customer_id IN (7,13,10)
order by return_date desc;
select * from payment
where amount in(7.99, 8.99);
-- LIKE STATEMENT BELOW
SELECT first_name, last_name 
from customer
where first_name like '%y'--any characters that end in y 
where first_name like '_her%'-- any number of chaacters can be placed in that underscore 
where first_name ILIKE 'bar%'-- no case sensitivity
where first_name LIKE 'BAR%'-- wont find anything cause it needs to match. ABORT

-- how many payment transactions were greater than 5 dollars 
-- select  amount from payment
-- where amount > '5.00'
SELECT count(amount) from payment
where amount > '5.00'
-- how many actors have the first name that starts with the letter p
-- select * from actor
select count(first_name) from actor
where first_name ilike 'p%'

-- how many unique district are our customers from 
-- select DISTINCT count(*) from city
-- select count(DISTINCT(district)) from address;
-- select district from address
select count(DISTINCT (district)) from address
-- retrevie the list of people from those addresses from the question above 
-- select DISTINCT count(*) from city
-- select count(DISTINCT(district)) from address;
-- select district from address
select DISTINCT (district) from address

-- how many films have a rating of R and a replacment cost between5 and 15 doollars
select count(*) from film
where rating =('R')
and replacement_cost BETWEEN 5.00 and 15.00 
-- and replacement_cost BETWEEN 5 and 15
-- select count(rating) from film
-- where rating in('R')

-- how many films have the word truman somewhere in the title
select count(*) from film
where title ilike '%truman%'-- somewhere in the title

-- getting the average amount 
SELECT avg(amount) from payment
-- getting the roundded average
SELECT round(avg(amount)) from payment
-- getting the roundded average to 2 decimal places
SELECT round(avg(amount),2) from payment
-- below gets the count of how many payments were 0.00 dollars 
SELECT COUNT(amount) FROM payment
WHERE amount = 0.00; 
-- getting the minimum amount
SELECT MIN(amount) FROM payment
-- getting the max amount
SELECT Max(amount) FROM payment
-- getting the sum of all the amounts in payment 
SELECT SUM(amount) FROM payment
-- getting the ROUNDED sum of all the amounts in payment 
SELECT ROUND(SUM(amount),1) FROM payment
-- groups the same transcctions together ABORT
SELECT customer_id
FROM payment
GROUP BY customer_id 
-- group by with order by 
SELECT customer_id, sum(amount)
FROM payment
GROUP BY customer_id
order by sum(amount) desc
-- more group by notes 
select staff_id, count(payment_id)
from payment
group by staff_id
-- below counts the number of different types of ratings
select rating, count(rating) from film 
group by rating
-- continued group by 
select rental_duration, count(rental_duration)
from film
GROUP By rental_duration
-- group by average ratings
select rating, avg(rental_rate)
from film 
group by rating
-- group by staff_id, return the total number of payments per staffid and total
-- amount each staff id made. 
select staff_id, count(staff_id),sum(amount)
from payment
group by staff_id
-- get the average replacement cost of each rating of movie 
SELECT rating, round(avg(replacement_cost),2)
from film
group by rating
-- get the top 5 spenders by customer id so you can give coupons to them ABORT
-- for being such good customers 
select customer_id, sum(amount) 
from payment
group by customer_id
order by sum(amount) desc
limit 5 
-- HAVING LECTURE 
-- having clause ABORT
select customer_id, sum(amount)
from  payment
group by customer_id
having sum(amount) >200
--
select store_id, count( customer_id)
from customer
group BY store_id
having count(customer_id)>300
--find the average rate for each rating that are under 3 dollars 
select rating, avg(rental_rate)
from film
where rating    in ('R', 'G','PG' )
group by rating
having avg(rental_rate)<3
-- having challenege find cusotmers that have greater than or equal to 40 
--transacitons
select customer_id, count(*) 
from payment
group by customer_id
having count(*)>=40
--having challenge 
-- find the ratings of movies that had an average rental duration of more than 5
--days 
select rating, avg(rental_duration)
from film
group by rating 
having avg(rental_duration) >5
--Return the customer IDs of customers who have spent at least $110 with the staff member who has an ID of 2.</p>

select customer_id, staff_id, sum(amount) --,sum(amount)
from payment
where staff_id = 2
group by staff_id, customer_id
-- order by sum desc
having sum(amount) > 110
-- the having only works when there is a WHERE  and a GROUP BY claue before it?



--How many films begin with the letter J?------------------------------?2
SELECT count(title)
from film
where title ilike 'j%'-- ilike ignores case sensiviity 
-- where title like 'J%'--check case sensitivity 
-- where title ilike '%j%'-- check anywhere in the text for the asking CHAR
-- where title ilike 'j_%'--check if there is a letter after j and starts with j
-- where title ilike '%j_%'--checks if there is a letter after j and before it

--What customer has the highest customer ID number whose name starts-------?3
--with an 'E' and has an address id lower than 500?
select customer_id,first_name, last_name, address_id
from customer
where first_name like 'E_%' and address_id <500 
order by customer_id desc
limit 1

-- AS examples ------changes the name---------------ASAS AS AS
select customer_id, sum(amount) as total_spend
from payment
group by customer_id

-- JOINS 
select 
customer.customer_id ,
customer.first_name,
last_name,
email,
amount, 
payment_date
from customer
inner join payment on payment.customer_id = customer.customer_id
WHERE customer.customer_id = 2

--more joins 
select payment_id, first_name, last_name from payment
inner join staff on payment.staff_id = staff.staff_id
-- more joins 
select title,count(title)as copies_at_store_1 from inventory
INNER JOIN film on inventory.film_id = film.film_id
-- order by inventory.store_id asc
where inventory.store_id = 1
group by title
order by title
-- order by title
-- having count(title) > 3
-- order by title
----------------------------MORE INNER JOINS------------------------------
-- below joins language with film language_id so you can see both together
select film.title, language.name AS movieLang 
from film
INNER JOIN language 
-- or--- INNER JOIN language AS lan
ON language.language_id = film.language_id
-- or---ON lan.language_id = film.language_id
-- the commeneted out section shows you can you AS to shorten the code 
-- so the code looks more neat 

--NOTE: USING THE 'AS' STATEMENT IS NOT NEEDED. IT WILL STILL WORK WITHOUT IT
--SELECT * FROM TABLEa ______
--INNER JOIN TABLEb ______ 
--ON TABLEa.NAME = TABLEb.NAME

-------------------FULL OUTER JOIN------------------------------------------
-- SELECT * FROM TABLEa
--FULL OUTER JOIN TABLEb
--ON TABLEa.NAME = TABLEb.NAME
-- RETURNS ALL INFORMATION FROM BOTH TABLES 
-------------------LEFT OUTER JOIN------------------------------------------
-- SELECT * FROM TABLEa
-- LEFT OUTER JOIN TABLEb
-- ON TABLEa.NAME - TABLEb.NAME
--RETURNS EVERYTHING IN TABLE a PLUS WHAT TABLE a HAS IN COMMON WITH TABLEb
-------------------LEFT OUTER JOIN WITH WHERE STATEMENT---------------------
-- SELECT * FROM TABLEa
-- LEFT OUTER JOIN TABLEb
-- ON TABLEa.NAME - TABLEb.NAME
-- WHERE TABLEb.ID IS NULL
--RETURNS ONLY THE UNIWUE INFORMATION FROM TABLEa NOTHING IN COMMON WITH TABLEb
------------------FULL OUTER JOIN WITH WHERE STATEMENT---------------------
-- SELECT * FROM TABLEa
-- FULL OUTER JOIN TABLEb
-- ON TABLEa.NAME = TABLEb.NAME
-- WHERE TABLEa.ID IS NULL 
-- OR TABLEb.ID IS NULL 
-- RETURN ONLY UNIQUE INFORMATION FROM BOTH TABLES, THEY DONT HAVE IN COMMON

----- copy of all the movies that are not in inventory -------------
select film.film_id,film.title,inventory_id
from film
LEFT OUTER JOIN inventory on inventory.film_id = film.film_id
where inventory.film_id is null
---------or you can do it this way 
----- copy of all the movies that are not in inventory -------------
select film.film_id,film.title,inventory_id
from film
LEFT OUTER JOIN inventory on inventory.film_id = film.film_id
where inventory_id is NULL
order by title
--- both the same thing above 


-----------------------UNION statement------------------------------
---- union will delete duplicate rows
----- to avoid that use UNION ALL
----------------------extract--------------------------------------
select * from payment
select payment_date from payment
select extract(day from payment_date) from payment
-- more extract
select sum(amount), EXTRACT(month from payment_date) as MONTH
from payment
GROUP by MONTH
order by sum(amount)

-- using || to concat strings ----------------------------------------
SELECT first_name || ' ' ||last_name as full_name 
from customer


------------------------------ subquery -------------------------------
-- a subquery is a query within a query 
SELECT film_id, title, rental_rate FROM film
WHERE rental_rate > (SELECT AVG(rental_rate)FROM film)
-- more complex subquery-------------------- 
select film_id, title
from film
where film_id in 
(select inventory.film_id 
from rental 
inner join  inventory on inventory.inventory_id = rental.inventory_id
-- we are joining the inventory table with the rental table inventory_id above 
WHERE
rental_date BETWEEN '2005-05-29' AND '2005-05-30')
---------------------^^^^more complex subquery^^^^------------------------
--
-- SELF JOIN
select 
a.customer_id, a.first_name, a.last_name,b.customer_id, b.first_name,b.last_name
from customer as a, customer as b 
where a.first_name = b.last_name--
-- SELF JOIN simplified
select 
a.customer_id, a.first_name, a.last_name,b.customer_id, b.first_name,b.last_name
from customer as a
join customer as b 
on a.first_name = b.last_name

--search manager employ self join in google. usually something that pops up in
-- an interview 
--assessment test 2 
--Q1 How can you retrieve all the information from the cd.facilities table? 
select * from cd.facilities

--Q2 You want to print out a list of all of the facilities and their cost to
--   members. How would you retrieve a list of only facility names and costs?
-- select * from cd.facilities
select name, membercost from cd.facilities

-- Q3 How can you produce a list of facilities that charge a fee to members?
-- select * from cd.facilities
select name,membercost from cd.facilities
where membercost >0

-- Q4 How can you produce a list of facilities that charge a fee to members,
-- and that fee is less than 1/50th of the monthly maintenance cost? 
-- Return the facid, facility name, member cost, and monthly maintenance of the 
-- facilities in question.
select facid,name, membercost, monthlymaintenance/50 nm
from  cd.facilities
where membercost>0 and membercost< monthlymaintenance/50

-- Q5 How can you produce a list of all facilities with the word 'Tennis' in
-- their name?
select * from cd.facilities
where name like '%Tennis%'
--------------------------------GETTERS------------------------------------
-- Q6 How can you retrieve the details of facilities with ID 1 and 5? Try to do
-- it without using the OR operator
select * from cd.facilities
where facid in (1,5)
-- where name in ('Tennis Court 2', 'Massage Room 2')
-- where name like '%2'

--------------------DATES---------------------------------
-- Q7 How can you produce a list of members who joined after the start of
-- September 2012? Return the memid, surname, firstname, and joindate of the 
-- members in question.
select memid, surname,firstname,joindate from cd.members
where joindate > 'Sept 01 2012'

--------------------group by removes duplicates
-- Q8 How can you produce an ordered list of the first 10 surnames in the 
-- members table? The list must not contain duplicates.
-- seems as though group by removes duplicates 
SELECT surname from cd.members
group by surname
order by surname
limit 10

-- Q9 You'd like to get the signup date of your last member. How can you
-- retrieve this information?
select joindate from cd.members
order by joindate desc
limit 1

-- Q10 Produce a count of the number of facilities that have a cost to guests 
-- of 10 or more.
select count(guestcost) from cd.facilities
where guestcost >10

-- Q11 skip

-- Q12 Produce a list of the total number of slots booked per facility in the
-- month of September 2012. Produce an output table consisting of facility id 
-- and slots, sorted by the number of slots.
select facid, sum(slots) as total_slots
from cd.bookings
where starttime > 'Sept 01 2012'
group by facid
order by total_slots

-- Q13 Produce a list of facilities with more than 1000 slots booked. Produce
-- an output table consisting of facility id and total slots, sorted by 
-- facility id.

-- select * from cd.facilities
-- select * from cd.bookings
select cd.facilities.facid, cd.facilities.name,sum(cd.bookings.slots)
from cd.bookings
INNER JOIN cd.facilities
ON cd.facilities.facid= cd.bookings.facid
group by cd.facilities.facid
having sum(slots) >1000
order by cd.facilities.facid

-- Q14 How can you produce a list of the start times for bookings for tennis
-- courts, for the date '2012-09-21'? Return a list of start time and facility
-- name pairings, ordered by the time.
SELECT cd.facilities.name,cd.bookings.starttime
from cd.bookings
inner join cd.facilities
on cd.facilities.facid = cd.bookings.facid
where cd.bookings.starttime Between 'Sept 21 2012' and 'Sept 22 2012'
and cd.facilities.name ilike 'tennis%'
order by starttime

-- Q15 How can you produce a list of the start times for bookings by members 
-- named 'David Farrell'?
select 
starttime,cd.members.memid,cd.members.firstname ||' '|| cd.members.surname 
as first_last
from cd.bookings
inner join cd.members
on cd.members.memid = cd.bookings.memid
where firstname = 'David' and surname ='Farrell' 


---------------------CREATE TABLE STATEMENT---------------------------------
CREATE TABLE table_name (
    column_name datatype PRIMARY KEY,
    coulmn_name data_type,.....
)

CREATE TABLE account(
    user_id serial PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(355) UNIQUE NOT NULL,
    created_on TIMESTAMP NOT NULL,
    last_login TIMESTAMP
);
CREATE TABLE role(
    role_id serial PRIMARY KEY,
    role_name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE account_role(
    user_id integer NOT NULL,
    role_id integer NOT NULL,
    grant_date TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY (user_id,role_id),

    CONSTRAINT account_role_role_id_fkey FOREIGN KEY (role_id)
        REFERENCES role (role_id) MATCH SIMPLE
        on UPDATE NO ACTION ON DELETE NO ACTION,

    CONSTRAINT account_role_user_id_fkey FOREIGN KEY(user_id)
        REFERENCES account (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION
);

------------- create table challenege -----------------------------------
CREATE TABLE leads(
    user_id serial PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT null,
    email VARCHAR(355) UNIQUE NOT NULL,
    minutes integer NOT NULL, 
    sign_up_date TIMESTAMP NOT NULL
)
--------------------------------crete table section complete --------------


--------------------------------insert command------------------------------
INSERT INTO TABLE (col1,col2,col3,....)
VALUES (val1,val2,val3,......);-- this is for a single row

INSERT INTO TABLE (col1,col2,col3,....)
VALUES  (val1,val2,val3,......),
        (val1,val2,val3,......),.....; -- multi row insert

--insert data from another tbale 
INSERT INTO TABLE
SELECT col1,col2,...
FROM another_table
WHERE  condition;

2019-01-19 14:14:12
--- NOTE updated tabe size to 2 spaces 
-- first create a new table 
CREATE TABLE link(
  ID serial PRIMARY KEY,
  url VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(255),
  rel VARCHAR(55)
)

select * from link
INSERT INTO link(url,name)
VALUES  ('www.Yahoo.com','Yahoo'),
        ('www.bing.com', 'Bing'),
        ('www.amazon.com', 'Amazon')
-- SELECT * from link

-- below i create a copy of link table using 'like'
CREATE TABLE link_copy (Like link);
-- select* from link_copy
insert into link_copy
select * from link
where name = 'Bing'-- here i am inserting a copy of the bing row to link_copy
select * from link_copy -- this is the check to make sure it worked 


------------------------------UPDATE command------------------------------

Update table 
set 	col1= val1, 
			col2 = val2,....
where condition;

-- SELECT * from link 
UPDATE link
SET description = 'Empty description';
-- more on update  ----------------update using WHERE condition
update link
SET description= 'Name starts with an A'
where name like 'A%'
--select * from link 

update link
set description = 'New description'
where id = 1
RETURNING id, url, name, description --<-- returns the edited row 

-----------------------UPDATE completed--------------2019-01-19 15:09:51
-----------------------delete statement -------------2019-01-19 15:59:14
DELETE FROM table_name
WHERE condition--specifiy which row to delete 
--if no where condition then youll delete all rows 

--examples 
DELETE FROM link
where name LIKE 'B%'
-- deletes all row that start with a captial B in the name 

DELETE FROM link
where name = 'A'
RETURNING * -- returns all the colmns frmo the rows that were deleted
------------------delete completed------------------2019-01-19 16:04:34
------------------Alter statement ------------------2019-01-19 16:15:44
ALTER table table_name action;
--note 
DROP TABLE IF EXISTS link; -- to delete that table

--make new link table 
create TABLE link(
  link_id serial PRIMARY KEY,
  title varchar(512)NOT NULL,
  url VARCHAR(1024)NOT NULL UNIQUE
);

ALTER TABLE link ADD COLUMN active BOOLEAN;
-- adds active boolean type column
alter table link drop COLUMN active
-- again drop that column we just added 

--change names of columns
alter table link RENAME COLUMN title TO new_title
-- changes the table name all together WONT BE NAMED link anymore 
alter table link rename to url_table 
-------------------alter is complete ------------------2019-01-19 16:38:30
-------------------drop table -------------------------2019-01-19 16:39:36
drop table [if exists] table_name -- the if exists is optional to put 
drop table if exists test_two --deletes the table that you made 
drop table if exists test_two RESTRICT -- postgresql uses this by default
-- 2019-01-19 16:52:13
-----------------drop table complete------------------2019-01-19 16:53:49
--------------------check constraint -----------------2019-01-19 16:54:08

create table new_users(
  id serial primary key,
  first_name VARCHAR(50),
  birthday DATE check(birthday > '1900-01-01'),
  join_date Date check(join_date > birthday),
  salary integer check (salary>0)
)

create table checktest(
   sales integer CONSTRAINT positive_sales CHECK (sales>0)
)

insert into checktest(sales)
values (10) -- only accepts positive sales 
------------------check done -------------------------------2019-01-19 17:06:55
------------------null and not null statements ---------2019-01-19 17:07:10
create table learn_null(
  first_name VARCHAR(50),
  sales integer NOT NULL
)
insert into learn_null(first_name)
values('john')-- this will throw an error because sales CANNOT BE NULL

--correct way to do the above because of the constraint
insert into learn_null(first_name, sales)
values('john', 12)
-------------------- null and not null completed --------2019-01-19 17:29:54
------------------- unique statement/ constraint---------2019-01-19 17:31:33
-- create new table to show how it works 
create table people(
  id serial primary KEY,
  first_name VARCHAR(50),
  email VARCHAR(100) UNIQUE

)
insert into people(id, first_name, email)
values (1,'joe', 'joe@joe.com')
-- then try this next 
insert into people(id, first_name, email)
values (2,'joeseph', 'joe@joe.com')--this will cause an error 
-------------------------unique statement completed-------2019-01-19 17:38:42

--------------------assessment test 3----------------------2019-01-19 17:40:36
-- first create database called School
create DATABASE School

create table teacher(
  teacher_id serial PRIMARY KEY,
  first_name VARCHAR(50) Not null,
  last_name VARCHAR(50) NOT NULL,
  home_room_number VARCHAR(50) NOT NULL,
  department VARCHAR(50) NOT NULL,
  email VARCHAR(255) UNIQUE Null,
  phone VARCHAR(25) UNIQUE  null
);

create table student(
  stu_id serial PRIMARY KEY,
  first_name VARCHAR(50) Not null,
  last_name VARCHAR(50) NOT NULL,
  home_room_number VARCHAR(50) NOT NULL,
  email VARCHAR(255) UNIQUE Null,
  phone VARCHAR(25) UNIQUE null, 
  grad_year integer not null CONSTRAINT positive_year CHECK(grad_year>2018)
);

--Once you've made the tables, insert a student named Mark Watney (student_id=1)
--who has a phone number of 777-555-1234 and doesn't have an email. He 
--graduates in 2035 and has 5 as a homeroom number
insert into student (first_name,last_name,phone,email,grad_year,home_room_number)
values ('Mark','Watney','777-555-1234','',2035,'5')

-- Then insert a teacher names Jonas Salk (teacher_id = 1) who as a homeroom
-- number of 5 and is from the Biology department. His contact info is: 
-- jsalk@school.org and a phone number of 777-555-4321.
insert into 
teacher (first_name,last_name, email, home_room_number,department,phone)
values ('Jonas', 'Salk', 'jsalk@school.org', '5', 'Biology', '777-555-4321' )
-------------------------assessment test 3 completed ------2019-01-19 18:21:54
------------------------view statement --------------------2019-01-19 18:24:11

create view view_name as query

--- example below
create view  customer_info AS
select first_name,last_name,email,address, phone
from customer
join address
on customer.address_id = address.address_id

select * from customer_info-- you can now use this to see the above statement 
-- this creates the saved view of the select joins statement for easier access

-- alter view allows you to rename the view 
--example
ALTER VIEW customer_info RENAME TO customer_master_list
select * from customer_master_list
-- it has now renamed to customer_master_list
-- want to remove a view? 
Drop VIEW customer_master_list
-----------------------------view completed --------------2019-01-19 18:35:53
