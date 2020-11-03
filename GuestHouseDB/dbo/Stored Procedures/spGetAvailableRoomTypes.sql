CREATE PROCEDURE [dbo].[spGetAvailableRoomTypes]
	@GuestHouseID int=null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT DISTINCT R.RoomTypeID,T.RoomType from dbo.Rooms R inner join Master.RoomType T on R.RoomTypeID=T.RoomTypeID 
	WHERE R.GuestHouseID=@GuestHouseID AND  R.BookingStatusID=1 AND R.IsActive=1
END
RETURN 0