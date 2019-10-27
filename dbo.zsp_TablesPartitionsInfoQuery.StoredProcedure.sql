USE [MonthlyPartitionsTest]
GO
/****** Object:  StoredProcedure [dbo].[zsp_TablesPartitionsInfoQuery]    Script Date: 10/28/2019 12:20:00 AM ******/
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
	iTVF_TablesPartitionsInfo(@TableName) a
order by
	a.TableName
	, a.rowid

end
GO
