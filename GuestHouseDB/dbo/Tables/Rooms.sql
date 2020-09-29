CREATE TABLE [dbo].[Rooms] (
    [RoomID]          INT            IDENTITY (1, 1) NOT NULL,
    [RoomNumber]      NVARCHAR (8)   NOT NULL,
    [RoomImage]       NVARCHAR (550) NULL,
    [BookingStatusID] INT            NOT NULL,
    [RoomTypeID]      INT            NOT NULL,
    [RoomCapacity]    INT            NOT NULL,
    [RoomDescription] NVARCHAR (550) NULL,
    [IsActive]        BIT            DEFAULT ((1)) NOT NULL,
    [GuestHouseID]    INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([RoomID] ASC),
    CONSTRAINT [FK_Rooms_BookingStatus] FOREIGN KEY ([BookingStatusID]) REFERENCES [Master].[BookingStatus] ([BookingStatusID]),
    CONSTRAINT [FK_Rooms_GuestHouseIndex] FOREIGN KEY ([GuestHouseID]) REFERENCES [Master].[GuestHouseIndex] ([GuestHouseID]),
    CONSTRAINT [FK_Rooms_RoomType] FOREIGN KEY ([RoomTypeID]) REFERENCES [Master].[RoomType] ([RoomTypeID])
);



