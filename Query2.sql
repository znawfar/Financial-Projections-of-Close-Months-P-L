
--I have a database entity diagram for a company.
--In this section, I will create these data tables and allocate some values to all of them. 

-- 1- Client_Clusters: 
CREATE TABLE Client_Clusters (
    ID_Client_Clusters int         identity(1,1) NOT NULL,
    Name varchar(2)                              NOT NULL,
   PRIMARY KEY ( ID_Client_Clusters )
);

INSERT INTO Client_Clusters (ID_Client_Clusters, Name) VALUES (1,'Famous_Company');
INSERT INTO Client_Clusters (ID_Client_Clusters, Name) VALUES (2,'Unknown_Company');

------------------------------------------------------------------------------------------------
-- 2- Regiens: 
CREATE TABLE Regiens (
    ID_Regiens int            identity(1,1) NOT NULL,
    Regiens_Name varchar(2)                 NOT NULL,
   PRIMARY KEY ( ID_Regiens )
);

INSERT INTO Regiens (ID_Regiens, Regiens_Name) VALUES (1,'USA');
INSERT INTO Regiens (ID_Regiens, Regiens_Name) VALUES (2,'UK');

-------------------------------------------------------------------------------------------------
--3- Categories:
CREATE TABLE Categories (
    ID_Categories int            identity(1,1) NOT NULL,
    Categories_Name varchar(3)                 NOT NULL,
   PRIMARY KEY ( ID_Categories )
);

INSERT INTO Categories (ID_Categories, Categories_Name) VALUES (1,'Chocolate');
INSERT INTO Categories (ID_Categories, Categories_Name) VALUES (2,'Biscuit');
INSERT INTO Categories (ID_Categories, Categories_Name) VALUES (3,'Candy');


--------------------------------------------------------------------------------------------------
-- 4- Products: 
CREATE TABLE Products (
    ID_Products int     identity(1,1) NOT NULL,
    Products_Name varchar(3)          NOT NULL,
    ID_Categories int,
    PRIMARY KEY (ID_Products),
    FOREIGN KEY (ID_Categories) REFERENCES Categories(ID_Categories)
);


INSERT INTO Products (ID_Products, Products_Name, ID_Categories) VALUES (1,'WhiteChocolate',1);
INSERT INTO Products (ID_Products, Products_Name, ID_Categories) VALUES (2,'BiscuitLogo',2);
INSERT INTO Products (ID_Products, Products_Name, ID_Categories) VALUES (3,'GummiCandy',3);

---------------------------------------------------------------------------------------------------
-- 5- Clients:

CREATE TABLE Clients (
    ID_Clients int     identity(1,1) NOT NULL,
    Clients_Name varchar(6)          NOT NULL,
    ID_Client_Clusters int,
    ID_Regiens int,
    PRIMARY KEY (ID_Clients),
    FOREIGN KEY (ID_Client_Clusters) REFERENCES Client_Clusters(ID_Client_Clusters)
    FOREIGN KEY (ID_Regiens) REFERENCES Regiens(ID_Regiens)
 );


INSERT INTO Clients (ID_Clients, Clients_Name, ID_Client_Clusters, ID_Regiens) VALUES (1,'Pat',1,2);
INSERT INTO Clients (ID_Clients, Clients_Name, ID_Client_Clusters, ID_Regiens) VALUES (2,'Kay',1,1);
INSERT INTO Clients (ID_Clients, Clients_Name, ID_Client_Clusters, ID_Regiens) VALUES (3,'Jon',2,1);
INSERT INTO Clients (ID_Clients, Clients_Name, ID_Client_Clusters, ID_Regiens) VALUES (4,'Jenny',2,2);
INSERT INTO Clients (ID_Clients, Clients_Name, ID_Client_Clusters, ID_Regiens) VALUES (5,'David',1,1);
INSERT INTO Clients (ID_Clients, Clients_Name, ID_Client_Clusters, ID_Regiens) VALUES (6,'Sarah',1,2);


-------------------------------------------------------------------------------------------------------
-- 6- Regions_Products

CREATE TABLE Regions_Products (
    ID_Regions_Products int     identity(1,1) NOT NULL,
    ID_Products int,
    ID_Regiens int,
    PRIMARY KEY (ID_Regions_Products),
    FOREIGN KEY (ID_Products) REFERENCES Products(ID_Products)
    FOREIGN KEY (ID_Regiens) REFERENCES Regiens(ID_Regiens)
 );


INSERT INTO Regions_Products (ID_Regions_Products, ID_Products, ID_Regiens) VALUES (1,3,1);
INSERT INTO Regions_Products (ID_Regions_Products, ID_Products, ID_Regiens) VALUES (2,1,2);
INSERT INTO Regions_Products (ID_Regions_Products, ID_Products, ID_Regiens) VALUES (3,2,1);
INSERT INTO Regions_Products (ID_Regions_Products, ID_Products, ID_Regiens) VALUES (4,2,2);
INSERT INTO Regions_Products (ID_Regions_Products, ID_Products, ID_Regiens) VALUES (5,3,2);
 
 
------------------------------------------------------------------------------------------------------ 

 -- 7- Sales
 
 CREATE TABLE Sales(
    ID_Sales int     identity(1,1)   NOT NULL,
    ID_Clients int,
    ID_Regions_Products int,
    Amount_Sales DECIMAL(2)          NOT NULL,
    Transaction_Date  DATETIME       NOT NULL,
    PRIMARY KEY (ID_Regions_Products),
    FOREIGN KEY (ID_Clients) REFERENCES Clients(ID_Clients)
    FOREIGN KEY (ID_Regions_Products) REFERENCES Regions_Products(ID_Regions_Products)
 );
 

INSERT INTO SALES (ID_Sales,ID_Clients, ID_Regions_Products, Amount_Sales, Transaction_Date) 
VALUES (1,2,2, 2100.33,'2022-04-10');
INSERT INTO SALES (ID_Sales,ID_Clients, ID_Regions_Products, Amount_Sales, Transaction_Date) 
VALUES (2,5,3, 3213.55,'2022-02-16');
INSERT INTO SALES (ID_Sales,ID_Clients, ID_Regions_Products, Amount_Sales, Transaction_Date) 
VALUES (3,3,1, 6543.32,'2022-03-11');
INSERT INTO SALES (ID_Sales,ID_Clients, ID_Regions_Products, Amount_Sales, Transaction_Date) 
VALUES (4,1,4, 4100.75,'2022-08-19');
INSERT INTO SALES (ID_Sales,ID_Clients, ID_Regions_Products, Amount_Sales, Transaction_Date) 
VALUES (5,6,5, 1245.91,'2022-05-14');


---------------------------------------------------------------------------------------------------------

-- 8-Discounts

 CREATE TABLE Discounts(
    ID_Discounts int     identity(1,1)          NOT NULL,
	Account_Discounts int                   NOT NULL,
	Description_Discounts varchar(2)        NOT NULL,
	Amount_Discounts DECIMAL(2)             NOT NULL,
    Transaction_Discounts_Date  DATETIME        NOT NULL,
	ID_Sales int                            NOT NULL,
    PRIMARY KEY (ID_Discounts),
    FOREIGN KEY (ID_Sales) REFERENCES Sales(ID_Sales)
 );
 
INSERT INTO Discounts (ID_Discounts,Account_Discounts, Description_Discounts, Amount_Discounts,Transaction_Discounts_Date, ID_Sales) 
VALUES (1,25600, 'Special', 50.33,'2022-05-11',1);
INSERT INTO Discounts (ID_Discounts,Account_Discounts, Description_Discounts, Amount_Discounts, Transaction_Discounts_Date, ID_Sales) 
VALUES (2,25600, 'Special', 69.50,'2022-03-18',2);
INSERT INTO Discounts (ID_Discounts,Account_Discounts, Description_Discounts, Amount_Discounts, Transaction_Discounts_Date, ID_Sales) 
VALUES (3,872549,'Ordinary', 100.24,'2022-04-08',3);
INSERT INTO Discounts (ID_Discounts,Account_Discounts, Description_Discounts, Amount_Discounts, Transaction_Discounts_Date, ID_Sales) 
VALUES (4,25600, 'Special', 154.16,'2022-09-19',4);
INSERT INTO Discounts (ID_Discounts,Account_Discounts, Description_Discounts, Amount_Discounts, Transaction_Discounts_Date, ID_Sales) 
VALUES (5,872549, 'Ordinary', 72.12,'2022-06-11',5);



---------------------------------------------------------------------------------------------------------

-- 9- Cost_of_Good_Solds

 CREATE TABLE Cost_of_Good_Solds(
    ID_Cost_Solds int     identity(1,1)           NOT NULL,
	Account_Cost_Solds int                    NOT NULL,
	Description_Cost_Solds varchar(100)       NOT NULL,
	Amount_Cost_Solds DECIMAL(2)              NOT NULL,
    Transaction_Cost_SoldsDate  DATETIME          NOT NULL,
	ID_Sales int                              NOT NULL,
    PRIMARY KEY (ID_Cost_Solds),
    FOREIGN KEY (ID_Sales) REFERENCES Sales(ID_Sales)
 );


INSERT INTO Cost_of_Good_Solds (ID_Cost_Solds, Account_Cost_Solds, Description_Cost_Solds, Amount_Cost_Solds, Transaction_Cost_SoldsDate, ID_Sales) 
VALUES (1,25600, 'Low', 2050.00,'2022-05-25',1);
INSERT INTO Cost_of_Good_Solds (ID_Cost_Solds, Account_Cost_Solds, Description_Cost_Solds, Amount_Cost_Solds, Transaction_Cost_SoldsDate, ID_Sales) 
VALUES (2,25600, 'Medium', 3144.05,'2022-03-20',2);
INSERT INTO Cost_of_Good_Solds (ID_Cost_Solds, Account_Cost_Solds, Description_Cost_Solds, Amount_Cost_Solds, Transaction_Cost_SoldsDate, ID_Sales) 
VALUES (3,872549,'High', 6443.08,'2022-04-18',3);
INSERT INTO Cost_of_Good_Solds (ID_Cost_Solds, Account_Cost_Solds, Description_Cost_Solds, Amount_Cost_Solds, Transaction_Cost_SoldsDate, ID_Sales) 
VALUES (4,25600, 'Low', 3946.59,'2022-09-29',4);
INSERT INTO Cost_of_Good_Solds (ID_Cost_Solds, Account_Cost_Solds, Description_Cost_Solds, Amount_Cost_Solds, Transaction_Cost_SoldsDate, ID_Sales) 
VALUES (5,872549, 'High', 1173.79,'2022-06-19',5);


---------------------------------------------------------------------------------------------------------

-- 10- Operating_Expenses
 CREATE TABLE Operating_Expenses(
    ID_Operating_Expenses int     identity(1,1)           NOT NULL,
	Account_Operating_Expenses int                    NOT NULL,
	Description_Operating_Expenses varchar(100)       NOT NULL,
	Amount_Operating_Expenses DECIMAL(2)              NOT NULL,
    Transaction_Operating_Expenses DATETIME               NOT NULL,
	ID_Sales int                                      NOT NULL,
    PRIMARY KEY (ID_Operating_Expenses),
    FOREIGN KEY (ID_Sales) REFERENCES Sales(ID_Sales)
 );
 
INSERT INTO Operating_Expenses (ID_Operating_Expenses, Account_Operating_Expenses, Description_Operating_Expenses, Amount_Operating_Expenses, Transaction_Operating_Expenses, ID_Sales) 
VALUES (1,869754, 'Medium', 59.17,'2022-04-21',1);
INSERT INTO Operating_Expenses (ID_Operating_Expenses, Account_Operating_Expenses, Description_Operating_Expenses, Amount_Operating_Expenses, Transaction_Operating_Expenses, ID_Sales) 
VALUES (2,869754, 'Medium', 78.15,'2022-02-24',2);
INSERT INTO Operating_Expenses (ID_Operating_Expenses, Account_Operating_Expenses, Description_Operating_Expenses, Amount_Operating_Expenses, Transaction_Operating_Expenses, ID_Sales) 
VALUES (3,102356,'Low', 102.78,'2022-03-29',3);
INSERT INTO Operating_Expenses (ID_Operating_Expenses, Account_Operating_Expenses, Description_Operating_Expenses, Amount_Operating_Expenses, Transaction_Operating_Expenses, ID_Sales) 
VALUES (4,524567, 'High', 99.99,'2022-08-21',4);
INSERT INTO Operating_Expenses (ID_Operating_Expenses, Account_Operating_Expenses, Description_Operating_Expenses, Amount_Operating_Expenses, Transaction_Operating_Expenses, ID_Sales) 
VALUES (5,102356, 'Low', 31.44,'2022-07-14',5);

 
 
 



















--------------------
