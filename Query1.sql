
--1- I am goint to write a query which returns each department and their annual cost to the company.

SELECT Costs.Department, SUM(Costs.Annual_Salary) AS TotalCosts
	FROM 
		(SELECT Employees.Department_ID, Employees.Annual_Salary ,Department.Department
		FROM Employees
		FULL JOIN Department
		ON Employees.Department_ID = Department.ID) AS Costs GROUP BY Costs.Department
ORDER BY TotalCosts DESC;



--2- I am going to write a query which returns the total sales amount for each employee who works for the sales
-- department, showing the employees with the highest sales at the top.

SELECT TotalSales.Name, SUM(TotalSales.Amount) AS TotalSales 
	FROM 
		(SELECT Employees.ID, Employees.Name, Employees.Department_ID, Department.Department, Sales.Employee_ID, Sales.Amount
			FROM Employees
			FULL JOIN Department
			ON Employees.department_id = Department.ID
			FULL JOIN Sales
			ON Employees.ID = Sales.Employee_ID) AS TotalSales
	WHERE TotalSales.Amount IS NOT NULL 
	GROUP BY TotalSales.Name
	ORDER BY TotalSales DESC;



--3- I am going to write a query showing the profit/loss for the company by year/month.

SELECT Rec.Month, Rec.Year, (Rec.Received - Pay.Payable) AS ProfitLoss
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

