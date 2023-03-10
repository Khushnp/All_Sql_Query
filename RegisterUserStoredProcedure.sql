USE [TrainingDB2]
GO
/****** Object:  StoredProcedure [dbo].[sp_registerUser]    Script Date: 17-01-2023 11:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  -- =============================================
  -- Author:        FeeCode Spot
  -- Create date: 
  -- Description:    
  -- =============================================
  create PROCEDURE [dbo].[sp_registerUser]
      @username Nvarchar(50),
      @email Nvarchar(50),
      @password nvarchar(200),
      @role nvarchar(50),
      @retval int OUTPUT
  AS
  BEGIN
      SET NOCOUNT ON;
        INSERT INTO tbl_users(
                              username,
                              Email,
                              [Password],
                              [role],
                              reg_date) 
                              VALUES(
                              @username,
                              @email,
                              CONVERT(VARCHAR(32), HashBytes('MD5', @password), 2),
                              @role,
                              GETDATE())
        if(@@ROWCOUNT > 0)
        BEGIN
          SET @retval = 200 --return value when changes is detected on table
        END
        ELSE
        BEGIN
        SET @retval = 500  --return value if something went wronng
        END
  END