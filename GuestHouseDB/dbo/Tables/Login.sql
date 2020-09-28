CREATE TABLE [dbo].[Login] (
    [ID]            NVARCHAR (50) NOT NULL,
    [FirstName]     NVARCHAR (50) NOT NULL,
    [LastName]      NVARCHAR (50) NULL,
    [Email]         VARCHAR (50)  NOT NULL,
    [MobileNo]      NVARCHAR (50) NOT NULL,
    [Password]      NVARCHAR (50) NOT NULL,
    [PrimaryRole]   NVARCHAR (50) NOT NULL,
    [SecondaryRole] NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Email] ASC)
);


