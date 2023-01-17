use TrainingDB2

--create three logins(CEO, manager, employee)

--create login CEO
IF EXISTS(
            SELECT *
            FROM sys.syslogins
            WHERE name = 'CEO')
BEGIN
      DROP LOGIN CEO;
END
GO
CREATE LOGIN CEO with password='CEODbo',check_policy = off;
GO

--create user CEO
IF USER_ID('CEO') is not null
        DROP USER CEO;
GO
CREATE USER CEO FOR LOGIN CEO;
GO

--create login Manager
IF EXISTS(
            SELECT *
            FROM sys.syslogins
            WHERE name = 'Manager')
BEGIN
      DROP LOGIN Manager;
END
GO
CREATE LOGIN Manager with password='ManagerDbo',check_policy = off;
GO

--create user manager
IF USER_ID('Manager') is not null
    DROP USER Manager;
GO
CREATE USER Manager FOR LOGIN Manager;
GO
       
--create login employee
IF EXISTS(
            SELECT *
            FROM sys.syslogins
            WHERE name = 'employee')
BEGIN
    DROP LOGIN employee;
END
GO
CREATE LOGIN employee with password='employeeDbo',check_policy = off;
GO

--create user employee
IF USER_ID('employee') is not null
        DROP USER employee
GO
CREATE USER employee FOR LOGIN employee;
GO

--create basic TABLE
IF OBJECT_ID('dbo.tb_Test_ViewPermission','u')is not null
    DROP TABLE dbo.tb_Test_ViewPermission
;
GO
CREATE TABLE dbo.tb_Test_ViewPermission
(
        id int identity(1,1) not null primary key
        ,name varchar(20) not null
        ,level_no int not null
        ,title varchar(20) null
        ,viewByCEO char(1) not null
        ,viewByManager char(1) not null
        ,viewByEmployee char(1) not null
        ,salary decimal(9,2) not null
);

--data init.
INSERT INTO dbo.tb_Test_ViewPermission
SELECT 'AA',0,'CEO','Y','N','N',1000000.0
union all
SELECT 'BB',1,'Manager','Y','Y','N',100000.0
union all
SELECT 'CC',2,'employee','Y','Y','Y',10000.0
;
GO

select * from dbo.tb_Test_ViewPermission


CREATE SCHEMA RLSFilterDemo;  
GO

-- Create filter title function
CREATE FUNCTION RLSFilterDemo.fn_getTitle(@title AS varchar(20))  
    RETURNS TABLE  
WITH SCHEMABINDING  
AS  
RETURN
    SELECT 1 AS result   
    WHERE USER_NAME() IN (
    SELECT A.title 
    FROM dbo.tb_Test_ViewPermission AS A
        INNER JOIN  dbo.tb_Test_ViewPermission AS B
        ON a.level_no <= B.level_no
    WHERE B.title = @title)
GO


-- create security policy base on the filter function
CREATE SECURITY POLICY TitleFilter  
ADD FILTER PREDICATE RLSFilterDemo.fn_getTitle(title)   
ON dbo.tb_Test_ViewPermission  
WITH (STATE = ON);
GO


-- grant permissions to three users.
GRANT SELECT ON dbo.tb_Test_ViewPermission TO CEO;  
GRANT SELECT ON dbo.tb_Test_ViewPermission TO Manager;  
GRANT SELECT ON dbo.tb_Test_ViewPermission TO employee;  


--CEO can read all of the data
EXECUTE AS USER='CEO'
SELECT WhoAmI = USER_NAME()
SELECT * FROM dbo.tb_Test_ViewPermission
REVERT;
GO


--Manager can read manager and employee's data, but except CEO's.
EXECUTE AS USER='Manager'
SELECT WhoAmI = USER_NAME()
SELECT * FROM dbo.tb_Test_ViewPermission
REVERT;
GO



--employee just can read employee's data, couldn't query CEO and Manger's.
EXECUTE AS USER='employee'
SELECT WhoAmI = USER_NAME()
SELECT * FROM dbo.tb_Test_ViewPermission
REVERT;
GO


 








