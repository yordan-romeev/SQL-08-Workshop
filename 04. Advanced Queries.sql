USE CompanyDB
GO

-- Retrieve all transactions for a specific supplier (e.g., supplier_id = 3).

SELECT *
FROM Transactions
WHERE supplier_id = 3

-- List the top 5 highest-paid employees.

SELECT TOP 5 * 
FROM Employees
ORDER BY salary DESC 

-- Find all employees hired in the last 3 years.

SELECT *
FROM Employees
WHERE DATEDIFF(year, hire_date, GETDATE()) <= 3

-- Calculate the total expenses for January 2024.

SELECT sum(amount)
FROM Transactions
WHERE MONTH(transaction_date) = 1
    AND YEAR(transaction_date) = 2024
    AND transaction_type = 'Expense'

-- Find the highest and lowest invoice amounts.

SELECT MAX(amount) AS highest_Invoice_Amount, MIN(amount) AS lowest_invoice_amount
FROM Invoices

-- highest amount invoice

SELECT * 
FROM Invoices
WHERE amount = (SELECT MAX(amount) FROM Invoices)

-- lowest amount invoice

SELECT * 
FROM Invoices
WHERE amount = (SELECT MIN(amount) FROM Invoices)
