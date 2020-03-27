report 50902 RDLReportExample
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Templates/RDLCReportExample.rdl';
    dataset
    {
        dataitem("Sales_Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST("Order"));
            RequestFilterHeading = 'Sales Order';
            RequestFilterFields = "No.";

            Column("No"; "No.") { }
            column(Barcode; TempBlob.Blob) { }

            trigger OnAfterGetRecord()
            begin

                //                Barcode.GenerateBarcode("No.", var_BarcodeFormat, var_Barcode_Height, var_Barcode_Width, var_Barcode_Margin, var_IsPureBarcode, TempBlob);
                Barcode.GenerateBarcode("No.", 'CODE_39', '100', '400', '0', 'true', TempBlob);
            end;

        }
    }

    var
        Barcode: Codeunit "IBO Digital Barcode Generator";
        InStreamRep: InStream;
        outStreamRep: OutStream;
        TempBlob: Record TempBlob temporary;

}
