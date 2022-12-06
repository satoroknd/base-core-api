USE [master]
GO
/****** Object:  Database [RigoRigoDB]    Script Date: 6/12/2022 1:52:12 p. m. ******/
CREATE DATABASE [RigoRigoDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RigoRigoDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\RigoRigoDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'RigoRigoDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\RigoRigoDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [RigoRigoDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RigoRigoDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RigoRigoDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RigoRigoDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RigoRigoDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RigoRigoDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RigoRigoDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [RigoRigoDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RigoRigoDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RigoRigoDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RigoRigoDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RigoRigoDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RigoRigoDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RigoRigoDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RigoRigoDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RigoRigoDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RigoRigoDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RigoRigoDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RigoRigoDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RigoRigoDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RigoRigoDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RigoRigoDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RigoRigoDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RigoRigoDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RigoRigoDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [RigoRigoDB] SET  MULTI_USER 
GO
ALTER DATABASE [RigoRigoDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RigoRigoDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RigoRigoDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RigoRigoDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [RigoRigoDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [RigoRigoDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [RigoRigoDB] SET QUERY_STORE = OFF
GO
USE [RigoRigoDB]
GO
/****** Object:  UserDefinedTableType [dbo].[OrderForSaveContract]    Script Date: 6/12/2022 1:52:12 p. m. ******/
CREATE TYPE [dbo].[OrderForSaveContract] AS TABLE(
	[ProductID] [int] NULL,
	[ProductCode] [varchar](150) NULL,
	[ProductDescription] [varchar](50) NULL,
	[Quantity] [int] NULL,
	[UnitValue] [int] NULL,
	[CustomerDNI] [varchar](150) NULL,
	[CustomerAddress] [varchar](150) NULL
)
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 6/12/2022 1:52:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[SubTotal] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 6/12/2022 1:52:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[Total] [decimal](18, 0) NOT NULL,
	[Notes] [varchar](250) NULL,
	[CustomerDNI] [varchar](150) NULL,
	[CustomerAddress] [varchar](150) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductPrices]    Script Date: 6/12/2022 1:52:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductPrices](
	[ProductPriceID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[UnitValue] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_ProductPrices] PRIMARY KEY CLUSTERED 
(
	[ProductPriceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 6/12/2022 1:52:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductCode] [varchar](50) NOT NULL,
	[ProductDescription] [varchar](150) NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [SubTotal]) VALUES (37, 17, 12, 1, CAST(715000 AS Decimal(18, 0)))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [SubTotal]) VALUES (38, 17, 13, 1, CAST(715000 AS Decimal(18, 0)))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [SubTotal]) VALUES (39, 17, 14, 1, CAST(715000 AS Decimal(18, 0)))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [SubTotal]) VALUES (40, 18, 12, 1, CAST(815000 AS Decimal(18, 0)))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [SubTotal]) VALUES (41, 18, 13, 1, CAST(815000 AS Decimal(18, 0)))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [SubTotal]) VALUES (42, 18, 14, 1, CAST(815000 AS Decimal(18, 0)))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [SubTotal]) VALUES (43, 18, 12, 2, CAST(815000 AS Decimal(18, 0)))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [SubTotal]) VALUES (44, 19, 14, 2, CAST(1140000 AS Decimal(18, 0)))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [SubTotal]) VALUES (45, 20, 12, 1, CAST(50000 AS Decimal(18, 0)))
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 
GO
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [Total], [Notes], [CustomerDNI], [CustomerAddress]) VALUES (17, CAST(N'2022-12-05T16:57:43.417' AS DateTime), CAST(715000 AS Decimal(18, 0)), NULL, N'1028546874', N'Av Viva Springfield')
GO
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [Total], [Notes], [CustomerDNI], [CustomerAddress]) VALUES (18, CAST(N'2022-12-05T16:58:47.953' AS DateTime), CAST(815000 AS Decimal(18, 0)), NULL, N'1028546874', N'Cll 55 55 55')
GO
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [Total], [Notes], [CustomerDNI], [CustomerAddress]) VALUES (19, CAST(N'2022-12-05T17:04:27.840' AS DateTime), CAST(1140000 AS Decimal(18, 0)), NULL, N'1658546874', N'Av Groot')
GO
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [Total], [Notes], [CustomerDNI], [CustomerAddress]) VALUES (20, CAST(N'2022-12-05T17:43:37.783' AS DateTime), CAST(50000 AS Decimal(18, 0)), NULL, N'1111', N'1111')
GO
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductPrices] ON 
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [ProductID], [UnitValue]) VALUES (12, 12, CAST(50000 AS Decimal(18, 0)))
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [ProductID], [UnitValue]) VALUES (13, 13, CAST(95000 AS Decimal(18, 0)))
GO
INSERT [dbo].[ProductPrices] ([ProductPriceID], [ProductID], [UnitValue]) VALUES (14, 14, CAST(570000 AS Decimal(18, 0)))
GO
SET IDENTITY_INSERT [dbo].[ProductPrices] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductDescription]) VALUES (12, N'001', N'Llanta')
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductDescription]) VALUES (13, N'002', N'Manubrio')
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductDescription]) VALUES (14, N'003', N'marco')
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[ProductPrices]  WITH CHECK ADD  CONSTRAINT [FK_ProductPrices_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductPrices] CHECK CONSTRAINT [FK_ProductPrices_Products]
GO
/****** Object:  StoredProcedure [dbo].[Add_Customers]    Script Date: 6/12/2022 1:52:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sergio Toro
-- Create date: 2022-11-29
-- Description:	Obtiene la información de los clientes
-- =============================================
CREATE PROCEDURE [dbo].[Add_Customers]
	 @name varchar(150), @lastName varchar(150), @address varchar(150), @phone varchar(150), @email varchar(150)
AS
BEGIN
	SET NOCOUNT ON;

INSERT INTO [dbo].[Customers]
           ([Name]
           ,[LastName]
           ,[Address]
           ,[Phone]
           ,[Email])
     values(@name, @lastName, @address, @phone, @email)
END
GO
/****** Object:  StoredProcedure [dbo].[Add_Order]    Script Date: 6/12/2022 1:52:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sergio Toro
-- Create date: 2022-11-29
-- Description:	Obtiene la información de los clientes
-- =============================================
CREATE PROCEDURE [dbo].[Add_Order]
@details OrderForSaveContract readonly

AS

BEGIN
	SET NOCOUNT ON;

	declare @total int = (
		select
		sum(d.Quantity * d.UnitValue) as total
		from @details d
	)

	declare @customerDNI varchar(150) = (select top(1) CustomerDNI from @details)
	declare @customerAddress varchar(150) = (select top(1) CustomerAddress from @details)

	declare @orderTemp TABLE (orderID int not null)

	insert into Orders(OrderDate, Total, CustomerDNI, CustomerAddress)
	output inserted.OrderID
	into @orderTemp
	values(GETDATE(), @total, @customerDNI, @customerAddress)

	declare @orderID int = (select top(1) orderID from @orderTemp)
	insert into OrderDetails(OrderID, ProductID, Quantity, SubTotal)
	select
	@orderID,
	d.ProductID,
	d.Quantity,
	@total
	from @details d



END
GO
/****** Object:  StoredProcedure [dbo].[Add_Products]    Script Date: 6/12/2022 1:52:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sergio Toro
-- Create date: 2022-11-29
-- Description:	Obtiene la información de los clientes
-- =============================================
CREATE PROCEDURE [dbo].[Add_Products]
@productCode varchar(150), @productDescription varchar(150), @unitValue decimal(18,0)

AS

BEGIN

	SET NOCOUNT ON;

	declare @produtTemp TABLE (productID int not null)

	insert into Products(ProductCode, ProductDescription)
	output inserted.ProductID
	into @produtTemp
	values(@productCode, @productDescription)

	declare @productID int = (select top(1) productID from @produtTemp)

	insert into ProductPrices(ProductID, UnitValue)
	values(@productID, @unitValue)

END
GO
/****** Object:  StoredProcedure [dbo].[Get_Customers]    Script Date: 6/12/2022 1:52:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sergio Toro
-- Create date: 2022-11-29
-- Description:	Obtiene la información de los clientes
-- =============================================
CREATE PROCEDURE [dbo].[Get_Customers]
AS
BEGIN
	SET NOCOUNT ON;

	select CustomerID, [Name], LastName, [Address], Phone, Email
	from Customers
END
GO
/****** Object:  StoredProcedure [dbo].[Get_Orders]    Script Date: 6/12/2022 1:52:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sergio Toro
-- Create date: 2022-11-29
-- Description:	Obtiene la información de los clientes
-- =============================================
create PROCEDURE [dbo].[Get_Orders]
AS
BEGIN
	SET NOCOUNT ON;

select
o.OrderID,
p.ProductCode,
p.ProductDescription,
od.Quantity,
pc.UnitValue,
o.CustomerDNI,
o.CustomerAddress
from Orders o
inner join OrderDetails od on o.OrderID = od.OrderID
inner join Products p on od.ProductID = p.ProductID
inner join ProductPrices pc on p.ProductID  = pc.ProductID
order by o.OrderID desc

END
GO
/****** Object:  StoredProcedure [dbo].[Get_Products]    Script Date: 6/12/2022 1:52:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sergio Toro
-- Create date: 2022-11-29
-- Description:	Obtiene la información de los clientes
-- =============================================
CREATE PROCEDURE [dbo].[Get_Products]
AS
BEGIN
	SET NOCOUNT ON;

select
	p.ProductID,
	p.ProductCode,
	p.ProductDescription,
	pc.UnitValue
	from Products p
	inner join ProductPrices pc on p.ProductID = pc.ProductID
END
GO
/****** Object:  StoredProcedure [dbo].[MNT_BackupDatabase]    Script Date: 6/12/2022 1:52:12 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Martin Bravo A.
-- Create date: 12/12/2014
-- Description:	Este procedimiento hace un backup de la base de datos
-- =============================================
CREATE PROCEDURE [dbo].[MNT_BackupDatabase]
	@FileName VARCHAR(255) = NULL OUT, @To7z BIT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- http://msdn.microsoft.com/en-us/library/ms187510.aspx
	DECLARE @Now DATETIME = GETDATE(), @DBName varchar(8000), @Name varchar(8000)
	SET @DBName = DB_NAME()
	SET @Name = 'Full Backup of ' + @DBName
	IF @FileName IS NULL
		SET @FileName = 'C:\Workspace\Backups\' + @DBName + ' ' + CONVERT(VARCHAR(19), @Now, 112) + ' ' + REPLACE(CONVERT(VARCHAR(19), @Now, 108), ':', '') + '.bak'
	BACKUP DATABASE @DBName
	TO DISK = @FileName
	   WITH FORMAT,
		  MEDIANAME = 'C_Atp_Backups',
		  NAME = @Name;
	IF @To7z = 1
	BEGIN
		DECLARE @FileName7z VARCHAR(8000) = SUBSTRING(@FileName, 1, LEN(@FileName) - 3) + '7z'
		DECLARE @cmd VARCHAR(8000) = 'if exist "%programfiles%\7-Zip\7z.exe" "%programfiles%\7-Zip\7z.exe" a -t7z "' + @FileName7z + '" "' + @FileName + '"'
		EXEC master..xp_cmdshell @cmd
		SET @cmd = 'if exist "' + @FileName7z + '" del "' + @FileName + '"'
		EXEC master..xp_cmdshell @cmd
	END

	-- Buffer cleaning
	DBCC FREEPROCCACHE WITH NO_INFOMSGS;
	DBCC DROPCLEANBUFFERS WITH NO_INFOMSGS;
END
GO
USE [master]
GO
ALTER DATABASE [RigoRigoDB] SET  READ_WRITE 
GO
