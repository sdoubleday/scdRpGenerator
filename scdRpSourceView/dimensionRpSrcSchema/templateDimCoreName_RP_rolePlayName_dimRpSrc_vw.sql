CREATE VIEW [dimensionRpSrcSchema].[templateDimCoreName_RP_rolePlayName_dimRpSrc_vw]
AS
SELECT
[SK_templateDimCoreName]
,[d].[SampleColumnOne_Cur]
,[d].[SampleColumnTwo_Hist]
FROM [dimensionSchema].[templateDimCoreName_Dim] AS [d]
;
