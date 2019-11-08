USE [MonthlyPartitionsTest]
GO
/****** Object:  UserDefinedFunction [dbo].[SCF_GetMonthlyPartitionNo]    Script Date: 11/8/2019 1:55:00 PM ******/
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

select dbo.SCF_GetMonthlyPartitionNo('Test_Monthly', '2026-01-01')
	
*/

RETURNS int
AS
BEGIN
	declare @ int = -1
	;with T0
	as
	(
		select
			  a.LeftValue
			, a.RightValue
			, @MonthDate			as MonthDate
			, a.[PartitionNumber]
			, a.FileGroupName
		from
			iTVF_TablesPartitionsStorageInfo
					(
						@TableName
					) a
	)
	, T
	as
	(
		select
			*
		from
			T0 a
		where
			(
				(
					a.LeftValue = a.RightValue
					and
					not exists
						(
							select
								1
							from
								T0 aa
							where
								aa.LeftValue < a.LeftValue
						)
				)
				or
				a.LeftValue <= @MonthDate
			)
			and
			(
				(
					a.LeftValue is not null
					and
					a.RightValue is null
					and
					not exists
						(
							select
								1
							from
								T0 aa
							where
								aa.LeftValue > a.LeftValue
						)
				)
				or
				a.RightValue > @MonthDate
			)
		)
	select
		@ = a.[PartitionNumber]
	from
		T a

	return @

END
GO
