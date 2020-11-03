CREATE PROCEDURE [dbo].[spGetRoles]
AS
Begin
	SELECT Role from Master.Roles
End
RETURN 0