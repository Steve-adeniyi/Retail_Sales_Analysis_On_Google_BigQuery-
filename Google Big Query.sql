Practical exercise (Google Big Query) SCRIPT

---WHERE Clause 

Q1. Filter all transactions that occurred in the year 2023. 
Expected output: All columns 


SELECT *
FROM `elemental-kite-481618-k0.Retail.Sales`
WHERE EXTRACT(YEAR FROM `Date`) = 2023;

---Filtering + Conditions 

Q2. Display all transactions where the Total Amount is more than the average Total Amount of the entire dataset.
 Expected output: All columns 


SELECT 
  'Transaction ID',
  'Customer ID', 
  `Total Amount` AS Total_Amount, 
   Date
FROM `elemental-kite-481618-k0.Retail.Sales`
WHERE `Total Amount` >
      (SELECT AVG(`Total Amount`)
       FROM `elemental-kite-481618-k0.Retail.Sales`);
	   

---Aggregate Functions
 Q3. Calculate the total revenue (sum of Total Amount). Expected output: Total_Revenue

 SELECT
  SUM(`Total Amount`) AS Total_Revenue
FROM `elemental-kite-481618-k0.Retail.Sales`;


---	DISTINCT
 Q4. Display all distinct Product Categories in the dataset. 
Expected output: Product_Category 

   SELECT DISTINCT
   'Product Category'
FROM `elemental-kite-481618-k0.Retail.Sales`; 


---GROUP BY
 Q5. For each Product Category, calculate the total quantity sold. 
Expected output: Product Category, Total Quantity

SELECT 
  `Product Category`,
  SUM(Quantity) AS Total_Quantity
FROM `elemental-kite-481618-k0.Retail.Sales`
GROUP BY `Product Category`;

---CASE Statement 
Q6. Create a column called Age_Group that classifies customers as ‘Youth’ (<30), ’Adult’ (30-59), ‘Senior’ (60+)
Expected output: Customer_ID, Age, Age_Group


SELECT
  `Customer ID`,
  Age,
  CASE
    WHEN Age < 30 THEN '01.Youth'
    WHEN Age BETWEEN 30 AND 59 THEN '02.Adult'
    ELSE '03.Senior'
  END AS Age_Group
FROM `elemental-kite-481618-k0.Retail.Sales`;


--- Conditional Aggregation
Q7. For each Gender, count how many high-value transactions occurred (where the Total Amount > 500). 
Expected output: Gender, High_Value_Transactions

SELECT
  Gender,
  COUNTIF(`Total Amount` > 500) AS High_Value_Transaction
FROM `elemental-kite-481618-k0.Retail.Sales`
GROUP BY Gender;

---HAVING Clause 
Q8. For each Product Category, show only those categories where the total revenue exceeds 5,000. Expected output: Product_Category, Total_Revenue

SELECT
  `Product Category`,
  SUM(`Total Amount`) AS Total_Revenue
FROM `elemental-kite-481618-k0.Retail.Sales`
GROUP BY `Product Category`
HAVING SUM(`Total Amount`) > 5000;


---Calculated Fields
 Q9. Display a new column called Unit_Cost_Category that labels a transaction as: – 'Cheap' if Price per Unit < 50 – 'Moderate' if Price per Unit between 50 and 200 – 'Expensive' if Price per Unit > 200
 Expected output: Transaction_ID, Price_per_Unit, Unit_Cost_Category
 
 SELECT
 `Transaction ID`,
  `Price per Unit`,
  CASE
  WHEN `Price per Unit` < 50 THEN '01.Cheap'
  WHEN `Price per Unit` BETWEEN 50 AND 200 THEN '02.Moderate'
  ELSE '0.3 Expensive'
  END AS Unit_Cost_Category
  FROM `elemental-kite-481618-k0.Retail.Sales`;

 
 ---Combining WHERE + CASE
 Q10. Display all transactions from customers aged 40 or older and add a column Spending_Level showing ‘High’ if Total Amount > 1000, otherwise ‘Low’. 
Expected output: Customer_ID, Age, Total_Amount, Spending_Level

SELECT
 Age,
 `Customer ID`,
 `Total Amount`,
 CASE
  WHEN`Total Amount` > 1000 THEN '01.High'
  ELSE '02.Low'
  END AS Spend_Level
FROM `elemental-kite-481618-k0.Retail.Sales`
WHERE Age >=40;
