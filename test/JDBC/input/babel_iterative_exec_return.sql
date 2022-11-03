-- basic return 
CREATE PROCEDURE my_test1 AS
BEGIN
	DECLARE @a INT
	SET @a = 1
	SELECT @a
	RETURN
	SELECT @a + 1
END
GO

-- return from loop
CREATE PROCEDURE my_test2 AS
BEGIN
	DECLARE @a INT
	SET @a = 1
	WHILE ( @a < 3 )
	BEGIN
		SELECT @a
		RETURN
		SET @a = @a + 1
	END
END
GO

-- return from try-catch
CREATE PROCEDURE my_test3 AS
BEGIN
	BEGIN TRY
		RETURN
	END TRY
	BEGIN CATCH
	END CATCH
	SELECT 'end'
END
GO

CREATE PROCEDURE my_test4 AS
BEGIN
	BEGIN TRY
		SELECT 1/0
	END TRY
	BEGIN CATCH
		RETURN
	END CATCH
	SELECT 'end'
END
GO

CREATE PROCEDURE my_test5 AS
BEGIN
	BEGIN TRY
		BEGIN TRY
			RETURN
		END TRY
		BEGIN CATCH
		END CATCH
		SELECT 'end1'
	END TRY
	BEGIN CATCH
	END CATCH
	SELECT 'end2'
END
GO

CREATE PROCEDURE my_test6 AS
BEGIN
	BEGIN TRY
		SELECT 1/0
	END TRY
	BEGIN CATCH
		BEGIN TRY
			RETURN
		END TRY
		BEGIN CATCH
		END CATCH
		SELECT 'end1'
	END CATCH
	SELECT 'end2'
END
GO

CREATE PROCEDURE my_test7 AS
BEGIN
	BEGIN TRY
		BEGIN TRY
			SELECT 1/0
		END TRY
		BEGIN CATCH
			RETURN
		END CATCH
		SELECT 'end1'
	END TRY
	BEGIN CATCH
	END CATCH
	SELECT 'end2'
END
GO

CREATE PROCEDURE my_test8 AS
BEGIN
	BEGIN TRY
		SELECT 1/0
	END TRY
	BEGIN CATCH
		BEGIN TRY
			SELECT 1/0
		END TRY
		BEGIN CATCH
			RETURN
		END CATCH
		SELECT 'end1'
	END CATCH
	SELECT 'end2'
END
GO

EXEC my_test1
GO

EXEC my_test2
GO

EXEC my_test3
GO

EXEC my_test4
GO

EXEC my_test5
GO

EXEC my_test6
GO

EXEC my_test7
GO

EXEC my_test8
GO

DROP PROCEDURE my_test1;
GO

DROP PROCEDURE my_test2;
GO

DROP PROCEDURE my_test3;
GO

DROP PROCEDURE my_test4;
GO

DROP PROCEDURE my_test5;
GO

DROP PROCEDURE my_test6;
GO

DROP PROCEDURE my_test7;
GO

DROP PROCEDURE my_test8;
GO