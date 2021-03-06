CREATE PROCEDURE [dimensionRpSchema__templateDimCoreName_dim_dimRpName_Synchronize_Step1_GetSKs_usp].[test Update All Columns]
AS
BEGIN
	--ASSEMBLE
	IF OBJECT_ID('[dimensionRpSchema__templateDimCoreName_dim_dimRpName_Synchronize_Step1_GetSKs_usp].ACTUAL') IS NOT NULL DROP TABLE [dimensionRpSchema__templateDimCoreName_dim_dimRpName_Synchronize_Step1_GetSKs_usp].ACTUAL;
	IF OBJECT_ID('[dimensionRpSchema__templateDimCoreName_dim_dimRpName_Synchronize_Step1_GetSKs_usp].EXPECTED') IS NOT NULL DROP TABLE [dimensionRpSchema__templateDimCoreName_dim_dimRpName_Synchronize_Step1_GetSKs_usp].EXPECTED;

	EXECUTE tSQLt.FakeTable @TableName = '[dimensionSchema].templateDimCoreName_Dim';
	EXECUTE tSQLt.FakeTable @TableName = '[dimensionRpSchema].templateDimCoreName_dim_dimRpName';
	EXECUTE [TestHelpers].[DataBuilder_dimensionSchema_templateDimCoreName_Dim] @SK_templateDimCoreName = 1;
	EXECUTE [TestHelpers].[DataBuilder_dimensionSchema_templateDimCoreName_Dim] @SK_templateDimCoreName = 2;
	
	/*This should probably be with a TestHelper to load the RP table directly, technically.*/
	EXECUTE [dimensionRpSchema].[templateDimCoreName_dim_dimRpName_Synchronize_Step1_GetSKs_usp];
	
	DELETE [dimensionSchema].[templateDimCoreName_Dim];
	EXECUTE [TestHelpers].[DataBuilder_dimensionSchema_templateDimCoreName_Dim] @SK_templateDimCoreName = 1, @SampleColumnOne_Cur = 'Updated1';
	EXECUTE [TestHelpers].[DataBuilder_dimensionSchema_templateDimCoreName_Dim] @SK_templateDimCoreName = 2, @SampleColumnOne_Cur = 'Updated2';
	
	
	--ACT
	EXECUTE [dimensionRpSchema].[templateDimCoreName_dim_dimRpName_Synchronize_Step2_Update_usp];
	
	SELECT 
	[SK_templateDimCoreName]
	,[dimRpName_SampleColumnOne_Cur]
	INTO [dimensionRpSchema__templateDimCoreName_dim_dimRpName_Synchronize_Step1_GetSKs_usp].ACTUAL
	FROM [dimensionRpSchema].[templateDimCoreName_dim_dimRpName];

	--ASSERT
	CREATE TABLE [dimensionRpSchema__templateDimCoreName_dim_dimRpName_Synchronize_Step1_GetSKs_usp].EXPECTED (
		[SK_templateDimCoreName] INT
		,[dimRpName_SampleColumnOne_Cur] VARCHAR(500)
	);
	INSERT INTO [dimensionRpSchema__templateDimCoreName_dim_dimRpName_Synchronize_Step1_GetSKs_usp].EXPECTED (
		[SK_templateDimCoreName]
		,[dimRpName_SampleColumnOne_Cur]
	) VALUES (1,'Updated1'),(2,'Updated2');

	EXECUTE [tSQLt].AssertEqualsTable @Expected = '[dimensionRpSchema__templateDimCoreName_dim_dimRpName_Synchronize_Step1_GetSKs_usp].EXPECTED', @Actual = '[dimensionRpSchema__templateDimCoreName_dim_dimRpName_Synchronize_Step1_GetSKs_usp].ACTUAL';

END

/****
Script generated by cookiecutter, for completion by user.
https://github.com/sdoubleday/cookiecutter-tsqlt-class-vs
This test compares the contents of EXPECTED and ACTUAL.
****/
/****
Suggestion: Verify the object being selected from in the
Act section. It defaults to your object under test.
****/
