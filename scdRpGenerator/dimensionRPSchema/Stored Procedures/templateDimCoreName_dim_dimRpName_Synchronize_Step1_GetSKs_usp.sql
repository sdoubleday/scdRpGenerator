CREATE PROCEDURE [dimensionRpSchema].[templateDimCoreName_dim_dimRpName_Synchronize_Step1_GetSKs_usp]
AS

INSERT INTO [dimensionRpSchema].[templateDimCoreName_dim_dimRpName]
(
 [SK_templateDimCoreName]
,
 [dimRpName_SampleColumnOne_Cur]		/*DimensionAttribute_ReplacementPoint|SampleColumnOne_Cur|,*/
,[dimRpName_SampleColumnTwo_Hist]		/*Sample*/
)
SELECT
 [SK_templateDimCoreName]
,
 [SampleColumnOne_Cur]		/*DimensionAttribute_ReplacementPoint|SampleColumnOne_Cur|,*/
,[SampleColumnTwo_Hist]		/*Sample*/
FROM [dimensionRpSrcSchema].[templateDimCoreName_RP_dimRpName_dimRpSrc_vw]
WHERE [SK_templateDimCoreName] IN (
	SELECT
	[SK_templateDimCoreName]
	FROM [dimensionRpSrcSchema].[templateDimCoreName_RP_dimRpName_dimRpSrc_vw]
	EXCEPT
	SELECT
	[SK_templateDimCoreName]
	FROM [dimensionRpSchema].[templateDimCoreName_dim_dimRpName]
)
;
