USE [MonthlyPartitionsTest]
GO
/****** Object:  StoredProcedure [dbo].[zsp_CreateSampleTable]    Script Date: 10/28/2019 12:20:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[zsp_CreateSampleTable]
as
begin

drop Table Test_Monthly
drop PARTITION SCHEME UPS_Test_Monthly
drop PARTITION FUNCTION [UPF_Test_Monthly]

CREATE PARTITION FUNCTION [UPF_Test_Monthly] (date)
AS RANGE RIGHT FOR VALUES --[x,y)
(
	  '2019-01-01'
	, '2019-02-01'
	, '2019-03-01'
	, '2019-04-01'
	, '2019-05-01'
	, '2019-06-01'
	, '2019-07-01'
	, '2019-08-01'
	, '2019-09-01'
	, '2019-10-01'
	, '2019-11-01'
	, '2019-12-01'
	, '2020-01-01'
	, '2020-02-01'
	, '2020-03-01'
	, '2020-04-01'
	, '2020-05-01'
	, '2020-06-01'
	, '2020-07-01'
	, '2020-08-01'
	, '2020-09-01'
	, '2020-10-01'
	, '2020-11-01'
	, '2020-12-01'
);


CREATE PARTITION SCHEME UPS_Test_Monthly
AS PARTITION [UPF_Test_Monthly]
TO
(
	 [FG_Test_Monthly_Y00M00]
	,[FG_Test_Monthly_Y01M01]
	,[FG_Test_Monthly_Y01M02]
	,[FG_Test_Monthly_Y01M03]
	,[FG_Test_Monthly_Y01M04]
	,[FG_Test_Monthly_Y01M05]
	,[FG_Test_Monthly_Y01M06]
	,[FG_Test_Monthly_Y01M07]
	,[FG_Test_Monthly_Y01M08]
	,[FG_Test_Monthly_Y01M09]
	,[FG_Test_Monthly_Y01M10]
	,[FG_Test_Monthly_Y01M11]
	,[FG_Test_Monthly_Y01M12]
	,[FG_Test_Monthly_Y02M01]
	,[FG_Test_Monthly_Y02M02]
	,[FG_Test_Monthly_Y02M03]
	,[FG_Test_Monthly_Y02M04]
	,[FG_Test_Monthly_Y02M05]
	,[FG_Test_Monthly_Y02M06]
	,[FG_Test_Monthly_Y02M07]
	,[FG_Test_Monthly_Y02M08]
	,[FG_Test_Monthly_Y02M09]
	,[FG_Test_Monthly_Y02M10]
	,[FG_Test_Monthly_Y02M11]
	,[FG_Test_Monthly_Y02M12]
	
)


create Table Test_Monthly
(
	DataDate date

)
on ups_test_monthly(datadate)
end
GO
