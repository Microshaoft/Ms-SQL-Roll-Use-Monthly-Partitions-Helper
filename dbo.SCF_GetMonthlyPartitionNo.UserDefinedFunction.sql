USE [MonthlyPartitionsTest]
GO
/****** Object:  UserDefinedFunction [dbo].[SCF_GetMonthlyPartitionNo]    Script Date: 10/26/2019 8:10:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[SCF_GetMonthlyPartitionNo] 
(
	@TableName varchar(128)
	, @MonthDate date
)
/*

select dbo.SCF_GetMonthlyPartitionNo('Test_Monthly', '2019-01-01')
	

*/

RETURNS int
AS
BEGIN
	-- Declare the return variable here
	--declare @MonthFirstDate date
	--set @MonthFirstDate = dateadd(MONTH, DATEDIFF(MONTH,0,@MonthDate),0)
	--declare @NextMonthFirstDate date
	--set @NextMonthFirstDate = dateadd(MONTH, 1, @MonthFirstDate)

	declare @ int = -1
	;with T
	as
	(
		select
			a.LeftValue
			, a.RightValue
			, @MonthDate		as MonthDate
			, a.destination_id
			, a.FileGroupName
		from
			iTVF_TablesPartitionsInfo(@TableName) a
		where
			(
				(a.LeftValue = a.RightValue)
				or
				a.LeftValue <= @MonthDate
			)
			and
			(
				(a.RightValue is null)
				or
				a.RightValue > @MonthDate
			)
		)
	select
		@ = a.destination_id
	from
		T a

	return @




END
GO
