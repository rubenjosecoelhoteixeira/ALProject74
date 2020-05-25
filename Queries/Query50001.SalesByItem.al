query 50001 "Sales by Item"
{
    QueryType = Normal;
    Description = 'ARQNRSH';
    Caption = 'Sales By Item';
    OrderBy = descending(Sales_Amount__Actual_);
    elements
    {

        dataitem(Item; Item)
        {

            DataItemTableFilter = "Certificate Required" = const(true);
            column(No_; "No.")
            {

            }
            column(Description; Description)
            {

            }
            dataitem(Value_Entry; "Value Entry")
            {
                DataItemLink = "Item No." = Item."No.";
                DataItemTableFilter = "Item Ledger Entry Type" = filter(Sale);
                column(Invoiced_Quantity; "Invoiced Quantity")
                {
                    Method = Sum;
                }
                column(Cost_Amount__Actual_; "Cost Amount (Actual)")
                {
                    Method = Sum;
                }
                column(Sales_Amount__Actual_; "Sales Amount (Actual)")
                {
                    Method = Sum;
                }
                filter(Posting_Date; "Posting Date")
                {

                }
            }
        }

    }
}