-- declaring DATE variables 
DECLARE
 v_date1 DATE := '05-APR-2015';
 v_date2 DATE := v_date1 + 7;
 v_date3 TIMESTAMP := SYSDATE;
 v_date4 TIMESTAMP WITH TIME ZONE := SYSDATE;

BEGIN DBMS_OUTPUT.PUT_LINE(v_date1); 
DBMS_OUTPUT.PUT_LINE(v_date2); 
DBMS_OUTPUT.PUT_LINE(v_date3); 
DBMS_OUTPUT.PUT_LINE(v_date4);
END;

-- declaring BOOLEAN variables
DECLARE 
    v_valid1    BOOLEAN := TRUE;
    v_valid2    BOOLEAN;
    v_valid3    BOOLEAN NOT NULL := FALSE;
BEGIN 
    IF v_valid1 THEN 
        DBMS_OUTPUT.PUT_LINE('Test is TRUE');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Test is FALSE');
    END IF;
END;


-- declaration guidelines
DECLARE 
    first_name VARCHAR2(20);
BEGIN 
    SELECT first_name
    INTO first_name
    FROM employees
    WHERE last_name = 'Vargas';
DBMS_OUTPUT.PUT_LINE(first_name);
END;

 -- better way to do it (below)
DECLARE 
    v_first_name employees.first_name%TYPE;
BEGIN 
    SELECT first_name
    INTO v_first_name
    FROM employees
    WHERE last_name = 'Vargas';
DBMS_OUTPUT.PUT_LINE(v_first_name);
END;


-- 1B. 
DECLARE 
    num_of_students PLS_INTEGER;
    STUDENT_NAME VARCHAR2(20) := 'Johnson';
    stu_per_class CONSTANT NUMBER := 20;
    tomorrow DATE := SYSDATE + 1;
BEGIN 
    num_of_students := 15;
    DBMS_OUTPUT.PUT_LINE(num_of_students);
    DBMS_OUTPUT.PUT_LINE(STUDENT_NAME);
    DBMS_OUTPUT.PUT_LINE(stu_per_class);
    DBMS_OUTPUT.PUT_LINE(tomorrow);
END;