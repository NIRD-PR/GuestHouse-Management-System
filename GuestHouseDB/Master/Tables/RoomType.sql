CREATE TABLE [Master].[RoomType] (
    [RoomTypeID] INT             IDENTITY (1, 1) NOT NULL,
    [RoomType]   NVARCHAR (20)   NOT NULL,
    [Rate]       DECIMAL (18, 2) NULL,
    CONSTRAINT [PK_RoomType] PRIMARY KEY CLUSTERED ([RoomTypeID] ASC)
);



