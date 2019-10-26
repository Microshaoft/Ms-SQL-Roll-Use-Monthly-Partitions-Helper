USE [MonthlyPartitionsTest]
GO
/****** Object:  StoredProcedure [dbo].[zsp_SampleMonthlyDataPartitionsInfoQuery]    Script Date: 10/26/2019 9:03:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[zsp_SampleMonthlyDataPartitionsInfoQuery]
as
begin

SELECT
	$partition.UPF_Test_Monthly(DataDate) AS [Partition Number]
	, min(DataDate) AS [Min DataDate]
	, max(DataDate) AS [Max DataDate]
	, count(*) AS [Rows In Partition]
FROM Test_Monthly with(nolock)
GROUP BY $partition.UPF_Test_Monthly(DataDate)
ORDER BY [Partition Number]

end
GO
