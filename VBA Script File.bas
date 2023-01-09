Attribute VB_Name = "Module1"
Sub StockMarket()
Attribute StockMarket.VB_ProcData.VB_Invoke_Func = " \n14"
'
' StockMarket Macro

'Workbook
Dim WS As Worksheet
    For Each WS In ActiveWorkbook.Worksheets
    WS.Activate
    
    Lastrow = WS.Cells(Rows.Count, 1).End(xlUp).row
    
    'Variables
    
    Dim ticker As String
    Dim open_price As Double
    Dim close_price As Double
    Dim yearlychange As Double
    Dim volume As Double
    volume = 0
    Dim percentage_change As Double
    Dim row As Double
    row = 2
    Dim column As Integer
    column = 1
    
'Headers
    
    Cells(1, 9).Value = "Ticker"
    Cells(1, 10).Value = "Yearly Change"
    Cells(1, 11).Value = "Percent Change"
    Cells(1, 12).Value = "Total Stock Volume"
    
'Loops

open_price = Cells(2, 3).Value

For i = 2 To Lastrow

If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
    
    ticker = Cells(i, 1).Value
    Cells(row, 9).Value = ticker
    
    closing_price = Cells(i, 6).Value
    
    yearly_change = closing_price - open_price
    Cells(row, 10).Value = yearly_change
    Cells(row, 10).NumberFormat = "$0.00"

        
    percentage_change = yearly_change / open_price
    Cells(row, 11).Value = percentage_change
    Cells(row, 11).NumberFormat = "0.00%"
    
        
    volume = volume + Cells(i, 7).Value
    Cells(row, 12).Value = volume

    row = row + 1
    open_price = Cells(i + 1, 3)

    volume = 0
    
    Else
    volume = volume + Cells(i, 7).Value
    
End If

Next i
YearlyChangeLastrow = WS.Cells(Rows.Count, 10).End(xlUp).row

For j = 2 To YearlyChangeLastrow
If Cells(j, "J").Value >= 0 Then
    Cells(j, "J").Interior.ColorIndex = 4
    Cells(j, "K").Interior.ColorIndex = 4
    ElseIf Cells(j, "J").Value < 0 Then
    Cells(j, "J").Interior.ColorIndex = 3
    Cells(j, "K").Interior.ColorIndex = 3
    End If
    
    Next j


Cells(2, 15).Value = "Greatest Percentage Increase"
Cells(3, 15).Value = "Greatest Percentage Decrease"
Cells(4, 15).Value = "Greatest Total Volume"
Cells(1, 16).Value = "Ticker"
Cells(1, 17).Value = "Value"

For Z = 2 To YearlyChangeLastrow

If Cells(Z, 11).Value = Application.WorksheetFunction.Max(WS.Range("K2:K" & YearlyChangeLastrow)) Then
    Cells(2, 16).Value = Cells(Z, 9).Value
    Cells(2, 17).Value = Cells(Z, 11).Value
    Cells(2, 17).NumberFormat = "0.00%"
ElseIf Cells(Z, 11).Value = Application.WorksheetFunction.Min(WS.Range("K2:K" & YearlyChangeLastrow)) Then
    Cells(3, 16).Value = Cells(Z, 9).Value
    Cells(3, 17).Value = Cells(Z, 11).Value
    Cells(3, 17).NumberFormat = "0.00%"
ElseIf Cells(Z, 12).Value = Application.WorksheetFunction.Max(WS.Range("L2:L" & YearlyChangeLastrow)) Then
    Cells(4, 16).Value = Cells(Z, 9).Value
    Cells(4, 17).Value = Cells(Z, 12).Value
    
    
    End If
    
    Next Z
    
    WS.Columns("I:Q").AutoFit
    
Next WS

    



    
    
    
    

'
End Sub
