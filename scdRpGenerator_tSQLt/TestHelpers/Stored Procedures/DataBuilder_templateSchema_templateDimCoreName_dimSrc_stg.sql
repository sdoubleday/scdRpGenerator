CREATE PROCEDURE [TestHelpers].[DataBuilder_StagingSchema_templateDimCoreName_dimSrc_stg]
 @NK_SourceSystemID1 int = NULL
,@NK_SourceSystemID2 int = NULL
,@SampleColumnOne varchar(500) = NULL
,@SampleColumnTwo int = NULL
,@Ctl_EffectiveDate datetime2 = NULL
AS 

IF OBJECT_ID('tempdb..[#DataBuilder_StagingSchema_templateDimCoreName_dimSrc_stg]') IS NOT NULL
BEGIN
	DROP TABLE [#DataBuilder_StagingSchema_templateDimCoreName_dimSrc_stg];
END
SELECT TOP 0 * INTO [#DataBuilder_StagingSchema_templateDimCoreName_dimSrc_stg] FROM [StagingSchema].[templateDimCoreName_dimSrc_stg];

INSERT INTO [#DataBuilder_StagingSchema_templateDimCoreName_dimSrc_stg](
 [NK_SourceSystemID1]
,[NK_SourceSystemID2]
,[SampleColumnOne]
,[SampleColumnTwo]
,[Ctl_EffectiveDate]
) SELECT
 @NK_SourceSystemID1
,@NK_SourceSystemID2
,@SampleColumnOne
,@SampleColumnTwo
,@Ctl_EffectiveDate
;
DECLARE @sql NVARCHAR(MAX) = N'INSERT INTO [StagingSchema].[templateDimCoreName_dimSrc_stg] SELECT * FROM [#DataBuilder_StagingSchema_templateDimCoreName_dimSrc_stg];';
EXECUTE sp_executesql @sql;
RETURN 0


