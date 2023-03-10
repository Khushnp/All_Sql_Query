USE [TrainingDB2]
GO
/****** Object:  StoredProcedure [dbo].[Customers_CRUD]    Script Date: 17-01-2023 11:50:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Customers_CRUD]
      @Action VARCHAR(10)
      ,@CustomerId INT = NULL
      ,@Name VARCHAR(100) = NULL
      ,@Country VARCHAR(100) = NULL
AS
BEGIN
      SET NOCOUNT ON;
 
      --SELECT
    IF @Action = 'SELECT'
      BEGIN
            SELECT [CustomerId], [Name], [Country]
            FROM Customer
      END
 
      --INSERT
    IF @Action = 'INSERT'
      BEGIN
            INSERT INTO Customer(Name, Country)
            VALUES (@Name, @Country)
 
            SET @CustomerId = SCOPE_IDENTITY()
            SELECT @CustomerId [CustomerId], @Name [Name], @Country [Country]
      END
 
      --UPDATE
    IF @Action = 'UPDATE'
      BEGIN
            UPDATE Customer
            SET Name = @Name, Country = @Country
            WHERE CustomerId = @CustomerId
 
            SELECT CustomerId, [Name], [Country]
            FROM Customer
            WHERE CustomerId = @CustomerId
      END
 
      --DELETE
    IF @Action = 'DELETE'
      BEGIN
            DELETE FROM Customer
            WHERE CustomerId = @CustomerId
 
            SELECT @CustomerId [CustomerId], '' [Name], '' [Country]
      END
END