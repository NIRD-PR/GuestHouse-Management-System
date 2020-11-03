CREATE PROCEDURE [dbo].[spGetRoomType]
AS
Begin
	SELECT RoomType,RoomTypeID from Master.RoomType
End
RETURN 0