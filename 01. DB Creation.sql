CREATE DATABASE CompanyDB;
GO
USE CompanyDB;
GO

CREATE TABLE Clients (
    client_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    contact_email NVARCHAR(255),
    phone NVARCHAR(50),
    address NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Suppliers (
    supplier_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    contact_email NVARCHAR(255),
    phone NVARCHAR(50),
    address NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Employees (
    employee_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    position NVARCHAR(100),
    salary DECIMAL(10,2),
    hire_date DATE,
    department NVARCHAR(100)
);
GO

CREATE TABLE Invoices (
    invoice_id INT IDENTITY(1,1) PRIMARY KEY,
    client_id INT,
    issue_date DATE,
    due_date DATE,
    amount DECIMAL(12,2),
    tax_rate DECIMAL(5,2),
    vat DECIMAL(10,2),
    discount DECIMAL(10,2),
    currency NVARCHAR(10),
    status NVARCHAR(20) CHECK (status IN ('Pending', 'Paid', 'Overdue')),
    FOREIGN KEY (client_id) REFERENCES Clients(client_id) ON DELETE CASCADE
);
GO

CREATE TABLE Payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    invoice_id INT,
    payment_date DATE,
    amount DECIMAL(12,2),
    payment_method NVARCHAR(20) CHECK (payment_method IN ('Bank Transfer', 'Credit Card', 'Cash')),
    bank_name NVARCHAR(255),
    transaction_id NVARCHAR(50),
    FOREIGN KEY (invoice_id) REFERENCES Invoices(invoice_id) ON DELETE CASCADE
);
GO

CREATE TABLE Transactions (
    transaction_id INT IDENTITY(1,1) PRIMARY KEY,
    supplier_id INT,
    employee_id INT,
    transaction_date DATE,
    amount DECIMAL(12,2),
    transaction_type NVARCHAR(10) CHECK (transaction_type IN ('Expense', 'Revenue')),
    category NVARCHAR(50),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) ON DELETE SET NULL,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id) ON DELETE SET NULL
);
GO
