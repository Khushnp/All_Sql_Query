USE [TrainingDB2]
GO
/****** Object:  StoredProcedure [dbo].[getAllBooks]    Script Date: 17-01-2023 11:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[getAllBooks]
	
AS
Begin
	SELECT id , Name, AuthorId,Publisher
	from Book1
	order by id;
end;
