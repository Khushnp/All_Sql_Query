USE [TrainingDB2]
GO
/****** Object:  StoredProcedure [dbo].[sp_deleteUser]    Script Date: 17-01-2023 11:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  -- =============================================
  -- Author:        FeeCode Spot
  -- Create date: 
  -- Description:    
  -- =============================================
  create PROCEDURE [dbo].[sp_deleteUser]
      @userid int,
      @retval int OUTPUT
  AS
  BEGIN
      SET NOCOUNT ON;
           Delete tbl_users where userid = @userid
        
           if(@@ROWCOUNT > 0)
        BEGIN
          SET @retval = 200 --return value when changes is detected on table
        END
        ELSE
        BEGIN
        SET @retval = 500  --return value if something went wronng
        END
  END 