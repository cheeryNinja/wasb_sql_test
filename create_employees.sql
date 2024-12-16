-- Create a new EMPLOYEE table in the memory.default schema
--------------------------------------------------------------------------------------
-- The table has three columns:
--   - employee_id: A unique identifier for each employee (TINYINT)
--   - first_name: The first name of the employee (VARCHAR)
--   - last_name: The last name of the employee (VARCHAR)
--   - job_title: The job title of the employee (VARCHAR)
--   - manager_id: The ID of the manager to whom the employee reports (TINYINT)


DROP TABLE IF EXISTS memory.default.EMPLOYEE;

CREATE TABLE IF NOT EXISTS memory.default.EMPLOYEE (
    employee_id TINYINT,
    first_name VARCHAR,
    last_name VARCHAR,
    job_title VARCHAR,
    manager_id TINYINT
);



-- Insert data into the EMPLOYEE table
-- Data from hr/employee_index.csv
--------------------------------------------------------------------------------------

INSERT INTO memory.default.EMPLOYEE (employee_id, first_name, last_name, job_title, manager_id) 
VALUES
	(1, 'Ian', 'James', 'CEO', 4),
	(2, 'Umberto', 'Torrielli', 'CSO', 1),
	(3, 'Alex', 'Jacobson', 'MD EMEA', 2),
	(4, 'Darren', 'Poynton', 'CFO', 2),
	(5, 'Tim', 'Beard', 'MD APAC', 2),
	(6, 'Gemma', 'Dodd', 'COS', 1),
	(7, 'Lisa', 'Platten', 'CHR', 6),
	(8, 'Stefano', 'Camisaca', 'GM Activation', 2),
	(9, 'Andrea', 'Ghibaudi', 'MD NAM', 2);


