CREATE TABLE [dbo].[Bookings] (
    [BookingID]    INT             IDENTITY (1, 1) NOT NULL,
    [FirstName]    NVARCHAR (50)   NOT NULL,
    [LastName]     NVARCHAR (50)   NOT NULL,
    [Address]      NVARCHAR (200)  NOT NULL,
    [BookingFrom]  DATETIME        NOT NULL,
    [BookingTo]    DATETIME        NOT NULL,
    [AssignRoomID] INT             NOT NULL,
    [NoOfMembers]  INT             NULL,
    [PhoneNo]      NVARCHAR (10)   NOT NULL,
    [TotalAmount]  DECIMAL (18, 2) DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([BookingID] ASC)
);







