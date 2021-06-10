CREATE PROCEDURE [TestHelpers].[DataBuilder_templateSchema_templateDimCoreName_predim_prep]
 @NK_SourceSystemID1 int = NULL
,@NK_SourceSystemID2 int = NULL
,@SampleColumnOne varchar(500) = NULL
,@SampleColumnTwo varchar(500) = NULL
,@Ctl_EffectiveDate datetime2 = NULL
,@SCD_Status varchar(30) = NULL
AS 

IF OBJECT_ID('tempdb..[#DataBuilder_templateSchema_templateDimCoreName_predim_prep]') IS NOT NULL
BEGIN
	DROP TABLE [#DataBuilder_templateSchema_templateDimCoreName_predim_prep];
END
SELECT TOP 0 * INTO [#DataBuilder_templateSchema_templateDimCoreName_predim_prep] FROM [templateSchema].[templateDimCoreName_predim_prep];

INSERT INTO [#DataBuilder_templateSchema_templateDimCoreName_predim_prep](
 [NK_SourceSystemID1]
,[NK_SourceSystemID2]
,[SampleColumnOne]
,[SampleColumnTwo]
,[Ctl_EffectiveDate]
,[SCD_Status]
) SELECT
 @NK_SourceSystemID1
,@NK_SourceSystemID2
,@SampleColumnOne
,@SampleColumnTwo
,@Ctl_EffectiveDate
,@SCD_Status
;
DECLARE @sql NVARCHAR(MAX) = N'INSERT INTO [templateSchema].[templateDimCoreName_predim_prep] SELECT * FROM [#DataBuilder_templateSchema_templateDimCoreName_predim_prep];';
EXECUTE sp_executesql @sql;
RETURN 0


