USE [master]
GO
/****** Object:  Database [CS6232-g4]    Script Date: 4/6/2019 2:16:17 PM ******/
CREATE DATABASE [CS6232-g4]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'clinic', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\clinic.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'clinic_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\clinic_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [CS6232-g4] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CS6232-g4].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CS6232-g4] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CS6232-g4] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CS6232-g4] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CS6232-g4] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CS6232-g4] SET ARITHABORT OFF 
GO
ALTER DATABASE [CS6232-g4] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CS6232-g4] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CS6232-g4] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CS6232-g4] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CS6232-g4] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CS6232-g4] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CS6232-g4] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CS6232-g4] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CS6232-g4] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CS6232-g4] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CS6232-g4] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CS6232-g4] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CS6232-g4] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CS6232-g4] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CS6232-g4] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CS6232-g4] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CS6232-g4] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CS6232-g4] SET RECOVERY FULL 
GO
ALTER DATABASE [CS6232-g4] SET  MULTI_USER 
GO
ALTER DATABASE [CS6232-g4] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CS6232-g4] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CS6232-g4] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CS6232-g4] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CS6232-g4] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CS6232-g4] SET QUERY_STORE = OFF
GO
USE [CS6232-g4]
GO
/****** Object:  Table [dbo].[Address]    Script Date: 4/6/2019 2:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[state] [varchar](40) NOT NULL,
	[zip] [varchar](40) NOT NULL,
	[street] [varchar](40) NULL,
	[addressID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[addressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Administrator]    Script Date: 4/6/2019 2:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Administrator](
	[adminID] [int] IDENTITY(1,1) NOT NULL,
	[fname] [varchar](40) NULL,
	[lname] [varchar](40) NULL,
	[dob] [date] NULL,
	[ssn] [int] NOT NULL,
	[gender] [varchar](40) NULL,
	[phone] [varchar](10) NULL,
	[adminUsername] [varchar](10) NOT NULL,
	[addressID] [int] NOT NULL,
 CONSTRAINT [PK_Administrator] PRIMARY KEY CLUSTERED 
(
	[adminID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Administrator] UNIQUE NONCLUSTERED 
(
	[adminUsername] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doctor]    Script Date: 4/6/2019 2:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctor](
	[doctorID] [int] IDENTITY(1,1) NOT NULL,
	[fname] [varchar](40) NULL,
	[lname] [varchar](40) NULL,
	[dob] [date] NULL,
	[ssn] [int] NOT NULL,
	[gender] [varchar](40) NULL,
	[phone] [varchar](10) NULL,
	[doctorUsername] [varchar](10) NOT NULL,
	[addressID] [int] NOT NULL,
 CONSTRAINT [PK_Doctor] PRIMARY KEY CLUSTERED 
(
	[doctorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Doctor] UNIQUE NONCLUSTERED 
(
	[doctorUsername] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HasAppointment]    Script Date: 4/6/2019 2:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HasAppointment](
	[appointmentID] [int] IDENTITY(1,1) NOT NULL,
	[doctorID] [int] NOT NULL,
	[patientID] [int] NOT NULL,
	[appointmentDateTime] [datetime] NOT NULL,
	[reasons] [varchar](120) NOT NULL,
 CONSTRAINT [PK_HasAppointment] PRIMARY KEY CLUSTERED 
(
	[appointmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LabTestList]    Script Date: 4/6/2019 2:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LabTestList](
	[testID] [int] IDENTITY(1,1) NOT NULL,
	[testName] [varchar](40) NOT NULL,
 CONSTRAINT [PK_LabTestList] PRIMARY KEY CLUSTERED 
(
	[testID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LabTestResult]    Script Date: 4/6/2019 2:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LabTestResult](
	[labTestResultID] [int] IDENTITY(1,1) NOT NULL,
	[testID] [int] NOT NULL,
	[visitID] [int] NOT NULL,
	[testResult] [varchar](40) NULL,
	[testDate] [datetime] NULL,
 CONSTRAINT [PK_LabTestResult] PRIMARY KEY CLUSTERED 
(
	[labTestResultID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Login]    Script Date: 4/6/2019 2:16:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Login](
	[username] [varchar](10) NOT NULL,
	[password] [varbinary](128) NOT NULL,
 CONSTRAINT [PK_Login] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nurse]    Script Date: 4/6/2019 2:16:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nurse](
	[nurseID] [int] IDENTITY(1,1) NOT NULL,
	[fname] [varchar](40) NULL,
	[lname] [varchar](40) NULL,
	[dob] [date] NULL,
	[ssn] [int] NOT NULL,
	[gender] [varchar](40) NULL,
	[phone] [varchar](10) NULL,
	[nurseUsername] [varchar](10) NOT NULL,
	[addressID] [int] NOT NULL,
	[Active_status] [nchar](10) NULL,
 CONSTRAINT [PK_Nurse] PRIMARY KEY CLUSTERED 
(
	[nurseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Nurse] UNIQUE NONCLUSTERED 
(
	[nurseUsername] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Nurse_ssn] UNIQUE NONCLUSTERED 
(
	[ssn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patient]    Script Date: 4/6/2019 2:16:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patient](
	[patientID] [int] IDENTITY(1,1) NOT NULL,
	[fname] [varchar](40) NULL,
	[lname] [varchar](40) NULL,
	[dob] [date] NULL,
	[ssn] [int] NOT NULL,
	[gender] [varchar](40) NULL,
	[phone] [varchar](10) NULL,
	[addressID] [int] NOT NULL,
 CONSTRAINT [PK_Patient] PRIMARY KEY CLUSTERED 
(
	[patientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PatientVisit]    Script Date: 4/6/2019 2:16:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientVisit](
	[visitID] [int] IDENTITY(1,1) NOT NULL,
	[appointmentID] [int] NOT NULL,
	[nurseID] [int] NOT NULL,
	[visitDateTime] [datetime] NOT NULL,
	[diagnosis] [varchar](120) NULL,
	[weight] [decimal](18, 0) NOT NULL,
	[systolic] [int] NOT NULL,
	[diastolic] [int] NOT NULL,
	[temperature] [decimal](18, 0) NOT NULL,
	[pulse] [int] NOT NULL,
	[symptoms] [varchar](40) NOT NULL,
 CONSTRAINT [PK_PatientVisit] PRIMARY KEY CLUSTERED 
(
	[visitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Specialty]    Script Date: 4/6/2019 2:16:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Specialty](
	[doctorID] [int] NOT NULL,
	[specialityName] [varchar](40) NOT NULL,
 CONSTRAINT [PK_Specialities] PRIMARY KEY CLUSTERED 
(
	[doctorID] ASC,
	[specialityName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_Administrator_ssn]    Script Date: 4/6/2019 2:16:18 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Administrator_ssn] ON [dbo].[Administrator]
(
	[ssn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Doctor_ssn]    Script Date: 4/6/2019 2:16:18 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Doctor_ssn] ON [dbo].[Doctor]
(
	[ssn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_HasAppointment_Doctor_time_UQ]    Script Date: 4/6/2019 2:16:18 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_HasAppointment_Doctor_time_UQ] ON [dbo].[HasAppointment]
(
	[appointmentID] ASC,
	[doctorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Patient_ssn]    Script Date: 4/6/2019 2:16:18 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Patient_ssn] ON [dbo].[Patient]
(
	[ssn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Administrator]  WITH CHECK ADD  CONSTRAINT [FK_Administrator_Address] FOREIGN KEY([addressID])
REFERENCES [dbo].[Address] ([addressID])
GO
ALTER TABLE [dbo].[Administrator] CHECK CONSTRAINT [FK_Administrator_Address]
GO
ALTER TABLE [dbo].[Administrator]  WITH CHECK ADD  CONSTRAINT [FK_Administrator_Login] FOREIGN KEY([adminUsername])
REFERENCES [dbo].[Login] ([username])
GO
ALTER TABLE [dbo].[Administrator] CHECK CONSTRAINT [FK_Administrator_Login]
GO
ALTER TABLE [dbo].[Doctor]  WITH CHECK ADD  CONSTRAINT [FK_Doctor_Address] FOREIGN KEY([addressID])
REFERENCES [dbo].[Address] ([addressID])
GO
ALTER TABLE [dbo].[Doctor] CHECK CONSTRAINT [FK_Doctor_Address]
GO
ALTER TABLE [dbo].[Doctor]  WITH CHECK ADD  CONSTRAINT [FK_Doctor_Login] FOREIGN KEY([doctorUsername])
REFERENCES [dbo].[Login] ([username])
GO
ALTER TABLE [dbo].[Doctor] CHECK CONSTRAINT [FK_Doctor_Login]
GO
ALTER TABLE [dbo].[HasAppointment]  WITH CHECK ADD  CONSTRAINT [FK_HasAppointment_Doctor] FOREIGN KEY([doctorID])
REFERENCES [dbo].[Doctor] ([doctorID])
GO
ALTER TABLE [dbo].[HasAppointment] CHECK CONSTRAINT [FK_HasAppointment_Doctor]
GO
ALTER TABLE [dbo].[HasAppointment]  WITH CHECK ADD  CONSTRAINT [FK_HasAppointment_Patient] FOREIGN KEY([patientID])
REFERENCES [dbo].[Patient] ([patientID])
GO
ALTER TABLE [dbo].[HasAppointment] CHECK CONSTRAINT [FK_HasAppointment_Patient]
GO
ALTER TABLE [dbo].[LabTestResult]  WITH CHECK ADD  CONSTRAINT [FK_LabTestResult_LabTestList] FOREIGN KEY([testID])
REFERENCES [dbo].[LabTestList] ([testID])
GO
ALTER TABLE [dbo].[LabTestResult] CHECK CONSTRAINT [FK_LabTestResult_LabTestList]
GO
ALTER TABLE [dbo].[LabTestResult]  WITH CHECK ADD  CONSTRAINT [FK_LabTestResult_PatientVisit] FOREIGN KEY([visitID])
REFERENCES [dbo].[PatientVisit] ([visitID])
GO
ALTER TABLE [dbo].[LabTestResult] CHECK CONSTRAINT [FK_LabTestResult_PatientVisit]
GO
ALTER TABLE [dbo].[Nurse]  WITH CHECK ADD  CONSTRAINT [FK_Nurse_Address] FOREIGN KEY([addressID])
REFERENCES [dbo].[Address] ([addressID])
GO
ALTER TABLE [dbo].[Nurse] CHECK CONSTRAINT [FK_Nurse_Address]
GO
ALTER TABLE [dbo].[Nurse]  WITH CHECK ADD  CONSTRAINT [FK_Nurse_Login] FOREIGN KEY([nurseUsername])
REFERENCES [dbo].[Login] ([username])
GO
ALTER TABLE [dbo].[Nurse] CHECK CONSTRAINT [FK_Nurse_Login]
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD  CONSTRAINT [FK_Patient_Address] FOREIGN KEY([addressID])
REFERENCES [dbo].[Address] ([addressID])
GO
ALTER TABLE [dbo].[Patient] CHECK CONSTRAINT [FK_Patient_Address]
GO
ALTER TABLE [dbo].[PatientVisit]  WITH CHECK ADD  CONSTRAINT [FK_PatientVisit_HasAppointment] FOREIGN KEY([appointmentID])
REFERENCES [dbo].[HasAppointment] ([appointmentID])
GO
ALTER TABLE [dbo].[PatientVisit] CHECK CONSTRAINT [FK_PatientVisit_HasAppointment]
GO
ALTER TABLE [dbo].[PatientVisit]  WITH CHECK ADD  CONSTRAINT [FK_PatientVisit_Nurse] FOREIGN KEY([nurseID])
REFERENCES [dbo].[Nurse] ([nurseID])
GO
ALTER TABLE [dbo].[PatientVisit] CHECK CONSTRAINT [FK_PatientVisit_Nurse]
GO
ALTER TABLE [dbo].[Specialty]  WITH CHECK ADD  CONSTRAINT [FK_Specialities_Doctor] FOREIGN KEY([doctorID])
REFERENCES [dbo].[Doctor] ([doctorID])
GO
ALTER TABLE [dbo].[Specialty] CHECK CONSTRAINT [FK_Specialities_Doctor]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Username must be presnet in login and will appear as forkeign key in administrator' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Administrator', @level2type=N'CONSTRAINT',@level2name=N'FK_Administrator_Login'
GO
USE [master]
GO
ALTER DATABASE [CS6232-g4] SET  READ_WRITE 
GO
