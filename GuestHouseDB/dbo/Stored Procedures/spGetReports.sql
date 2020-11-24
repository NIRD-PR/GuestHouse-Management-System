CREATE PROCEDURE [dbo].[spGetReports]
	
AS
	select count(*) as Available from dbo.Rooms R inner join Master.RoomType T  on R.RoomTypeID=T.RoomTypeID where R.IsActive=1 and R.BookingStatusID=1
	select count(*) as Blocked from dbo.Rooms R inner join Master.RoomType T  on R.RoomTypeID=T.RoomTypeID where R.IsActive=0 
	select sum(NoOfMembers) as InHouse from dbo.Bookings where BookingTo>=GETDATE()and BookingFrom<=GETDATE()
	select sum(TotalAmount) as Revenue from dbo.Bookings where BookingFrom >=dateadd(day,datediff(day,0,GetDate())- 30,0) and BookingTo<=GETDATE()
RETURN 0