USE [MonthlyPartitionsTest]
GO
/****** Object:  StoredProcedure [dbo].[zsp_TablesPartitionsInfoQuery]    Script Date: 11/19/2019 10:47:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[zsp_TablesPartitionsInfoQuery]

@TableName varchar(128) = null

as
begin


select
	*
from
	iTVF_TablesPartitionsStorageInfo(@TableName) a
order by
	a.TableName
	, a.PartitionNumber

end
GO
