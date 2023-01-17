USE [TrainingDB2]
GO
/****** Object:  StoredProcedure [dbo].[getAllAuthor]    Script Date: 17-01-2023 11:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[getAllAuthor]
AS  
BEGIN  
    SELECT id,FirstName, LastName,AddedDate,ModifiedDate
    FROM Author1  
    ORDER BY id;  
END;