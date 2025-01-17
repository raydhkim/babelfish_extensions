CREATE LOGIN babel_4206_vu_prepare_login1 WITH PASSWORD = 'abc';
GO

CREATE LOGIN babel_4206_vu_prepare_login2 WITH PASSWORD = 'abc';
GO

CREATE USER babel_4206_vu_prepare_user1 FOR LOGIN babel_4206_vu_prepare_login1;
GO

CREATE USER babel_4206_vu_prepare_user2 FOR LOGIN babel_4206_vu_prepare_login2;
GO

CREATE ROLE babel_4206_vu_prepare_role1;
GO

CREATE ROLE babel_4206_vu_prepare_role2;
GO

ALTER ROLE babel_4206_vu_prepare_role1 ADD MEMBER babel_4206_vu_prepare_role2;
GO

ALTER ROLE babel_4206_vu_prepare_role1 ADD MEMBER babel_4206_vu_prepare_user1;
GO

ALTER ROLE babel_4206_vu_prepare_role2 ADD MEMBER babel_4206_vu_prepare_user2;
GO

CREATE PROC babel_4206_vu_prepare_user_ext AS
BEGIN 
	SELECT rolname, login_name, type, orig_username, database_name
	FROM sys.babelfish_authid_user_ext
	WHERE orig_username LIKE 'babel_4206_vu_prepare%'
	ORDER BY rolname, orig_username
END
GO

CREATE PROC babel_4206_vu_prepare_role_members AS
BEGIN
	SELECT dp1.name AS RoleName, dp1.type AS RoleType,
		   dp2.name AS MemberName, dp2.type AS MemberType
	FROM sys.database_role_members AS drm
	INNER JOIN sys.database_principals AS dp1
	ON drm.role_principal_id = dp1.principal_id
	INNER JOIN sys.database_principals AS dp2
	ON drm.member_principal_id = dp2.principal_id
	WHERE dp1.name LIKE 'babel_4206_vu_prepare%'
	ORDER BY dp1.name, dp2.name
END
GO

-- show roles and users
EXEC babel_4206_vu_prepare_user_ext;
GO

-- show role membership
EXEC babel_4206_vu_prepare_role_members;
GO
