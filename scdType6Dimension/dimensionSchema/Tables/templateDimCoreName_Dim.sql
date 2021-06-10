CREATE TABLE [dimensionSchema].[templateDimCoreName_Dim]
(
	 [SK_templateDimCoreName] INT NOT NULL
	,
	 [NK_SourceSystemID1] NVARCHAR(500) NOT NULL					/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
	,[NK_SourceSystemID2] NVARCHAR(500) NOT NULL					/*Sample*/
	,
	 [SampleColumnOne_Cur] VARCHAR(500) NOT NULL		/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
	,
	 [SampleColumnOne_Hist] VARCHAR(500) NOT NULL		/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
	,[SampleColumnTwo_Cur] VARCHAR(500) NOT NULL		/*Sample*/
	,[SampleColumnTwo_Hist] VARCHAR(500) NOT NULL		/*Sample*/
	,[templateDimCoreName_IsMissing] BIT NOT NULL CONSTRAINT [df_dimensionSchema_templateDimCoreName_IsMissing] DEFAULT (0)
	,[Ctl_CurrentFlag] BIT NOT NULL
	,[Ctl_EffectiveDate] DATETIME2(7) NOT NULL
	,[Ctl_EndDate_Excl] DATETIME2(7) NOT NULL
	,CONSTRAINT [pk_dimensionSchema_templateDimCoreName_Dim] PRIMARY KEY CLUSTERED ([SK_templateDimCoreName])
	,INDEX [ncind_dimensionSchema_templateDimCoreName_Dim_CurrentNKLookup] NONCLUSTERED (
		 [Ctl_CurrentFlag]
		,
		 [NK_SourceSystemID1]		/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
		,[NK_SourceSystemID2]		/*Sample*/
		,[SK_templateDimCoreName])
	,INDEX [ncind_dimensionSchema_templateDimCoreName_Dim_CurrentSKLookup] NONCLUSTERED ([Ctl_CurrentFlag],[SK_templateDimCoreName])
	,INDEX [ncind_dimensionSchema_templateDimCoreName_Dim_NKLookup] NONCLUSTERED (
		 [NK_SourceSystemID1]		/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
		,[NK_SourceSystemID2]		/*Sample*/
		)
	,INDEX [ncind_dimensionSchema_templateDimCoreName_Dim_SKPLookup] NONCLUSTERED (
		 [NK_SourceSystemID1]		/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
		,[NK_SourceSystemID2]		/*Sample*/
		,[Ctl_EffectiveDate]
		,[Ctl_EndDate_Excl]
		,[SK_templateDimCoreName])
)
