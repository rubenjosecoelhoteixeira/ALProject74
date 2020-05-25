pageextension 50012 "Item Card Ext" extends "Item Card"
{
    Caption = 'Item Card Ext';

    layout
    {
        addlast(Warehouse)
        {
            field("Certificate Required"; "Certificate Required")
            {
                ApplicationArea = CustomerContent;
                Caption = 'Certificate Required';
            }
        }
    }
}