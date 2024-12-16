-- Query to check for cycles of employees who approve each others expenses in SExI
--------------------------------------------------------------------------------------
-- Result:
--   - employee_id - A unique identifier for each employee
--   - cycle_path - Cycle that represents the expences approval chain

USE memory.default;

WITH RECURSIVE EmployeeHierarchy (emp_id, mgr_id, hierarchy_path) AS (
    -- Start with employees and their direct managers
    SELECT
        employee_id AS emp_id,
        manager_id AS mgr_id,
        CAST(employee_id AS VARCHAR) AS hierarchy_path
    FROM
        memory.default.EMPLOYEE
    WHERE manager_id IS NOT NULL

    UNION ALL

    -- Traverse the hierarchy to find indirect managers
    SELECT
        eh.emp_id,
        e.manager_id,
        CONCAT(eh.hierarchy_path, ' , ', CAST(e.employee_id AS VARCHAR)) AS hierarchy_path
    FROM
        EmployeeHierarchy eh
        INNER JOIN memory.default.EMPLOYEE e ON eh.mgr_id = e.employee_id
    WHERE POSITION(CAST(e.employee_id AS VARCHAR) IN eh.hierarchy_path) = 0 -- Avoid revisiting employees
)
-- Identify cycles in the hierarchy
SELECT
    emp_id AS employee_id,
    hierarchy_path AS cycle_path
FROM
    EmployeeHierarchy
WHERE POSITION(CAST(mgr_id AS VARCHAR) IN hierarchy_path) > 0 -- Check if manager is already in the path
ORDER  BY employee_id;
