CREATE PROCEDURE [dimensionRpSchema].[templateDimCoreName_dim_dimRpName_Synchronize_usp]
AS

EXECUTE [dimensionRpSchema].[templateDimCoreName_dim_dimRpName_Synchronize_Step1_GetSKs_usp];

EXECUTE [dimensionRpSchema].[templateDimCoreName_dim_dimRpName_Synchronize_Step2_Update_usp];
;
