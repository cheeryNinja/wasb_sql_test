-- Create a new EXPENSE table in the memory.default schema
--------------------------------------------------------------------------------------
-- The table has three columns:
--   - employee_id: The ID of the employee associated with the expense (TINYINT)
--   - unit_price: The price per unit of the item or service (DECIMAL with 2 decimal places)
--   - quantity: The number of units purchased or expensed (TINYINT)

DROP TABLE IF EXISTS memory.default.EXPENSE;

CREATE TABLE IF NOT EXISTS memory.default.EXPENSE (
    employee_id TINYINT,
    unit_price DECIMAL(8,2),
    quantity TINYINT
);


-- Insert data into the EXPENSE table
-- Data from finance/receipts_from_last_night/*
--------------------------------------------------------------------------------------

INSERT INTO memory.default.EXPENSE (employee_id, unit_price, quantity)
VALUES
	(3, 6.50, 14),
	(3, 11.00, 20),
	(3, 22.00, 18),
	(3, 13.00, 75),
	(9, 300.00, 1),
	(4, 40.00, 9),
	(2, 17.50, 4);

