CREATE PROCEDURE [dimensionRpSchema].[templateDimCoreName_dim_dimRpName_Synchronize_Step2_Update_usp]
AS
UPDATE [d]
SET
 [d].[SampleColumnOne_Cur] = [v].[SampleColumnOne_Cur]	/*DimensionAttribute_ReplacementPoint|SampleColumnOne_Cur|,*/
,[d].[SampleColumnTwo_Hist] = [v].[SampleColumnTwo_Hist]	/*Sample*/
FROM [dimensionRpSchema].[templateDimCoreName_dim_dimRpName] AS [d]
INNER JOIN [dimensionRpSrcSchema].[templateDimCoreName_RP_dimRpName_dimRpSrc_vw] AS [v]
ON [d].[SK_templateDimCoreName] = [v].[SK_templateDimCoreName]
;
