-- Create the SUPPLIER table in the memory.default schema
--------------------------------------------------------------------------------------
-- The table has two columns:
--   - supplier_id: A unique identifier for each supplier (TINYINT)
--   - name: The name of the supplier (VARCHAR)

DROP TABLE IF EXISTS memory.default.SUPPLIER;


CREATE TABLE IF NOT EXISTS memory.default.SUPPLIER (
    supplier_id TINYINT NOT NULL,
    name VARCHAR NOT NULL
);


-- Insert data into the SUPPLIER table
-- Data from finance/invoices_due/*
--------------------------------------------------------------------------------------

INSERT INTO memory.default.SUPPLIER (supplier_id, name)
VALUES
	(1, 'Catering Plus'),
	(2, 'Dave''s Discos'),
	(3, 'Entertainment tonight'),
	(4, 'Party Animals');


-- Create the INVOICE table in the memory.default schema
--------------------------------------------------------------------------------------
-- The table has three columns:
--   - supplier_id: The ID of the supplier associated with the invoice (TINYINT)
--   - invoice_amount: The amount of the invoice (DECIMAL with 2 decimal places)
--   - due_date: The due date of the invoice, calculated as last day of any given month (DATE)


DROP TABLE IF EXISTS memory.default.INVOICE;

CREATE TABLE IF NOT EXISTS memory.default.INVOICE (
    supplier_id TINYINT,
    invoice_amount DECIMAL(8,2),
    due_date DATE
);


-- Insert data into the INVOICE table
-- Data from finance/invoices_due/*
--------------------------------------------------------------------------------------

INSERT INTO memory.default.INVOICE (supplier_id, invoice_amount, due_date)
VALUES
	(4, 6000.00, last_day_of_month(date_add('month', 3, current_date))),
	(1, 2000.00, last_day_of_month(date_add('month', 2, current_date))),
	(1, 1500.00, last_day_of_month(date_add('month', 3, current_date))),
	(2, 500.00, last_day_of_month(date_add('month', 1, current_date))),
	(3, 6000.00, last_day_of_month(date_add('month', 3, current_date)));






