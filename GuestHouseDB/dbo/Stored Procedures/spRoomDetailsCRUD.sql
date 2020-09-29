CREATE PROCEDURE [dbo].[spRoomDetailsCRUD]
(
	@Action nvarchar(10),
	@RoomID int =null,
	@RoomNumber nvarchar(8)=null,
	@BookingStatusID int =null ,
	@RoomTypeID int=null,
	@RoomCapacity int=null,
	@RoomDescription nvarchar(550)=null,
	@GuestHouseID int=null
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @Action = 'SELECT'
	BEGIN
		SELECT R.RoomID,R.IsActive,G.Name,T.Rate,R.RoomNumber,R.RoomCapacity,B.BookingStatus,T.RoomType,R.RoomDescription from dbo.Rooms R join
		Master.BookingStatus B on B.BookingStatusID=R.BookingStatusID join Master.GuestHouseIndex G on G.GuestHouseID=R.GuestHouseID join
		Master.RoomType T on T.RoomTypeID=R.RoomTypeID
	END

	--INSERT
	IF @Action = 'INSERT'
	BEGIN
		INSERT INTO dbo.Rooms
		(
			RoomNumber ,
			BookingStatusID ,
			RoomTypeID ,
			RoomCapacity, 
			RoomDescription ,
			GuestHouseID 
		)
		VALUES
		(
			@RoomNumber ,
			1,
			@RoomTypeID ,
			@RoomCapacity ,
			@RoomDescription ,
			@GuestHouseID 
		)
	END

	IF @Action = 'UPDATE'
	BEGIN
		UPDATE dbo.Rooms	
		SET RoomNumber=@RoomNumber,
			BookingStatusID=@BookingStatusID,
			RoomTypeID=@RoomTypeID,
			RoomCapacity=@RoomCapacity,
			RoomDescription=@RoomDescription,
			GuestHouseID=@GuestHouseID
		WHERE RoomID=@RoomID
	END

	IF @Action = 'DELETE'
	BEGIN
		DELETE FROM dbo.Rooms
		WHERE RoomID=@RoomID
	END

	IF @Action = 'BLOCK'
	BEGIN
		UPDATE dbo.Rooms
		SET IsActive=IsActive^1
		WHERE RoomID=@RoomID
	END
END
RETURN 0