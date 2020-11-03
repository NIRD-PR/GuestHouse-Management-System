CREATE PROCEDURE [dbo].[spGetGuestHouse]
AS
Begin
	SELECT GuestHouseID,Name from Master.GuestHouseIndex
End
RETURN 0