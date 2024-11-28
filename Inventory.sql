-- Create the table
CREATE TABLE Superstore_Inventory (
    Branch_ID VARCHAR(10),
    Branch_Location VARCHAR(50),
    Item_ID VARCHAR(20),
    Item_Name VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    Reorder_Level INT,
    Unit_Price DECIMAL(10, 2),
    Supplier VARCHAR(50),
    Last_Stocked_Date DATE,
    Expiry_Date DATE,
    Status VARCHAR(20),
    PRIMARY KEY (Item_ID)
);

-- Insert sample data
INSERT INTO Superstore_Inventory (
    Branch_ID, Branch_Location, Item_ID, Item_Name, Category, Quantity, 
    Reorder_Level, Unit_Price, Supplier, Last_Stocked_Date, Expiry_Date, Status
)
VALUES
    ('B001', 'New York', 'ITEM1234', 'Item_101', 'Electronics', 30, 50, 199.99, 'Supplier_A', '2023-07-15', '2024-07-15', 'Low Stock'),
    ('B002', 'Los Angeles', 'ITEM5678', 'Item_202', 'Groceries', 100, 20, 9.99, 'Supplier_B', '2023-05-10', '2023-12-31', 'In Stock'),
    ('B003', 'Chicago', 'ITEM9101', 'Item_303', 'Clothing', 0, 10, 49.99, 'Supplier_C', '2023-06-01', '2024-01-01', 'Out of Stock'),
    ('B004', 'Houston', 'ITEM3456', 'Item_404', 'Home Supplies', 75, 50, 29.99, 'Supplier_D', '2023-04-20', '2023-10-20', 'In Stock'),
    ('B001', 'New York', 'ITEM5679', 'Item_501', 'Electronics', 120, 100, 399.99, 'Supplier_A', '2023-06-25', '2024-06-25', 'In Stock'),
    ('B002', 'Los Angeles', 'ITEM3457', 'Item_602', 'Groceries', 5, 30, 5.49, 'Supplier_B', '2023-08-10', '2023-12-01', 'Low Stock'),
    ('B003', 'Chicago', 'ITEM7890', 'Item_703', 'Clothing', 20, 25, 79.99, 'Supplier_C', '2023-07-01', '2024-01-01', 'Low Stock'),
    ('B004', 'Houston', 'ITEM1011', 'Item_804', 'Home Supplies', 200, 150, 15.99, 'Supplier_D', '2023-05-15', '2024-05-15', 'In Stock'),
    ('B001', 'New York', 'ITEM1213', 'Item_905', 'Electronics', 50, 40, 299.99, 'Supplier_A', '2023-09-01', '2024-09-01', 'In Stock'),
    ('B002', 'Los Angeles', 'ITEM1415', 'Item_1006', 'Groceries', 0, 10, 3.99, 'Supplier_B', '2023-03-10', '2023-09-30', 'Out of Stock'),
     ('B003', 'Chicago', 'ITEM1617', 'Item_1101', 'Electronics', 15, 20, 149.99, 'Supplier_C', '2023-05-20', '2024-01-20', 'Low Stock'),
    ('B004', 'Houston', 'ITEM1819', 'Item_1202', 'Groceries', 80, 50, 7.99, 'Supplier_D', '2023-04-15', '2023-12-10', 'In Stock'),
    ('B001', 'New York', 'ITEM2021', 'Item_1303', 'Clothing', 200, 150, 59.99, 'Supplier_A', '2023-02-05', '2024-02-05', 'In Stock'),
    ('B002', 'Los Angeles', 'ITEM2223', 'Item_1404', 'Home Supplies', 45, 60, 19.99, 'Supplier_B', '2023-06-01', '2024-03-01', 'Low Stock'),
    ('B003', 'Chicago', 'ITEM2425', 'Item_1505', 'Electronics', 0, 30, 249.99, 'Supplier_C', '2023-07-10', '2024-07-10', 'Out of Stock'),
    ('B004', 'Houston', 'ITEM2627', 'Item_1606', 'Groceries', 30, 25, 2.99, 'Supplier_D', '2023-08-05', '2023-11-30', 'In Stock'),
    ('B001', 'New York', 'ITEM2829', 'Item_1707', 'Clothing', 10, 15, 89.99, 'Supplier_A', '2023-09-01', '2024-03-01', 'Low Stock'),
    ('B002', 'Los Angeles', 'ITEM3031', 'Item_1808', 'Home Supplies', 100, 120, 25.49, 'Supplier_B', '2023-03-15', '2024-03-15', 'Low Stock'),
    ('B003', 'Chicago', 'ITEM3233', 'Item_1909', 'Electronics', 90, 75, 199.99, 'Supplier_C', '2023-07-20', '2024-07-20', 'In Stock'),
    ('B004', 'Houston', 'ITEM3435', 'Item_2010', 'Groceries', 0, 10, 4.49, 'Supplier_D', '2023-02-10', '2023-10-15', 'Out of Stock');



-- List all branches along with their total number of items in stock.
select Branch_ID,Item_Name,sum(Quantity) from Superstore_Inventory
group by Branch_ID
order by Item_Name;

-- Find the most expensive item in each category.
SELECT Category, Item_Name, Unit_Price
FROM Superstore_Inventory
WHERE (Category, Unit_Price) IN (
    SELECT Category, MAX(Unit_Price)
    FROM Superstore_Inventory
    GROUP BY Category
)
ORDER BY Category;

-- Retrieve items that need to be reordered (where Quantity < Reorder_Level).
select Item_Name as "Reorder item" from Superstore_Inventory
where Quantity < Reorder_Level;

-- Display all items that were last stocked within the last 90 days.
SELECT Item_ID, Item_Name
FROM Superstore_Inventory
WHERE Last_Stocked_Date between '2023-01-01' and '2023-07-30';

-- Find the total value of items in stock for each branch (Quantity * Unit_Price).
select Branch_ID,sum(Quantity * Unit_Price)as Total_Price from Superstore_Inventory
group by Branch_ID
order by sum(Quantity * Unit_Price);

-- List suppliers and the number of items supplied by each.
select Supplier,sum(Quantity)AS Total_Items_Supplied from Superstore_Inventory
group by Supplier
order by Total_Items_Supplied desc;

-- Retrieve all items whose expiry date is within the next 30 days.
select Item_ID,Item_Name from Superstore_Inventory
WHERE Expiry_Date >= CURRENT_DATE() 
  AND DATEDIFF(Expiry_Date, CURRENT_DATE()) <= 30; 

-- Rank branches based on the total inventory value they hold.
 WITH CTE AS (
    SELECT Branch_ID, 
           SUM(Quantity * Unit_Price) AS Total_Value
    FROM Superstore_Inventory
    GROUP BY Branch_ID
)

SELECT Branch_ID, 
       Total_Value,
       DENSE_RANK() OVER (ORDER BY Total_Value DESC) AS Rank_brnach
FROM CTE
ORDER BY Rank_brnach;

-- Create a report showing category-wise stock summary (total quantity, average price).
select Category,sum(Quantity) as total_quantity,AVG(Unit_Price) AS avg_price from Superstore_Inventory
group by Category
order by total_quantity desc,avg_price;
select * from Superstore_Inventory;

-- Identify the branch with the highest percentage of "Low Stock" items.
SELECT Branch_ID,
       SUM(CASE WHEN Reorder_Level > Quantity THEN Quantity ELSE 0 END) AS Low_Stock_Quantity,
       SUM(Quantity) AS Total_Stock_Quantity,
       (SUM(CASE WHEN Reorder_Level > Quantity THEN Quantity ELSE 0 END) / SUM(Quantity)) * 100 AS Low_Stock_Percentage
FROM Superstore_Inventory
GROUP BY Branch_ID
ORDER BY Low_Stock_Percentage DESC;

-- Find items supplied by multiple suppliers and list the suppliers.
WITH Multi_Supplier_Items AS (
    SELECT Item_ID
    FROM Superstore_Inventory
    GROUP BY Item_ID
    HAVING COUNT(DISTINCT Supplier) > 1
)

-- Step 2: List the suppliers for those items
SELECT si.Item_ID, si.Item_Name, si.Supplier
FROM Superstore_Inventory si
WHERE si.Item_ID IN (SELECT Item_ID FROM Multi_Supplier_Items)
ORDER BY si.Item_ID, si.Supplier;

-- Write a query to automatically flag items as "Expired if the current date exceeds the Expiry_Date.
UPDATE Superstore_Inventory
SET Status = 'Expired'
WHERE Expiry_Date < CURRENT_DATE();
select * from Superstore_Inventory;

-- Generate a monthly trend analysis of the inventory added (based on Last_Stocked_Date).
SELECT 
    YEAR(Last_Stocked_Date) AS Stock_Year,
    MONTH(Last_Stocked_Date) AS Stock_Month,
    SUM(Quantity) AS Total_Stock_Added
FROM 
    Superstore_Inventory
GROUP BY 
    YEAR(Last_Stocked_Date), MONTH(Last_Stocked_Date)
ORDER BY 
    Stock_Year, Stock_Month;