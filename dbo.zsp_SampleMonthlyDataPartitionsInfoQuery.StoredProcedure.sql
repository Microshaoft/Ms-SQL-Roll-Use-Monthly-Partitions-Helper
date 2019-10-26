USE [MonthlyPartitionsTest]
GO
/****** Object:  StoredProcedure [dbo].[zsp_SampleMonthlyDataPartitionsInfoQuery]    Script Date: 10/26/2019 11:15:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[zsp_SampleMonthlyDataPartitionsInfoQuery]
as
begin

SELECT
	$partition.UPF_Test_Monthly(a.DataDate)		AS [Partition Number]
	, min(a.DataDate)							AS [Min DataDate]
	, max(a.DataDate)							AS [Max DataDate]
	, count(*)									AS [Rows In Partition]
FROM
	Test_Monthly a with(nolock)
GROUP BY
	$partition.UPF_Test_Monthly(a.DataDate)
ORDER BY
	[Partition Number]

;with TPartition
as
(
	select
		*
	from
		iTVF_TablesPartitionsInfo('Test_Monthly')
)
, TData
as
(
	select
		$partition.UPF_Test_Monthly(a.DataDate) AS [PartitionNo]
		, a.*
	from
		Test_Monthly a
)
SELECT
	--$partition.
	  a.destination_id 
	, b.[PartitionNo]
	, a.FileGroupName
	, a.LeftValue
	, a.RightValue
	, min(b.DataDate)		AS [Min DataDate]
	, max(b.DataDate)		AS [Max DataDate]
	, count(b.DataDate)		AS [Rows In Partition]
FROM
	TPartition a
		left join
			TData b
				on
					a.destination_id = b.[PartitionNo]
			
GROUP BY
	a.destination_id 
	, b.[PartitionNo]
	, a.FileGroupName
	, a.LeftValue
	, a.RightValue
ORDER BY
	a.destination_id 
	, b.[PartitionNo]



end