CREATE PROCEDURE [dbo].[spLogin]
	@Email varchar(50),
	@password nvarchar(50)
AS
BEGIN
	SELECT * 
	FROM dbo.Login
	WHERE Email=@Email AND Password=@password
END
RETURN 0