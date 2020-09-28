CREATE PROCEDURE [dbo].[spEditManagement]
(
	@Action nvarchar(50),
	@Email varchar(50) =null,
	@PrimaryRole nvarchar(50)=null,
	@SecondaryRole nvarchar(50)=null
)
AS
BEGIN
	SET NOCOUNT ON;

	--EDIT
	IF @Action = 'EDIT'
	BEGIN;
		UPDATE dbo.Login
		SET
			PrimaryRole = @PrimaryRole,
			SecondaryRole = @SecondaryRole
		WHERE Email=@Email;

		DELETE FROM dbo.Registration
		WHERE Email=@Email;

	END
	
	--DELETE
	IF @Action = 'DELETE'
	BEGIN
		DELETE FROM dbo.Login
		WHERE Email=@Email;
	END

END
RETURN 0
