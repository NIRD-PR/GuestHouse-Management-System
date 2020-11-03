CREATE PROCEDURE [dbo].[spGetBookingType]
AS
BEGIN
	SELECT BookingType,BookingTypeId from Master.BookingType
END
RETURN 0