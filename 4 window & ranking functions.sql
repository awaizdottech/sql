use awaiz_tech
select * from employee
update employee set Location="delhi" where EID=6

-- employees per location & their avg salary
select Location,count(Location) as total, avg(Salary) as Avg_Salary from employee group by Location
-- employees per location & their avg salary with all the records' firstname & lastname
select FirstName,LastName,employee.Location,total,Avg_Salary from employee 
join (select Location,count(Location) as total, avg(Salary) as Avg_Salary 
from employee group by Location) as temp on employee.Location=temp.Location
-- optimising above query via window functions
select FirstName, LastName, Location, count(*) over(partition by Location) as total,
avg(Salary) over(partition by Location) as avg_salary from employee

-- prioritising emplyees based on salary
select FirstName, LastName, Salary, row_number() over(order by Salary desc) as Priority 
from employee -- problem with this method is for same salary it gives diff priority that is all priorities are unique
select FirstName, LastName, Salary, rank() over(order by Salary desc) as Priority 
from employee -- this works by skipping some ranks because it compensates them by giving the same rank like 1 1(in place of 2) 3 ...
select FirstName, LastName, Salary, dense_rank() over(order by Salary desc) as Priority 
from employee -- this works perfectly

-- second highest salary employee
select * from (select FirstName, LastName, Salary, dense_rank() over(order by Salary desc) as Priority 
from employee ) as temp where Priority=2 -- gives all 2nd priority records. for first single record use row_number

-- details of highest salary employee from each location - crazy question
select FirstName, LastName, employee.Location, max_Salary from employee 
join (select Location,max(Salary) as max_Salary from employee group by Location)
as temp on temp.Location=employee.Location where employee.Salary=max_Salary -- my answer
select * from (select FirstName, LastName, Salary, Location, 
row_number() over(partition by Location order by Salary desc) as priority
from employee) as temp where priority=1