use TrainingDB2

create user Manager without login
create user SalesRep1 without login
create user SalesRep2 without login

create schema Sales;
Go
Create table Sales.Orders
(
OrderID int,
SalesRep nvarchar(50),
Product nvarchar (50),
Quantity smallint
);

insert into Sales.Orders values(1,'SalesRep1','Valve',5);
insert into Sales.Orders values(2,'SalesRep1','Valve',2);
insert into Sales.Orders values(3,'SalesRep1','Valve',4);
insert into Sales.Orders values(4,'SalesRep2','Valve',2);
insert into Sales.Orders values(5,'SalesRep2','Valve',5);
insert into Sales.Orders values(6,'SalesRep2','Valve',5);
insert into Sales.Orders values(7,'SalesRep3','Valve',3);

--- View 7 rows in the table

select * from Sales.Orders;

--Granting the access on the table to each of the user
grant select on Sales.Orders to Manager;
grant select on Sales.Orders to SalesRep1;
grant select on Sales.Orders to SalesRep2;
go

create schema Security;
go

create function Security.tvf_securitypredicate(@SalesRep as nvarchar(50))
	returns table
with SCHEMABINDING
as 
	return select 1 as tvf_securitypredicate_result
where @SalesRep = USER_NAME() or USER_NAME() = 'Manager';
go

create security policy SalesFilter
ADD FILTER PREDICATE Security.tvf_securitypredicate(SalesRep)
on Sales.Orders
with (state = ON);
go

grant select on Security.tvf_securitypredicate to Manager;
grant select on Security.tvf_securitypredicate to SalesRep1;
grant select on Security.tvf_securitypredicate to SalesRep2;

EXECUTE as user = 'SalesRep1';
select * from Sales.Orders
Revert;

EXECUTE as user = 'SalesRep2';
select * from Sales.Orders
Revert; --to revert the execute as a user command

EXECUTE as user = 'Manager';
select * from Sales.Orders
Revert;

/*
----to alter the security
alter security policy SalesFilter
with (state = off);
--to drop all the things that we have created
DROP USER SalesRep1;
DROP USER SalesRep2;
DROP USER Manager;

DROP SECURITY POLICY SalesFilter;
DROP TABLE Sales.Orders;
DROP FUNCTION Security.tvf_securitypredicate;
DROP SCHEMA Security;
DROP SCHEMA Sales;

*/