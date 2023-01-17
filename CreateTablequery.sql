use TrainingDB2

GO
 SET ANSI_NULLS ON
 GO
 SET QUOTED_IDENTIFIER ON
 GO
 CREATE TABLE [dbo].[tbl_users](
     [userid] [int] IDENTITY(1,1) NOT NULL,
     [username] nvarchar(100) NULL,
     [password] nvarchar(100) NULL,
     [email] nvarchar(100) NULL,
     [role] nvarchar(100) NULL,
     [reg_date] [datetime] NULL
 ) ON [PRIMARY]
 GO