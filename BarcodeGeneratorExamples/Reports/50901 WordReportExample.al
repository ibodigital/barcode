report 50901 WordReportExample
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = Word;
    WordLayout = './Templates/WordReportExample.docx';
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

                //Parameter Description Barcode.GenerateBarcode(Sales Order No, BarcodeFormat, Barcode_Height, Barcode_Width, Barcode_Margin, IsPureBarcode, TempBlob);
                Barcode.GenerateBarcode("No.", 'CODE_39', '100', '400', '0', 'true', TempBlob1);
                TempBlob1.CreateInStream(InStreamRep);
                TempBlob.Blob.CreateOutStream(outStreamRep);
                CopyStream(outStreamRep, InStreamRep)
            end;

        }
    }

    var
        Barcode: Codeunit "IBODigital sBarcode";
        InStreamRep: InStream;
        outStreamRep: OutStream;
        TempBlob: Record TempBlob temporary;
        TempBlob1: Codeunit "Temp Blob";

}
