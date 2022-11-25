


-- 1- Current Net_Sales($)  ===>  (Net Sales = Revenue - Discounts)

SELECT (Pay.Payable - Credit.Credit_Dis) AS Company_Net_Sales
From
	(SELECT Sum(Amount_Sales) as Payable FROM Sales) AS Pay,
	(SELECT Sum(Amount_Discounts) as Credit_Dis FROM Discounts) AS Credit;
	
	
------------------------------------------------------------------------------------
-- 2- Sales Growth(%)  ===>  (Net Sales(Current Year) / Net Sales(Previous Year)) 

SELECT Rec.Month, Rec.Year, (Rec.Received / Pay.Payable) AS ProfitLoss
From
	(SELECT Receivable.Month, Receivable.Year, Sum(Receivable.SalesAmount) AS Received
	From
	
		(SELECT DATENAME(MONTH, Sales.Sale_Dateamount) AS Month,
			DATENAME(YEAR, Sales.Sale_Dateamount) AS Year,
			Sales.Amount AS SalesAmount
			FROM Sales) AS Receivable 
		Group By Receivable.Month, Receivable.Year) AS Rec,
	(SELECT Sum(Employees.annual_Salary / 12) as Payable FROM Employees) AS Pay
Order by Year, Month Desc;
--------


SELECT (Pay.Payable - Credit.Credit_Dis) AS Company_Net_Sales
From
	(SELECT Sum(Amount_Sales) as Payable FROM Sales) AS Pay,
	(SELECT Sum(Amount_Discounts) as Credit_Dis FROM Discounts) AS Credit



SELECT
    YEAR(orderdate) AS orderyear,
    SUM(val) AS curtotalsales,
    LAG(SUM(val)) OVER(ORDER BY YEAR(orderdate))  AS prevtotalsales 
FROM Sales.OrderValues 
GROUP BY YEAR(orderdate)
ORDER BY orderyear



SELECT  year,
        revenue,
        revenue - LAG (revenue) OVER (ORDER BY year ASC) AS revenue_growth,
        LEAD (revenue, 2) OVER (ORDER BY year ASC) AS next_year_revenue
FROM monthly_revenue;
	(SELECT (Pay.Payable - Credit.Credit_Dis) AS Company_Net_Sales
	From
		(SELECT Sum(Amount_Sales) as Payable FROM Sales) AS Pay,
		(SELECT Sum(Amount_Discounts) as Credit_Dis FROM Discounts) AS Credit) AS NETSALES_COM;


-------------------------------------------------------------------------------------
-- 3- Contribution(%)  ===>  (Net Sales / Company Net Sales)

SELECT (Seperate_Net_Sales.Sep_Net_Sales / Company_Net_Sales.Net_Sales) AS Contribution
From
	(SELECT (Pay.Payable - Credit.Credit_Dis) AS Net_Sales
	From
		(SELECT Sum(Amount_Sales) as Payable FROM Sales) AS Pay,
		(SELECT Sum(Amount_Discounts) as Credit_Dis FROM Discounts) AS Credit) AS Company_Net_Sales,
		
	(SELECT (Sep_Pay.Seperate_Payable - Sep_Credit.Seperate_Credit_Dis) AS Sep_Net_Sales
	From
		(SELECT Amount_Sales as Seperate_Payable FROM Sales) AS Sep_Pay,
		(SELECT Amount_Discounts as Seperate_Credit_Dis FROM Discounts) AS Sep_Credit) AS Seperate_Net_Sales;
		

-------------------------------------------------------------------------------------
-- 4- Discount (%)   ===>  (Discounts / Revenue)

SELECT (Credit.Credit_Dis / Pay.Payable) AS DiscountPercentage
From
	(SELECT Sum(Amount_Discounts) as Credit_Dis FROM Discounts) AS Credit,
	(SELECT Sum(Amount_Sales) as Payable FROM Sales) AS Pay;


--------------------------------------------------------------------------------------