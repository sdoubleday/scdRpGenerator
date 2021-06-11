using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Text;
using System.Threading.Tasks;
using Microsoft.SqlServer.Dac;
using Microsoft.SqlServer.Dac.Model;
using Microsoft.SqlServer.TransactSql.ScriptDom;
using SqlTemplateColumnExpander;

namespace GenerateSCDType6Files
{
    class Program
    {
        static void Main(string[] args)
        {
            ParsedArgs parsedArgs = new ParsedArgs(args);

            Microsoft.SqlServer.Dac.Model.TSqlModel sqlModel = new Microsoft.SqlServer.Dac.Model.TSqlModel(parsedArgs.DacPacFileName);

            //Where takes a predicate thing. No, I haven't figured out how to do that without lambda stuff yet. But this is tolerably readable for main control flow, I think.
            var views = sqlModel.GetObjects(DacQueryScopes.Default, View.TypeClass).ToList().Where(view => view.Name.ToString().EndsWith("_dimRpSrc_vw]"));

            foreach (var view in views)
            {
                ProcessTSqlObjectIntoDimensionScriptFiles(parsedArgs, view, View.Columns, View.Schema);
            }
        }

        public static void ProcessTSqlObjectIntoDimensionScriptFiles(ParsedArgs parsedArgs, TSqlObject table, ModelRelationshipClass relationshipTypeColumns, ModelRelationshipClass relationshipTypeSchema)
        {
            string stagingSchemaName = GetSchemaName(table);
            string templateDimCoreName = GetObjectName(table).Split("_RP_")[0];
            string dimRpName = GetObjectName(table).Split("_RP_")[1].Replace("_dimRpSrc_vw", "");
            List<String> listOfColumns = new List<String>();
            foreach (var col in table.GetReferenced(relationshipTypeColumns, DacQueryScopes.UserDefined))
            {
                String column = GetColumnName(col);
                listOfColumns.Add(column);
            }
            GenerateRpDimension(listOfColumns, templateDimCoreName, parsedArgs, stagingSchemaName, dimRpName);
        }

        public static void GenerateRpDimension(List<string> listOfColumns, String templateDimCoreName, ParsedArgs parsedArgs, String StagingSchema, String dimRpName)
        {
            List<String> listOfDims = listOfColumns.Where(mystring => !mystring.StartsWith("Ctl_")).Where(mystring => !mystring.StartsWith("SK_")).ToList<String>();
            LineProcessorConfig lineProcessorConfigDim = new LineProcessorConfig("DimensionAttribute_ReplacementPoint", listOfDims);


            //Something like:
            //method list all files in template directory to output directory, get string renaming them to swap out the templateDimCoreName in the file name.
            //StreamReader the source file. Foreach line, create line processor for nk, get back line. Create line processor for dim (with that returned line), get back line.
            //StreamWriter out the line to a file with the new name in output directory.
            //

            List<String> templateFiles = new List<string>{
                "Stored Procedures\\templateDimCoreName_dim_dimRpName_Synchronize_Step1_GetSKs_usp.sql"
                ,"Stored Procedures\\templateDimCoreName_dim_dimRpName_Synchronize_Step2_Update_usp.sql"
                ,"Stored Procedures\\templateDimCoreName_dim_dimRpName_Synchronize_usp.sql"
                ,"Tables\\templateDimCoreName_dim_dimRpName.sql"
                };

            foreach (String file in templateFiles)
            {
                TransformRpFileInFlight(templateDimCoreName, parsedArgs.SCDType6DimensionDirectory, parsedArgs.OutputDirectory, parsedArgs.DimensionSchema, parsedArgs.dimensionRpSrcSchema, StagingSchema, lineProcessorConfigDim, file, dimRpName);
            }
        }

        public static void TransformRpFileInFlight(string templateDimCoreName, string SCDType6TemplateDirectory, string OutputDirectory, string DimensionSchema, string dimensionRpSrcSchema, string StagingSchema, LineProcessorConfig lineProcessorConfigDim, string file, string dimRpName)
        {
            String source = SCDType6TemplateDirectory + file;
            String destination = OutputDirectory + file.Split('\\')[1].Replace("templateDimCoreName", templateDimCoreName).Replace("dimRpName", dimRpName);
            using (StreamReader reader = new StreamReader(source))
            using (StreamWriter writer = new StreamWriter(destination, false, Encoding.UTF8))
            {
                while (!reader.EndOfStream)
                {
                    string line = reader.ReadLine();
                    line = line.Replace("templateDimCoreName", templateDimCoreName);
                    line = line.Replace("dimensionRpSrcSchema", dimensionRpSrcSchema);
                    line = line.Replace("dimensionRpSchema", DimensionSchema);
                    line = line.Replace("dimRpName", dimRpName);

                    if (!line.Contains("/*Sample*/"))
                    {
                        LineProcessor lineProcessorDim = new LineProcessor(line, lineProcessorConfigDim);
                        line = lineProcessorDim.GetLine();

                        writer.WriteLine(line);
                    }

                }

            }
        }

        public static string GetObjectName(TSqlObject obj)
        {
            return obj.Name.ToString().Split('.')[1].Replace("[", "").Replace("]", "");
            //This parses the [schema].[object] format that we get back
        }

        public static string GetSchemaName(TSqlObject obj)
        {
            Console.WriteLine(obj.Name.ToString());

            string returnable = obj.Name.ToString().Split('.')[0].Replace("[", "").Replace("]", "");
            Console.WriteLine(returnable);
            return returnable;
            //This parses the [schema].[object] format that we get back
        }

        public static string GetColumnName(TSqlObject col)
        {
            return col.Name.ToString().Split('.')[2].Replace("[", "").Replace("]", "");
            //This parses the [schema].[object].[column] format that we get back
        }
    }
}
