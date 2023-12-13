
/*Barbara Charles
11.29.23
Section 2-5: Writing PL/SQL Executable Statements
Notes */

-- example of implicit casting
DECLARE
    x VARCHAR2(20);
BEGIN
    x := '123' + '456' ;
    DBMS_OUTPUT.PUT_LINE(x);
END;


-- get the sign of a NUMBER
DECLARE
    v_my_num BINARY_INTEGER := -56664;
BEGIN 
    DBMS_OUTPUT.PUT_LINE(SIGN(v_my_num));
END;


--Round a number to 0 decimal place
DECLARE
    v_median_age NUMBER(6,2);
BEGIN
    SELECT meian_age INTO v_median_age
    FROM countries
    WHERE country_id = 27; 
    
    DBMS_OUTPUT.PUT_LINE(ROUND(v_median_age,0));
END;


-- add months to a date
DECLARE
    v_new_date DATE; 
    v_num_months NUMBER := 6;
BEGIN
    v_new_date := ADD_MONTHS(SYSDATE,v_num_months);
    DBMS_OUTPUT.PUT_LINE(v_new_date);
END;


-- Calculate the number of months between two dates:
DECLARE
  v_no_months PLS_INTEGER :=0;
BEGIN
  v_no_months := MONTHS_BETWEEN('31-Jan-2006','31-May-2005');
  DBMS_OUTPUT.PUT_LINE(v_no_months);
END;

-- examples of implicit casting 
DECLARE
    v_salary NUMBER(6) := 6000; 
    v_sal_increase VARCHAR2(5) := '1000'; 
    v_total_salary v_salary%TYPE;
BEGIN
    v_total_salary := v_salary + v_sal_increase;
    DBMS_OUTPUT.PUT_LINE(v_total_salary); 
END;


-- Explicit Conversions
-- TO_CHAR
BEGIN
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'Month YYYY'));
END;


-- TO_DATE
BEGIN 
    DBMS_OUTPUT.PUT_LINE(TO_DATE('April-1999','Month-YYYY'));
END;


-- TO_NUMBER
DECLARE
    v_a VARCHAR2(10) := '-123456'; 
    v_b VARCHAR2(10) := '+987654'; 
    v_c PLS_INTEGER;
BEGIN
    v_c := TO_NUMBER(v_a) + TO_NUMBER(v_b);

    DBMS_OUTPUT.PUT_LINE(v_c);
END;

-- Assignment Questions
-- 2. Write an anonymous PL/SQL block that assigns the programmer’s full name to a variable, and then displays the number of characters in the name.
DECLARE 
    v_student_name VARCHAR2(50) := 'Barbara Charles';
BEGIN 
    DBMS_OUTPUT.PUT_LINE(LENGTH(v_student_name));
END;



-- 3. Write an anonymous PL/SQL block that uses today's date and outputs it in the format of ‘Month dd, yyyy’. Store the date in a DATE variable called my_date. Create another variable of the DATE type called v_last_day. Assign the last day of this month to v_last_day. Display the value of v_last_day.

DECLARE 
    my_date DATE := SYSDATE;
    v_last_day DATE := LAST_DAY(SYSDATE);
BEGIN 
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(my_date,'Month dd, YYYY'));
    DBMS_OUTPUT.PUT_LINE(v_last_day);
END;


-- 4. Modify the program created in question 3 to add 45 days to today’s date and then calculate and display the number of months between the two dates.
DECLARE 
    my_date DATE := SYSDATE + 45;
    v_last_day DATE := LAST_DAY(SYSDATE);
BEGIN 
    DBMS_OUTPUT.PUT_LINE('My date: ' || TO_CHAR(my_date,'Month dd, YYYY'));
    DBMS_OUTPUT.PUT_LINE('Last Day: ' || v_last_day);

    DBMS_OUTPUT.PUT_LINE('Months Between: ' || MONTHS_BETWEEN(my_date, v_last_day));
END;

DECLARE
x NUMBER(6);
BEGIN
x := 5 + 3 * 2 ;
DBMS_OUTPUT.PUT_LINE(x);
END;


DECLARE
v_number NUMBER;
v_boolean BOOLEAN;
BEGIN
v_number := 25;
v_boolean := NOT(v_number > 30);
END;