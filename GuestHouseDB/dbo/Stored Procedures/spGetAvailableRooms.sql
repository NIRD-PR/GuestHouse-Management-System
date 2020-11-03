CREATE PROCEDURE [dbo].[spGetAvailableRooms]	
@GuestHouseID int,
@RoomTypeID int 

AS
BEGIN
	SELECT R.RoomNumber,R.RoomID from dbo.Rooms R where R.RoomTypeID=@RoomTypeID AND R.GuestHouseID=@GuestHouseID AND R.BookingStatusID=1 AND R.IsActive=1
END
RETURN 0