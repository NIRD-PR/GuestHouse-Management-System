CREATE PROCEDURE [dbo].[spGetBookingStatus]
	
AS
Begin
	SELECT BookingStatus,BookingStatusID from Master.BookingStatus 
End