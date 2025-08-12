SHOW DATABASES
use awaiz_tech

create table Course(
	CourseID INT AUTO_INCREMENT PRIMARY KEY,
    CourseName	varchar(50) NOT NULL,
    CourseDuration_Months INT NOT NULL,
    CourseFee INT NOT NULL
)

SHOW TABLES 
DESC Course

insert into Course(CourseName,CourseDuration_Months,CourseFee) values ("The Complete Excel Mastery Course",3,1499);
insert into Course(CourseName,CourseDuration_Months,CourseFee) values ("DSA for Interview Preperation",2,4999);
insert into Course(CourseName,CourseDuration_Months,CourseFee) values ("SQL Bootcamp",2,2999); -- returning * -- or we could also specify field names to get that in return. it seems the 'returning' also works with update & delete & some packages also get u the data without specifying the return clause

create table Learner(
	LearnerID int auto_increment primary key,
    Learner_FirstName varchar(50) not null,
	Learner_LastName varchar(50) not null,
	Learner_Email varchar(50) unique key,
	Learner_PhoneNum varchar(15) not null, -- int doesnt support 10 digits
	Learner_EnrollmentDate timestamp not null,
    Selected_Course int not null,
    Years_of_Expereince int not null,
    Learner_Company varchar(50),
    Leaerner_SOJ varchar(50) not null,
    Batch_Start_Date timestamp not null,
    Location varchar(50) not null,
    foreign key(Selected_Course) references Course(CourseID) -- the key & the reference column should have same data type
    foreign key(Selected_Course) references Course(CourseID) on delete cascade -- this is mentioned in child tables that references parent table, which triggers deletion of all the children connected data automatically if the row in the parent table gets deleted
    foreign key(Selected_Course) references Course(CourseID) on delete restrict -- this is also mentioned in child tables which doesnt allow deletion of the parent table record until all the children referencing records are deleted, opp to cascade, is default behavior of foreign key which means this doesnt need to be mentioned 
)

desc Learner

insert into Learner(Learner_FirstName,Learner_LastName,Learner_Email,Learner_PhoneNum,Learner_EnrollmentDate,Selected_Course,
Years_of_Expereince, Learner_Company,Leaerner_SOJ,Batch_Start_Date,Location) 
values ("Danish","Ahmed","xyz@abc.com","6306306301","2024-01-21",1,1,"Amazon","LinkedIn","2024-02-01","Hyd");
insert into Learner(Learner_FirstName,Learner_LastName,Learner_Email,Learner_PhoneNum,Learner_EnrollmentDate,Selected_Course,
Years_of_Expereince, Learner_Company,Leaerner_SOJ,Batch_Start_Date,Location) 
values ("Abdul","Majid","mno@abc.com","6306306301","2024-01-12",1,1,"Amazon","LinkedIn","2024-02-01","Delhi");
insert into Learner(Learner_FirstName,Learner_LastName,Learner_Email,Learner_PhoneNum,Learner_EnrollmentDate,Selected_Course,
Years_of_Expereince, Learner_Company,Leaerner_SOJ,Batch_Start_Date,Location) 
values ("Fasahat","Hussain","pqr@abc.com","6306306301","2024-01-20",2,1,"Amazon","LinkedIn","2024-02-10","Hyd");
insert into Learner(Learner_FirstName,Learner_LastName,Learner_Email,Learner_PhoneNum,Learner_EnrollmentDate,Selected_Course,
Years_of_Expereince, Learner_Company,Leaerner_SOJ,Batch_Start_Date,Location) 
values ("Alyan","Chaoush","abc@abc.com","6306306301","2024-01-21",2,2,"Google","Youtube","2024-02-10","Mumbai");
insert into Learner(Learner_FirstName,Learner_LastName,Learner_Email,Learner_PhoneNum,Learner_EnrollmentDate,Selected_Course,
Years_of_Expereince, Learner_Company,Leaerner_SOJ,Batch_Start_Date,Location) 
values ("Ismail","Khan","def@abc.com","6306306301","2024-02-12",3,1,"Meta","LinkedIn","2024-02-20","Delhi");
insert into Learner(Learner_FirstName,Learner_LastName,Learner_Email,Learner_PhoneNum,Learner_EnrollmentDate,Selected_Course,
Years_of_Expereince,Leaerner_SOJ,Batch_Start_Date,Location) 
values ("Abdul","Rauf","ghi@abc.com","6306306301","2024-02-02",3,0,"Youtube","2024-02-20","Bangalore");

select * from Learner

-- data analysis
-- highest salary
select * from employee order by Salary desc limit 1
select * from employee where Salary=(select MAX(Salary) as max_salary from employee) -- if we run the inner query separately the result will have the column name max_salary
-- highest salary and age lower than 20
select * from employee where age<20 order by Salary desc limit 1
-- total number of enrollments
select count(*) as number_of_enrollments from employee
-- number of enrollments in course 3
select count(*) as numb_of_course3_enrollments from Learner where Selected_Course=3
-- no of learners enrolled in jan
select count(*) as enrolled_in_jan from Learner where Learner_EnrollmentDate<"2024-02-01" -- this will get all before feb not just jan 2024
select count(*) as enrolled_in_jan from Learner where Learner_EnrollmentDate like "%-01-%"
SELECT COUNT(*) AS enrolled_in_jan FROM Learner WHERE DATE(Learner_EnrollmentDate) = '2024-01-21'; -- from gpt that does the same job as the next one by specifying a single date
select count(*) as enrolled_in_jan from Learner where Learner_EnrollmentDate like "%-01-21%"
-- update Abdul Rauf's experince & company
update Learner set Years_of_Expereince=2,Learner_Company="Nvidia" where LearnerID=6
-- count the companies learners belong to
select count(distinct Learner_Company) from Learner