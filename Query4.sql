


-- 1- Current Net_Sales($)  ===>  (Net Sales = Revenue - Discounts)

SELECT (Pay.Payable - Credit.Credit_Dis) AS Company_Net_Sales
From
	(SELECT Sum(Amount_Sales) as Payable FROM Sales) AS Pay,
	(SELECT Sum(Amount_Discounts) as Credit_Dis FROM Discounts) AS Credit;
	
-------------------------------------------------------------------------------------
-- 2- Contribution(%)  ===>  (Net Sales / Company Net Sales)

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
-- 3- Discount (%)   ===>  (Discounts / Revenue)

SELECT (Credit.Credit_Dis / Pay.Payable) AS DiscountPercentage
From
	(SELECT Sum(Amount_Discounts) as Credit_Dis FROM Discounts) AS Credit,
	(SELECT Sum(Amount_Sales) as Payable FROM Sales) AS Pay;


--------------------------------------------------------------------------------------
