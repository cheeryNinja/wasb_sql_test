-- Query to calculate the largest expensors who expensed more than 1000
-- of goods or services in SExI
--------------------------------------------------------------------------------------
-- Result:
--   - employee_id - A unique identifier of employee
--   - employee_name - Employee's full name
--   - manager_id - A unique identifier of manager
--   - manager_name - Manager's full name
--   - total_expensed_amount - Total expensed amount 

USE memory.default;

SELECT 
    e.employee_id, 
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name, 
    e.manager_id, 
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name, 
    SUM(exp.unit_price * exp.quantity) AS total_expensed_amount -- Total expensed amount
FROM 
    memory.default.EMPLOYEE e
LEFT JOIN 
    memory.default.EXPENSE exp ON e.employee_id = exp.employee_id
LEFT JOIN 
    memory.default.EMPLOYEE m ON e.manager_id = m.employee_id
GROUP BY 
    e.employee_id, e.first_name, e.last_name, e.manager_id, m.first_name, m.last_name
HAVING 
    SUM(exp.unit_price * exp.quantity) > 1000 -- Include only employees who expensed more than 1000
ORDER BY 
    total_expensed_amount DESC;