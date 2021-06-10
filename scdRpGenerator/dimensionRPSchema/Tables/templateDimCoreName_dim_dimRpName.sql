CREATE TABLE [dimensionRPSchema].[templateDimCoreName_dim_dimRpName]
(
	 [SK_templateDimCoreName] INT NOT NULL
	,
	 [SampleColumnOne_Cur] VARCHAR(500) NOT NULL		/*DimensionAttribute_ReplacementPoint|SampleColumnOne_Cur|,*/
	,[SampleColumnTwo_Hist] VARCHAR(500) NOT NULL		/*Sample*/
	,CONSTRAINT [pk_dimensionRPSchema_templateDimCoreName_dim_dimRpName] PRIMARY KEY CLUSTERED ([SK_templateDimCoreName])
)
