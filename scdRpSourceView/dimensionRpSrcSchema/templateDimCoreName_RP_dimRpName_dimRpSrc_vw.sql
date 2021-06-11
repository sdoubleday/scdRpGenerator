CREATE VIEW [dimensionRpSrcSchema].[templateDimCoreName_RP_dimRpName_dimRpSrc_vw]
AS
SELECT
/*Must include SK, must be from one dimesion only, must only include unmodified columns, must not rename columns.*/
[SK_templateDimCoreName]
,[d].[SampleColumnOne_Cur]
,[d].[SampleColumnTwo_Hist]
FROM [dimensionSchema].[templateDimCoreName_Dim] AS [d]
;
