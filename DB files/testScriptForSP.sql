USE [CS6232-g4]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[sp_mostPerformedTestsDuringDates]
		@BeginDate = '2019-04-25',
		@EndDate = '2019-04-30'

SELECT	'Return Value' = @return_value

GO
