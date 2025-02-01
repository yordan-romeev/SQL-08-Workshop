USE CompanyDB
GO

--Retrieve all clients' names and contact emails.

SELECT name, contact_email
FROM Clients

--List all overdue invoices with the client's name.

SELECT i.invoice_id, c.name as ClientName, i.due_date, i.amount, i.[status]
FROM Invoices i 
JOIN Clients c ON c.client_id = i.client_id
WHERE i.[status] = 'Overdue'

--Find all payments made by bank transfer.

SELECT *
FROM Payments
WHERE payment_method = 'Bank Transfer'

--Show the total revenue received from paid invoices.

SELECT SUM(amount) as TotalRevenue
FROM Invoices
WHERE [status] = 'Paid'

--Count the number of invoices per status (Pending, Paid, Overdue).

SELECT [status], count(*) as NumberOfInvoices
FROM Invoices
GROUP BY [status]