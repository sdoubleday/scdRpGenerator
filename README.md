# scdRpGenerator
Write a view with a subset of your dimension columns, generate a roleplaying dimension table with this.

## Run the Generator
.\GenerateSCDRpFiles\bin\Debug\net5.0\GenerateSCDRpFiles.exe <relative path to dacpac> <Output directory> <schema where role play dimensions will live> <dimensionRpSrcSchema>

## Prepare views
- Replace in View schema, name, SK column name, and FROM table name:
  - dimensionRpSrcSchema
  - templateDimCoreName
  - dimRpName
- Repoint FROM to relevant schema
- List target columns in SELECT clause
```SQL
CREATE VIEW [dimensionRpSrcSchema].[templateDimCoreName_RP_dimRpName_dimRpSrc_vw]
AS
SELECT
/*Must include SK, must be from one dimesion only, must only include unmodified columns, must not rename columns.*/
[SK_templateDimCoreName]
,[d].[SampleColumnOne_Cur]
,[d].[SampleColumnTwo_Hist]
FROM [dimensionSchema].[templateDimCoreName_Dim] AS [d]
;
```
