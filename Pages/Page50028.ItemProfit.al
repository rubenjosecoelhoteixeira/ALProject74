page 50028 ItemProfit
{
    Caption = 'Item Profit';
    PageType = Worksheet;
    ApplicationArea = Documents;
    UsageCategory = Documents;
    Description = 'ARQNRSH';
    SourceTable = "Value Entry";
    SourceTableTemporary = true;
    ShowFilter = false;

    layout
    {
        area(Content)
        {

            group(DateFilters)
            {
                Caption = 'DateFilters';

                field(FromDate; FromDate)
                {
                    Caption = 'From Date';
                    ApplicationArea = CustomerContent;

                    trigger OnValidate()
                    begin
                        GetItems;
                    end;
                }
                field(ToDate; ToDate)
                {
                    Caption = 'To Date';
                    ApplicationArea = CustomerContent;

                    trigger OnValidate()
                    begin
                        GetItems;
                    end;
                }
            }
            repeater(General)
            {
                Caption = 'General';
                Editable = false;
                field("Item No."; "Item No.")
                {
                    Caption = 'Item No.';
                    ApplicationArea = CustomerContent;
                }
                field(Description; Description)
                {
                    Caption = 'Description';
                    ApplicationArea = CustomerContent;
                }
                field("Invoiced Quantity"; "Invoiced Quantity")
                {
                    Caption = 'Invoiced Quantity';
                    ApplicationArea = CustomerContent;
                }
                field("Sales Amount (Actual)"; "Sales Amount (Actual)")
                {
                    Caption = 'Sales Amount (Actual)';
                    ApplicationArea = CustomerContent;
                }
                field("Cost Amount (Actual)"; "Cost Amount (Actual)")
                {
                    Caption = 'Cost Amount (Actual)';
                    ApplicationArea = CustomerContent;
                }
                field(ProfitPct; ProfitPct)
                {
                    Caption = 'Profit %';
                    ApplicationArea = CustomerContent;
                }
            }
        }
    }

    procedure GetItems()
    var
        SalesbyItem: Query "Sales by Item";
        EntryNo: Integer;
    begin
        IF FromDate = 0D THEN
            FromDate := WORKDATE;
        IF ToDate = 0D THEN
            ToDate := WORKDATE;
        RESET;
        DELETEALL;
        EntryNo := 1;
        SalesbyItem.SETRANGE(Posting_Date, FromDate, ToDate);
        IF SalesbyItem.OPEN THEN
            WHILE SalesbyItem.READ DO BEGIN
                "Entry No." := EntryNo;
                "Item No." := SalesbyItem.No_;
                Description := SalesbyItem.Description;
                "Invoiced Quantity" := -
                SalesbyItem.Invoiced_Quantity;
                "Sales Amount (Actual)" :=
                SalesbyItem.Sales_Amount__Actual_;
                "Cost Amount (Actual)" := -
                SalesbyItem.Cost_Amount__Actual_;
                INSERT;
                EntryNo += 1;
            END;
    end;

    trigger OnOpenPage()
    begin
        GetItems;
    end;

    trigger OnAfterGetRecord()
    begin
        if "Cost Amount (Actual)" <> 0 then
            ProfitPct := ROUND(("Sales Amount (Actual)" - "Cost Amount (Actual)") / "Cost Amount (Actual)" * 100, 2);
    end;

    var
        ProfitPct: Integer;
        FromDate: Date;
        ToDate: Date;
}