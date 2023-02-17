
-- 1- Current Net_Sales($)  ===>  (Net Sales = Revenue - Discounts)

SELECT (Pay.Payable - Credit.Credit_Dis) AS Company_Net_Sales
From
	(SELECT Sum(Amount_Sales) as Payable FROM Sales) AS Pay,
	(SELECT Sum(Amount_Discounts) as Credit_Dis FROM Discounts) AS Credit;

---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
-- 2- Sales Growth(%)  ===>  (Net Sales(Current Year) / Net Sales(Previous Year)) 
-- This code is valid to be tested in SQLite beause I have writen 'strftime' for extracting year of a datetime data type.

SELECT (Pay.Payable - Credit.Credit_Dis) AS Company_Net_Sales, Pay.Year
	FROM 
		(SELECT Sum(Amount_Sales) as Payable, strftime('%Y',Transaction_Date) AS Year FROM Sales GROUP BY strftime('%Y',Transaction_Date)) AS Pay
		LEFT JOIN (SELECT Sum(Amount_Discounts) as Credit_Dis, strftime('%Y',Transaction_Discounts_Date) AS Year FROM Discounts GROUP BY strftime('%Y',Transaction_Discounts_Date)) AS Credit
		ON Pay.Year = Credit.Year
	
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
-- 3- Contribution(%)  ===>  (Net Sales / Company Net Sales)

SELECT (Seperate_Net_Sales.Net_Sales / Company_Net_Sales.Net_Sales) AS Contribution
From
	(SELECT (Pay.Payable - Credit.Credit_Dis) AS Net_Sales
	From
		(SELECT Sum(Amount_Sales) as Payable FROM Sales) AS Pay,
		(SELECT Sum(Amount_Discounts) as Credit_Dis FROM Discounts) AS Credit) AS Company_Net_Sales,
		
	(SELECT (IFNULL(Pay.Payable,0) - IFNULL(Credit.Credit_Dis,0)) AS Net_Sales, IFNULL(Pay.Month,Credit.Month), IFNULL(Pay.Year,Credit.Year)
	FROM 
		(SELECT Sum(Amount_Sales) as Payable, strftime('%m',Transaction_Date) AS Month, strftime('%Y',Transaction_Date) AS Year FROM Sales GROUP BY strftime('%m',Transaction_Date), strftime('%Y',Transaction_Date)) AS Pay
		FULL JOIN (SELECT Sum(Amount_Discounts) as Credit_Dis, strftime('%m',Transaction_Discounts_Date) AS Month, strftime('%Y',Transaction_Discounts_Date) AS Year  FROM Discounts GROUP BY strftime('%m',Transaction_Discounts_Date), strftime('%Y',Transaction_Discounts_Date)) AS Credit
		ON Pay.Month = Credit.Month AND Pay.Year = Credit.Year) AS Seperate_Net_Sales;
		
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
-- 4- Discount (%)   ===>  (Discounts / Revenue)

SELECT (Credit.Credit_Dis / Pay.Payable) AS DiscountPercentage
From
	(SELECT Sum(Amount_Discounts) as Credit_Dis FROM Discounts) AS Credit,
	(SELECT Sum(Amount_Sales) as Payable FROM Sales) AS Pay;

---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
