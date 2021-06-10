CREATE PROCEDURE [TestHelpers].[DataBuilder_dimensionSchema_templateDimCoreName_Dim]
 @SK_templateDimCoreName int = NULL
,@NK_SourceSystemID1 int = NULL
,@NK_SourceSystemID2 int = NULL
,@SampleColumnOne_Cur varchar(500) = NULL
,@SampleColumnOne_Hist varchar(500) = NULL
,@SampleColumnTwo_Cur varchar(500) = NULL
,@SampleColumnTwo_Hist varchar(500) = NULL
,@Ctl_CurrentFlag bit = NULL
,@Ctl_EffectiveDate datetime2 = NULL
,@Ctl_EndDate_Excl datetime2 = NULL
AS 

IF OBJECT_ID('tempdb..[#DataBuilder_dimensionSchema_templateDimCoreName_Dim]') IS NOT NULL
BEGIN
	DROP TABLE [#DataBuilder_dimensionSchema_templateDimCoreName_Dim];
END
SELECT TOP 0 * INTO [#DataBuilder_dimensionSchema_templateDimCoreName_Dim] FROM [dimensionSchema].[templateDimCoreName_Dim];

INSERT INTO [#DataBuilder_dimensionSchema_templateDimCoreName_Dim](
 [SK_templateDimCoreName]
,[NK_SourceSystemID1]
,[NK_SourceSystemID2]
,[SampleColumnOne_Cur]
,[SampleColumnOne_Hist]
,[SampleColumnTwo_Cur]
,[SampleColumnTwo_Hist]
,[Ctl_CurrentFlag]
,[Ctl_EffectiveDate]
,[Ctl_EndDate_Excl]
) SELECT
 @SK_templateDimCoreName
,@NK_SourceSystemID1
,@NK_SourceSystemID2
,@SampleColumnOne_Cur
,@SampleColumnOne_Hist
,@SampleColumnTwo_Cur
,@SampleColumnTwo_Hist
,@Ctl_CurrentFlag
,@Ctl_EffectiveDate
,@Ctl_EndDate_Excl
;
DECLARE @sql NVARCHAR(MAX) = N'INSERT INTO [dimensionSchema].[templateDimCoreName_Dim] SELECT * FROM [#DataBuilder_dimensionSchema_templateDimCoreName_Dim];';
EXECUTE sp_executesql @sql;
RETURN 0


