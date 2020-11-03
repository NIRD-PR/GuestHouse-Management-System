CREATE PROCEDURE [dbo].[spBookingDetailsCRUD]
	(
	@Action nvarchar(10),
	@AssignRoomID int,
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@PhoneNo nvarchar(10) ,
	@Members int,
	@BookingFrom datetime,
	@BookingTo datetime,
	@Address nvarchar(200),
	@Amount int=null,
	@BookingTypeID int,
	@trName nvarchar(50)=null,
	@trDirector nvarchar(50)=null,
	@trFrom datetime=null,
	@trTo datetime=null,
	@purpVis nvarchar(100)=null,
	@visWh nvarchar(50)=null,
	@cenVis nvarchar(50)=null
)
AS
BEGIN
	SET NOCOUNT ON;

	IF @Action = 'INSERT'
	BEGIN
		INSERT INTO dbo.Bookings
		(
			FirstName,
			LastName,
			Address,
			BookingFrom,
			BookingTo,
			AssignRoomID,
			NoOfMembers,
			PhoneNo,
			BookingTypeID,
			TrainingName,
			TrainingDirector,
			TrainingFrom,
			TrainingTo,
			PurposeOfVisit,
			VisitingWhom,
			CenterVisiting
		)
		VALUES
		(
			@FirstName,
			@LastName,
			@Address,
			@BookingFrom,
			@BookingTo,
			@AssignRoomID,
			@Members,
			@PhoneNo,
			@BookingTypeID,
			@trName,
			@trDirector,
			@trFrom,
			@trTo,
			@purpVis,
			@visWh,
			@cenVis
		)
		UPDATE dbo.Rooms
		SET BookingStatusID=2
		WHERE RoomID=@AssignRoomID
		DECLARE @TotDays INT= DATEDIFF(DAY, @BookingFrom, @BookingTo) ;
		UPDATE dbo.Bookings
		SET TotalAmount=@TotDays*T.Rate 
		FROM
		dbo.Bookings B inner join dbo.Rooms R on R.RoomID=@AssignRoomID inner join Master.RoomType T on R.RoomTypeID=T.RoomTypeID
		WHERE B.AssignRoomID=@AssignRoomID

	END
END

RETURN 0