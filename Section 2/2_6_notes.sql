/*
Barbara Charles
11.29.23
Section 2-6: Nested Blocks and Variable Scope
Notes & Assignment Question */



-- nest block example
DECLARE
    v_outer_variable VARCHAR2(20):='GLOBAL VARIABLE';
BEGIN
    DECLARE
        v_inner_variable VARCHAR2(20):='LOCAL VARIABLE';
    BEGIN 
        DBMS_OUTPUT.PUT_LINE(v_inner_variable); 
        DBMS_OUTPUT.PUT_LINE(v_outer_variable);
    END;
    DBMS_OUTPUT.PUT_LINE(v_outer_variable); 
END;


-- what is the scope of each variable?
DECLARE
    v_father_name  VARCHAR2(20):='Patrick';
    v_date_of_birth DATE:='20-Apr-1972';
BEGIN
    DECLARE
        v_child_name VARCHAR2(20):='Mike';
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Father''s Name: '||v_father_name);
        DBMS_OUTPUT.PUT_LINE('Date of Birth: '||v_date_of_birth);
        DBMS_OUTPUT.PUT_LINE('Child''s Name: '||v_child_name);
    END;
    DBMS_OUTPUT.PUT_LINE('Date of Birth: '||v_date_of_birth);
END;


-- variable visibility
DECLARE
    v_father_name VARCHAR2(20):='Patrick'; 
    v_date_of_birth DATE:='20-Apr-1972';
BEGIN
    DECLARE
        v_child_name VARCHAR2(20):='Mike';
        v_date_of_birth DATE:='12-Dec-2002'; 
        BEGIN
        DBMS_OUTPUT.PUT_LINE('Father''s Name: ' || v_father_name); 
        DBMS_OUTPUT.PUT_LINE('Date of Birth: ' || v_date_of_birth);  -- child's DOB
        DBMS_OUTPUT.PUT_LINE('Child''s Name: ' || v_child_name);
    END;
DBMS_OUTPUT.PUT_LINE('Date of Birth: ' || v_date_of_birth); -- father's DOB is visible here (outer block)
END;



DECLARE
    v_father_name VARCHAR2(20):='Patrick'; 
    v_date_of_birth DATE:='20-Apr-1972';
BEGIN
    DECLARE
        v_child_name VARCHAR2(20):= 'Mike';
        v_date_of_birth DATE:='12-Dec-2002'; 
        BEGIN
        DBMS_OUTPUT.PUT_LINE('Father''s Name: ' || v_father_name); 
        DBMS_OUTPUT.PUT_LINE('outer.v_date_of_birth');
        DBMS_OUTPUT.PUT_LINE('Date of Birth: ' || v_date_of_birth);  -- child's DOB
        DBMS_OUTPUT.PUT_LINE('Child''s Name: ' || v_child_name);
    END;
DBMS_OUTPUT.PUT_LINE('Date of Birth: ' || v_date_of_birth); -- father's DOB is visible here (outer block)
END;


-- qualifying an identifier
<<outer>>
DECLARE
    v_father_name VARCHAR2(20):='Patrick'; 
    v_date_of_birth DATE:='20-Apr-1972';
BEGIN
    DECLARE
        v_child_name VARCHAR2(20):='Mike';
        v_date_of_birth DATE:='12-Dec-2002';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Father''s Name: ' || v_father_name);
    DBMS_OUTPUT.PUT_LINE('Date of Birth: ' || outer.v_date_of_birth); -- to differentiate between parent and child DOB 
    DBMS_OUTPUT.PUT_LINE('Child''s Name: ' || v_child_name);
    DBMS_OUTPUT.PUT_LINE('Date of Birth: ' || v_date_of_birth);
    END;
END;


-- Assignment 
-- 1.
DECLARE
    weight NUMBER(3) := 600; -- Outer weight
    message VARCHAR2(255) := 'Product 10012';
BEGIN
    DECLARE
        weight NUMBER(3) := 1; -- Inner weight
        message VARCHAR2(255) := 'Product 11001';
        new_locn VARCHAR2(50) := 'Europe';
    BEGIN
        weight := weight + 1;  -- Increment inner weight
        new_locn := 'Western ' || new_locn;
    END;

    weight := weight + 1;  -- Increment outer weight
    message := message || ' is in stock';
END;


-- 2. 
<<outer>>
DECLARE
    v_employee_id   employees.employee_id%TYPE;
    v_job           employees.job_id%TYPE;
BEGIN
    SELECT employee_id, job_id 
    INTO v_employee_id, v_job
    FROM employees
    WHERE employee_id = 100;

    DECLARE
        v_employee_id   employees.employee_id%TYPE;
        v_job           employees.job_id%TYPE;
    BEGIN
        SELECT employee_id, job_id 
        INTO v_employee_id, v_job
        FROM employees
        WHERE employee_id = 103;

        DBMS_OUTPUT.PUT_LINE(outer.v_employee_id || ' is a(n) ' ||outer.v_job);
    END;

DBMS_OUTPUT.PUT_LINE(v_employee_id || ' is a(n) ' || v_job);
END;


-- 2. chatgpt's version of the code above
DECLARE
    v_employee_id       employees.employee_id%TYPE;
    v_job               employees.job_id%TYPE;
BEGIN
    -- Fetch information for employee with employee_id = 100
    SELECT employee_id, job_id 
    INTO v_employee_id, v_job
    FROM employees
    WHERE employee_id = 100;

    DBMS_OUTPUT.PUT_LINE(v_employee_id || ' is a(n) ' || v_job);

    -- Fetch information for employee with employee_id = 103
    SELECT employee_id, job_id 
    INTO v_employee_id, v_job
    FROM employees
    WHERE employee_id = 103;

    DBMS_OUTPUT.PUT_LINE(v_employee_id || ' is a(n) ' || v_job);
END;
/

