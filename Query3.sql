
--I am going to obtain the Net profit using following maths:

-- Revenue - Discount = Net Sales - Cost of Goods Solds = Cross Profit - Expenses = Net Profit


------------------------------------------------------------------------------------------------------------
--Part 1: Net Sales
SELECT (Pay.Payable - Credit.Credit_Dis) AS Net_Sales
From
	(SELECT Sum(Amount_Sales) as Payable FROM Sales) AS Pay,
	(SELECT Sum(Amount_Discounts) as Credit_Dis FROM Discounts) AS Credit;


-------------------------------------------------------------------------------------------------------------
--Part 2: Cross Profit 
SELECT (NetSales.Net_Sales - GoodSolds.Good_Solds) AS Cross_Profit 
From
	(SELECT (Pay.Payable - Credit.Credit_Dis) AS Net_Sales
	From
		(SELECT Sum(Amount_Sales) as Payable FROM Sales) AS Pay,
		(SELECT Sum(Amount_Discounts) as Credit_Dis FROM Discounts) AS Credit) AS NetSales,
	(SELECT Sum(Amount_Cost_Solds) as Good_Solds FROM Cost_of_Good_Solds) AS GoodSolds;
	
	
--------------------------------------------------------------------------------------------------------
--Part 3: Net Profit
SELECT (CrossProfit.Cross_Profit - OperatingExpenses.OperatingEx) AS Net_Profit 
From
	(SELECT (NetSales.Net_Sales - GoodSolds.Good_Solds) AS Cross_Profit 
	From
		(SELECT (Pay.Payable - Credit.Credit_Dis) AS Net_Sales
		From
			(SELECT Sum(Amount_Sales) as Payable FROM Sales) AS Pay,
			(SELECT Sum(Amount_Discounts) as Credit_Dis FROM Discounts) AS Credit) AS NetSales,
		(SELECT Sum(Amount_Cost_Solds) as Good_Solds FROM Cost_of_Good_Solds) AS GoodSolds) AS CrossProfit,
	(SELECT Sum(Amount_Operating_Expenses) as OperatingEx FROM Operating_Expenses) AS OperatingExpenses;



