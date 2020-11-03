CREATE TABLE [dbo].[Registration]
(
	[ID] NVARCHAR(50) NOT NULL , 
    [FirstName] NVARCHAR(50) NOT NULL, 
    [LastName] NVARCHAR(50) NULL, 
    [Email] VARCHAR(50) NOT NULL, 
    [MobileNo] NVARCHAR(50) NOT NULL, 
    [Password] NVARCHAR(50) NOT NULL, 
    PRIMARY KEY ([Email])
)
