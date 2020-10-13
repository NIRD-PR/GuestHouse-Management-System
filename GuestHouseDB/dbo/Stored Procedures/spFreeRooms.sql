CREATE  PROCEDURE spFreeRooms
AS
BEGIN
	UPDATE dbo.Rooms
	SET BookingStatusID=1
	FROM
		dbo.Rooms R inner join dbo.Bookings B on R.RoomID=B.AssignRoomID 
	WHERE (DATEDIFF(DAY,  DATEADD(day, -1, B.BookingTo), GETDATE())) >= 1
END