/*
Barbara Charles
12.11.23
DP PL/SQL
Section 6-1: User-Defined Records
Notes and Assignments */


-- Use %ROWTYPE to declare a variable as a record based on the structure of the EMPLOYEES table.
DECLARE
    v_emp_record    employees%rowtype;
BEGIN
    SELECT * 
    INTO v_emp_record
    FROM employees
    WHERE employee_id = 100;

    dbms_output.put_line('Email for ' || v_emp_record.first_name || ' ' || v_emp_record.last_name || ' is ' || v_emp_record.email || '@oracle.com.');
END;



-- You can use %ROWTYPE to declare a record based on another record:
DECLARE
    v_emp_record            employees%rowtype;
    v_emp_copy_record       v_emp_record%rowtype;
BEGIN
    SELECT * 
    INTO v_emp_record
    FROM employees
    WHERE employee_id = 100;

    v_emp_copy_record := v_emp_record;
    v_emp_copy_record.salary := v_emp_record.salary * 1.2;

    dbms_output.put_line(v_emp_record.first_name
                         || ' '
                         || v_emp_record.last_name
                         || ': Old Salary - '
                         || v_emp_record.salary
                         || ', Proposed New Salary - '
                         || v_emp_copy_record.salary
                         || '.');
END;




-- Defining Your Own Records
-- User-Defined Records: Example 1
DECLARE
    -- Define a custom record type to store person details and department name
    TYPE person_dept IS RECORD (
        first_name      employees.first_name%TYPE,
        last_name       employees.last_name%TYPE,
        department_name departments.department_name%TYPE
    );
    
    -- Declare a variable of the custom record type
    v_person_dept_rec   person_dept;
BEGIN
    -- Retrieve the first name, last name, and department name for employee with ID 200
    SELECT
        e.first_name,
        e.last_name,
        d.department_name -- department_name is in a different table
    INTO v_person_dept_rec
    FROM employees   e
        JOIN departments d
        ON e.department_id = d.department_id
    WHERE employee_id = 200;

    -- Display the person's information and department name
    DBMS_OUTPUT.PUT_LINE(v_person_dept_rec.first_name ||
                         ' ' ||
                         v_person_dept_rec.last_name ||
                         ' is in the ' ||
                         v_person_dept_rec.department_name ||
                         ' department.');
END;



-- User-Defined Records: Example 2
-- How many fields can be addressed in v_emp_dept_rec?
-- The answer is 4
DECLARE
    -- Define a record type for department information
    TYPE dept_info_type IS RECORD (
        department_id   departments.department_id%TYPE,
        department_name departments.department_name%TYPE
    );
    
    -- Define a record type for employee information, including department details
    TYPE emp_dept_type IS RECORD (
        first_name      employees.first_name%TYPE,
        last_name       employees.last_name%TYPE,
        dept_info       dept_info_type
    );

    -- Declare a variable of the employee department record type
    v_emp_dept_rec      emp_dept_type;
BEGIN
    -- Your code goes here...

END;



-- Visibility and Scope of Types and Records
-- The type and the record declared in the outer block are visible within the outer block and the inner block.
DECLARE
    -- Define a record type for an employee with a default value for first_name
    TYPE employee_type IS RECORD (
        first_name employees.first_name%TYPE := 'Amy');
    
    -- Declare an instance of the employee_type record
    v_emp_rec_outer employee_type;
BEGIN
    -- Print the initial value of first_name in the outer block
    DBMS_OUTPUT.PUT_LINE('Outer Block - Initial Value: ' || v_emp_rec_outer.first_name);

    DECLARE
        -- Inner block
        v_emp_rec_inner employee_type;
    BEGIN
        -- Modify the first_name in the outer block
        v_emp_rec_outer.first_name := 'Clara';

        -- Print the modified first_name from the outer block and the initial first_name from the inner block
        DBMS_OUTPUT.PUT_LINE('Inner Block - Modified Outer: ' || v_emp_rec_outer.first_name ||
                             ' and Inner Initial: ' || v_emp_rec_inner.first_name);
    END;

    -- Print the final value of first_name in the outer block
    DBMS_OUTPUT.PUT_LINE('Outer Block - Final Value: ' || v_emp_rec_outer.first_name);
END;



-- ASSIGNMENT 

-- Copy and execute the following anonymous block. Then modify it to declare and use a single record instead of a scalar variable for each column. Make sure that your code will still work if an extra column is added to the departments table later. Execute your modified block and save your code.

DECLARE
    v_dept_id   departments.department_id%type;
    v_dept_name departments.department_name%type;
    v_mgr_id    departments.manager_id%type;
    v_loc_id    departments.location_id%type;
BEGIN
    SELECT
        department_id,
        department_name,
        manager_id,
        location_id INTO v_dept_id,
        v_dept_name,
        v_mgr_id,
        v_loc_id
    FROM
        departments
    WHERE
        department_id = 80;
    dbms_output.put_line(v_dept_id
                         || ' '
                         || v_dept_name
                         || ' '
                         || v_mgr_id
                         || ' '
                         || v_loc_id);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('This department does not exist');
END;



-- answer / modified block
DECLARE 
    v_emp_record    departments%ROWTYPE;
BEGIN 
    SELECT *
    INTO v_emp_record
    FROM departments
    WHERE department_id = 80;

    dbms_output.put_line(v_emp_record.department_id || ' ' || v_emp_record.department_name || ' ' || v_emp_record.manager_id || ' ' || v_emp_record.location_id);

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('This department does not exist');
END;

