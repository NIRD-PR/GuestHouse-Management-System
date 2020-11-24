CREATE TABLE [dbo].[Bookings] (
    [BookingID]        INT             IDENTITY (1, 1) NOT NULL,
    [FirstName]        NVARCHAR (50)   NOT NULL,
    [LastName]         NVARCHAR (50)   NOT NULL,
    [Address]          NVARCHAR (200)  NOT NULL,
    [BookingFrom]      DATETIME        NOT NULL,
    [BookingTo]        DATETIME        NOT NULL,
    [AssignRoomID]     INT             NOT NULL,
    [NoOfMembers]      INT             NULL,
    [PhoneNo]          NVARCHAR (10)   NOT NULL,
    [TotalAmount]      DECIMAL (18, 2) DEFAULT ((0)) NOT NULL,
    [BookingTypeID]    INT             NOT NULL,
    [TrainingName]     NVARCHAR (50)   NULL,
    [TrainingDirector] NVARCHAR (50)   NULL,
    [TrainingFrom]     DATETIME        NULL,
    [TrainingTo]       DATETIME        NULL,
    [PurposeOfVisit]   NVARCHAR (100)  NULL,
    [VisitingWhom]     NVARCHAR (50)   NULL,
    [CenterVisiting]   NVARCHAR (50)   NULL,
    [isActive]         BIT             DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([BookingID] ASC),
    CONSTRAINT [FK_Bookings_BookingType] FOREIGN KEY ([BookingTypeID]) REFERENCES [Master].[BookingType] ([BookingTypeId])
);











