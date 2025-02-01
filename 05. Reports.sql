USE CompanyDB
GO

-- Create a view showing invoices with their corresponding payments.

CREATE VIEW InvoicePayments
AS
SELECT i.invoice_id, i.issue_date, i.due_date, i.[status], p.payment_method, p.payment_date 
FROM Invoices i 
LEFT JOIN Payments p ON p.invoice_id = i.invoice_id

GO
-- Create a report showing monthly revenue for the year 2024.

SELECT MONTH(issue_date) as Month, SUM(amount) AS Revenue
FROM Invoices
WHERE [status] = 'Paid'
GROUP BY MONTH(issue_date)

GO

-- Find the total amount paid per client.

SELECT i.client_id, c.name, SUM(amount) as AmountPaid
FROM Invoices i
JOIN Clients c ON c.client_id = i.client_id
WHERE [status] = 'Paid'
GROUP BY i.client_id, c.name

GO

-- List all invoices along with their VAT amounts.

SELECT invoice_id, amount, tax_rate, vat
FROM Invoices

GO

-- Find the total payments received per payment method.

SELECT payment_method, SUM(amount) as TotalPayentsReceived
FROM Payments
GROUP BY payment_method

GO 

-- Write a stored procedure to fetch all invoices for a given client ID.

CREATE PROC GetInvoicesForClient @ClientID INT
AS
BEGIN
    SELECT * FROM Invoices WHERE client_id = @ClientID
END

GO

-- Sample Usage 

EXEC GetInvoicesForClient 3
GO

-- Find the percentage of overdue invoices relative to total invoices.

SELECT  COUNT(CASE WHEN [status] = 'Overdue' THEN 1 END) AS OverdueInvoices, 
        COUNT(*) AS Total_Invoices, 
        CAST(CAST(COUNT(CASE WHEN [status] = 'Overdue' THEN 1 END) AS DECIMAL)/ CAST(COUNT(*) AS DECIMAL) * 100 AS DECIMAL(10,2) )  AS Percent_Overdue_Invoices
FROM Invoices

-- Generate a report showing the top 3 clients who have paid the most.

SELECT TOP 3 c.client_id, c.name, SUM(i.amount)
FROM Clients c 
JOIN Invoices i ON i.client_id = c.client_id
WHERE i.[status] = 'Paid'
GROUP BY c.client_id, c.name
ORDER BY SUM(i.amount) DESC

-- (Optional) Create an index on the Payments table for faster lookups on invoice_id.

CREATE NONCLUSTERED INDEX IX_Payment_InvoiceID
ON Payments (invoice_id);
GO