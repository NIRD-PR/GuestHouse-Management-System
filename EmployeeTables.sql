USE [Sample Database]
GO
/****** Object:  Table [dbo].[PR_tbl_Employee]    Script Date: 24-11-2020 15:44:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PR_tbl_Employee](
	[EID] [int] IDENTITY(1,1) NOT NULL,
	[OID] [int] NULL,
	[ETID] [int] NULL,
	[EmpType] [varchar](max) NULL,
	[ECID] [int] NULL,
	[EmpCategory] [varchar](max) NULL,
	[EGID] [int] NULL,
	[EmpGroup] [varchar](max) NULL,
	[DID] [int] NULL,
	[DeptID] [varchar](max) NULL,
	[DSID] [int] NULL,
	[Design] [varchar](max) NULL,
	[EmpID] [int] NOT NULL,
	[Name] [varchar](max) NULL,
	[FathersName] [varchar](max) NULL,
	[Email] [varchar](max) NULL,
	[Password] [varchar](max) NULL,
	[Mobile] [decimal](10, 0) NULL,
	[Aadhar] [varchar](50) NULL,
	[DOB] [datetime] NULL,
	[DOJ] [datetime] NULL,
	[Gender] [varchar](50) NULL,
	[PAN] [varchar](50) NOT NULL,
	[BankAcType] [varchar](max) NULL,
	[BankName] [varchar](max) NULL,
	[BankBranch] [varchar](max) NULL,
	[BankAccNo] [decimal](18, 0) NOT NULL,
	[IFSCCode] [varchar](max) NULL,
	[Address] [varchar](max) NULL,
	[State] [varchar](max) NULL,
	[Photo] [varchar](max) NULL,
	[Role] [int] NULL,
	[Status] [varchar](50) NULL,
	[UID] [int] NULL,
	[UName] [varchar](max) NULL,
	[Dated] [datetime] NULL,
	[ISHOC] [varchar](50) NULL,
	[OTP] [varchar](50) NULL,
	[Block] [varchar](max) NULL,
	[Floor] [varchar](max) NULL,
	[Intercom] [varchar](max) NULL,
	[RoomNo] [varchar](max) NULL,
 CONSTRAINT [PK_PR_tbl_Employee] PRIMARY KEY CLUSTERED 
(
	[EID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PR_tbl_ProjectStaff]    Script Date: 24-11-2020 15:44:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PR_tbl_ProjectStaff](
	[PSTID] [int] IDENTITY(1,1) NOT NULL,
	[SNo] [int] NOT NULL,
	[OID] [int] NULL,
	[ETID] [int] NULL,
	[ECID] [int] NULL,
	[EGID] [int] NULL,
	[EmpGroup] [varchar](max) NULL,
	[PSID] [int] NULL,
	[PayScale] [varchar](max) NULL,
	[DID] [int] NULL,
	[DeptID] [varchar](max) NULL,
	[DSID] [int] NULL,
	[Design] [varchar](max) NULL,
	[AttendanceID] [decimal](18, 0) NULL,
	[EmpID] [decimal](18, 0) NULL,
	[Name] [varchar](max) NULL,
	[Password] [varchar](max) NULL,
	[Email] [varchar](max) NULL,
	[Mobile] [decimal](10, 0) NULL,
	[Aadhar] [varchar](50) NULL,
	[DOJ] [datetime] NULL,
	[DOR] [datetime] NULL,
	[Gender] [varchar](50) NULL,
	[PAN] [varchar](50) NULL,
	[BankAcType] [varchar](max) NULL,
	[BankName] [varchar](max) NULL,
	[BankBranch] [varchar](max) NULL,
	[BankAccNo] [varchar](50) NULL,
	[IFSCCode] [varchar](max) NULL,
	[Photo] [varchar](max) NULL,
	[PTID] [int] NULL,
	[ProjectCode] [varchar](max) NULL,
	[ProjectTitle] [varchar](max) NULL,
	[ProjectCoordinator] [varchar](max) NULL,
	[HEmpID] [int] NULL,
	[CentreHead] [varchar](max) NULL,
	[DOB] [datetime] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[BasicPay] [decimal](18, 0) NULL,
	[GrossSal] [decimal](18, 0) NULL,
	[QuarterAllotted] [varchar](max) NULL,
	[QuarterType] [varchar](max) NULL,
	[QuarterNo] [varchar](max) NULL,
	[OfficeOrderNo] [varchar](max) NULL,
	[OfficeOrderDate] [datetime] NULL,
	[OOIssuingAuthority] [varchar](max) NULL,
	[Role] [int] NULL,
	[Status] [varchar](50) NULL,
	[UID] [int] NULL,
	[UName] [varchar](max) NULL,
	[Dated] [datetime] NULL,
	[FDOJ] [datetime] NULL,
	[EDate] [datetime] NULL,
	[CitizenType] [varchar](max) NULL,
	[AppointmentOrder] [varchar](max) NULL,
	[ISHOC] [varchar](50) NULL,
	[OTP] [varchar](50) NULL,
	[Block] [varchar](50) NULL,
	[Floor] [varchar](50) NULL,
	[Intercom] [varchar](50) NULL,
	[RoomNo] [varchar](50) NULL,
	[Flag1] [int] NULL,
	[Flag2] [int] NULL,
	[IsIncharge] [varchar](50) NULL,
	[bIsSrvHstrFilled] [bit] NULL,
 CONSTRAINT [PK_PR_tbl_ProjectStaff] PRIMARY KEY CLUSTERED 
(
	[PSTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[PR_tbl_ProjectStaff] ADD  DEFAULT ((0)) FOR [bIsSrvHstrFilled]
GO
