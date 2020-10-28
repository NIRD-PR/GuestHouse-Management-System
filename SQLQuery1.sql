select BookingFrom, sum(NoOfMembers)  over ( Order by GETDATE()  rows between 2 preceding and current row)
from dbo.Bookings
WHERE BookingFrom >=dateadd(day,datediff(day,0,GetDate())- 7,0) AND BookingTo <=dateadd(day,datediff(day,0,GetDate())+ 11,0)
GROUP BY BookingFrom,NoOfMembers,BookingTo

SELECT GETDATE()