select BookingFrom, sum(NoOfMembers)  over ( Order by GETDATE()  rows between 2 preceding and current row)
from dbo.Bookings
WHERE BookingFrom >=dateadd(day,datediff(day,0,GetDate())- 7,0) AND BookingTo <=dateadd(day,datediff(day,0,GetDate())+ 11,0)
GROUP BY BookingFrom,NoOfMembers,BookingTo

SELECT GETDATE()

select T.RoomType,count(T.RoomType)as Available from dbo.Rooms R inner join Master.RoomType T  on R.RoomTypeID=T.RoomTypeID where R.IsActive=1 and R.BookingStatusID=1 group by T.RoomType 

select BookingID from dbo.Bookings where BookingTo>=GETDATE()

SELECT ( B.FirstName +' '+ B.LastName) AS Name,G.Name AS GuestHouse ,R.RoomNumber,T.BookingType, B.NoOfMembers, B.BookingFrom,B.BookingTo,B.PhoneNo,B.TotalAmount FROM dbo.Bookings B inner join Master.BookingType T on B.BookingTypeID=T.BookingTypeId inner join dbo.Rooms R on R.RoomID=B.AssignRoomID inner join Master.GuestHouseIndex G on G.GuestHouseID=R.GuestHouseID where  B.BookingTo>=GETDATE() and B.isActive=1