tableextension 50007 "ItemExt" extends Item
{
    Description = 'ARQNRSH';
    Caption = 'Item Extension';

    fields
    {
        field(50100; "Certificate Required"; Boolean)
        {
            Caption = 'Certificate Required';
            DataClassification = CustomerContent;
        }
    }
}