relational db means data is stored in rows & columns i.e., structured data
mysql
mysql work bench

- we can also use primary key this way
  CREATE TABLE employee(
  EID INT AUTO_INCREMENT, // starts from 1 then increments
  FIrstName varchar(50) NOT NULL,
  LastName varchar(50) NOT NULL,
  Age INT NOT NULL,
  Salary INT NOT NULL,
  Location varchar(50) NOT NULL,
  PRIMARY KEY(EID,FirstNAme), // this becomes composite primary key
  AUTO_INCREMENT=100
  )

INSERT INTO employee VALUES (1,"mohd","awaiz",22,18000,"hyd")

# interview questions starts from 5

priority-joins, CTE

SELECT FirstName,LastName FROM employee WHERE Salary>8000
hows the execution flow
from>where>select

update vs alter
update updates records which is a DML(data manipluation lang) command whereas alter updates schema of the table which is a DDL(data definiton lang) command

delete vs drop similar to update vs alter

primary key vs unique key
in pk we've unique & not null conditions whereas only unique for uk

contraints-4
primary key
unique key
foreign key
not null

aggregation-using all or specified columns and calculating one output
count
min
max
sum
avg
cant be used after where clause directly

select \* from employee order by Salary desc limit 1
execution flow: from>select>order by>limit

select \* from employee where age<20 order by Salary desc limit 1
execution flow: from>where>select>order by>limit

- by gpt
  Here’s the logical order of operations in SQL:
  FROM: Determine the source data.
  WHERE: Filter rows based on conditions.
  GROUP BY: Group rows.
  HAVING: Filter groups.
  SELECT: Select columns.
  ORDER BY: Order the result set.
  LIMIT: Limit the number of rows.

group by constraint
after select whichever non-aggregated(normal column names, not count,max,etc) columns we have, they needed to be specified after group by as well
it works by finding the unique values in the non-aggregated columns specified and use the aggregated function on them

select Leaerner_SOJ, count(\*) as enrollments_via_SOJ from Learner group by Leaerner_SOJ
execution flow:from>select>group by>count

whenever we need group by kind of result but with non-aggregeated columns as output we should go for over partition by instead of joins if we can as they are computationally expensive

select Leaerner_SOJ, count(\*) as enrollments_via_SOJ from Learner group by Leaerner_SOJ having enrollments_via_SOJ>3
for applying condition with group by we have to use having clause

- row_number() vs rank() vs dense_rank(), the diff is only when there are duplicate values and they can be only used with order by

joins
inner left right cross
its not necessary that the common column in the tables have the same name, the values matters not the name

subqueries are like loops & the more we use them the more the time complexity

select LearnerID, Learner_FirstName, Learner_LastName, orderCount,
avg(sum(orderCount)) over() from Learner join
(select orderStudentID, count(\*) as orderCount from orders group by orderStudentID) as temp
on Learner.LearnerID=temp.orderStudentID group by LearnerID
code flow: subquery()>join>group by>select

UPDATE employee SET LastName="rehan" WHERE EID=2
here if we give other feild to where for filtering than the primary key, it will show an error of safe mode that can be changed by admin but it is the best practice to use primary key in filters for accurate results

- wrap column names with " to preserve their order, ex "EID"
