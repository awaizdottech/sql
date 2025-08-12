-- aggregation & grouping

select * from Learner

-- count the no of enrollments via diff SOJ
select Leaerner_SOJ, count(*) as enrollments_via_SOJ from Learner group by Leaerner_SOJ
select Leaerner_SOJ, Location, count(*) as enrollments_via_SOJ from Learner group by Leaerner_SOJ, Location
-- how many students enrolled per course
select Selected_Course,count(*) from Learner group by Selected_Course
-- give max years of exp corresponding to SOJ
select Leaerner_SOJ, max(Years_of_Expereince) from Learner group by Leaerner_SOJ
-- count the no of enrollments via diff SOJ & display SOJ with more than 3 students & location is hyd
select Leaerner_SOJ, count(*) as enrollments_via_SOJ from Learner group by Leaerner_SOJ having enrollments_via_SOJ>3 

-- logical operators
-- course records that doesnt include 'Excel'
select * from Course where CourseName not like "%Excel%"
-- learner records with exp>1 & SOJ is youtube
select * from Learner where Years_of_Expereince>1 and Leaerner_SOJ="Youtube" and Location="Hyd" -- we also use 'or' the same way
-- learners with exp btw 1 & 3
select * from Learner where Years_of_Expereince between 2 and 4

-- alter operations
desc employee
alter table employee add column JobPoistion varchar(50)
alter table employee modify column FirstName varchar(40)
alter table employee drop primary key -- as our primary key has auto increment we cant drop it
alter table employee drop column JobPoistion

-- decimal data type
alter table Course modify column CourseDuration_Months decimal(3,1) not null -- here 3 indicates max total digits & 1 indicates max decimal digits. for ex 31.5

alter table Course add column changed_at timestamp default now() -- when I added it filled all the rows that existed with the time when I added this column
insert into Course(CourseName,CourseDuration_Months,CourseFee) values ("AIML camp",2.5,3999)

-- update sql bootcmap fee to 3999
update Course set CourseFee=2999 where CourseID=3 -- but this doesnt change the change_at timestamp, for which we've to define the column as following
alter table Course modify column changed_at timestamp default now() on update now()
desc Course