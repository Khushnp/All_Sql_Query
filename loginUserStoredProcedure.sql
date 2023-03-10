USE [TrainingDB2]
GO
/****** Object:  StoredProcedure [dbo].[sp_loginUser]    Script Date: 17-01-2023 11:50:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  -- =============================================
  -- Author:    FreeCode Spot
  -- Create date: 
  -- Description:    
  -- =============================================
  create PROCEDURE [dbo].[sp_loginUser]
      @email Nvarchar(50),
      @password nvarchar(200),
      @retVal int OUTPUT
      AS
  BEGIN
      SET NOCOUNT ON;
         Select 
                userid,
                username,
                email,
                [role],
                reg_date 
                FROM tbl_users 
                where Email = @email and 
               [Password] = CONVERT(VARCHAR(32), HashBytes('MD5', @password), 2)
         IF(@@ROWCOUNT > 0)
         BEGIN
          SET @retVal = 200
         END
         ELSE
         BEGIN
           SET @retVal = 500
         END
  END