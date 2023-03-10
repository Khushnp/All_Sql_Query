USE [TrainingDB2]
GO
/****** Object:  StoredProcedure [dbo].[GetStudentGrades]    Script Date: 17-01-2023 11:50:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

   Create PROCEDURE [dbo].[GetStudentGrades]
   @StudentID int
   AS
   SELECT EnrollmentID, Grade, CourseID, StudentID FROM dbo.StudentGrade 
   WHERE StudentID = @StudentID
   