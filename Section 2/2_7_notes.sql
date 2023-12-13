/*
Barbara Charles
11.29.23
Section 2-7: Good Programming Practices
Notes & Assignment */

DECLARE
    v_myvar1 countries.country_name%TYPE;
    v_myvar2 NUMBER(4);
BEGIN
    SELECT country_name 
    INTO v_myvar1
    FROM countries 
    WHERE country_id = 421;

    v_myvar2 := '1234';
    v_myvar2 := v_myvar2 * 2;
DBMS_OUTPUT.PUT_LINE(v_myvar1);
END;

