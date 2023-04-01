
--1- Here I have written a code to list the sales items (invoices) received in January 2023.
--First, I declare two variables for the month (M) and Year (Y) when I want to fetch the sales voices.
--I have used WITH clause to simplify the long queries and have several subqueries.
--Second, I created the Sales Order joining sales header and details, grouped them over some entities, and then calculated the total sales value. 
--Third, SalesExport was developed by another WITH clause to have the sales invoices for items exported. Here I consider the exchange rate.
--Forth, SalesNonExport was developed to list the sales items for those sold nationwide; here, I have GBP as the main currency as items are sold in the UK.
--Finally, I have Full Column joining SalesExport and SalesNonExport by the union.
-----------------------------------------------------------------------------------------------------------------------------------------------------------

DECLARE @M AS int = 1, @Y AS int = 2023;
  WITH SalesOrders AS (
    SELECT a.order_no, a.customer, a.invoice_date, Sum(b.val) AS SumOfval, b.warehouse, b.product_group_b 
        FROM sys.scheme.opheadm (nolock) a 
            JOIN scheme.opdetm (NOLOCK) b ON a.order_no = b.order_no
    GROUP BY a.order_no, a.customer, a.invoice_date, b.warehouse, b.product_group_b
    HAVING ( MONTH(a.invoice_date) = @M AND YEAR(a.invoice_date) = @Y AND b.warehouse <> 'di' and b.warehouse <> 'dx' and b.warehouse <> 'd' AND b.warehouse <> '' ) 
  ), SalesExport AS (
    SELECT a.*, c.currency, d.exchange_rate, (a.SumOfval/d.exchange_rate) AS Sales_In_GBP
        FROM SalesOrders a
        JOIN scheme.slcustm (NOLOCK) c ON a.customer = c.customer 
        JOIN scheme.ceratem (NOLOCK) d ON c.currency = d.currency_code 
    WHERE (c.currency <> '' AND d.currency_year = (@Y - 2000) AND d.period = @M)
  ), SalesNonExport AS (
    SELECT a.*, 'GBP' AS currency,  1 AS exchange_rate, (a.SumOfval) AS Sales_In_GBP
        FROM SalesOrders a
        JOIN scheme.slcustm (NOLOCK) c ON a.customer = c.customer
        WHERE c.currency = ''
  ), Full_Columns AS (
    ((SELECT * FROM SalesExport) UNION (SELECT * FROM SalesNonExport))
  )
  SELECT * FROM Full_Columns

----------------------------------------------------------------------------------------------------------------


