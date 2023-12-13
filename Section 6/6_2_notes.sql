/*
Barbara Charles
12.11.23
DP PL/SQL
Section 6-2: Indexing Tables of Records
Notes and Assignments */


-- This example populates an INDEX BY table with the hire date of employees using employee_id as the primary key
DECLARE
 -- Define an associative array (INDEX BY BINARY_INTEGER) to store hire dates for employees
  TYPE t_hire_date IS
    TABLE OF employees.hire_date%type INDEX BY BINARY_INTEGER;
 -- Declare a variable of the hire date array type
  v_hire_date_tab t_hire_date;
BEGIN
 -- Loop through each employee record and populate the hire date array
  FOR emp_rec IN (
    SELECT
      employee_id,
      hire_date
    FROM
      employees
  ) LOOP
    v_hire_date_tab (emp_rec.employee_id) := emp_rec.hire_date;
  END LOOP;
END;



-- This example populates an INDEX BY table with employees’ date of hire and sets the primary key using a sequence derived from incrementing v_count
DECLARE
  -- Define an associative array (INDEX BY BINARY_INTEGER) to store hire dates for employees
  TYPE t_hire_date IS TABLE OF employees.hire_date%TYPE INDEX BY BINARY_INTEGER;

  -- Declare a variable of the hire date array type
  v_hire_date_tab     t_hire_date;

  -- Initialize a counter variable
  v_count BINARY_INTEGER := 0;
BEGIN
  -- Loop through each employee's hire date and populate the hire date array
  FOR emp_rec IN (
    SELECT hire_date
    FROM employees
  ) LOOP
    -- Increment the counter for each employee
    v_count := v_count + 1;

    -- Assign the hire date to the corresponding index in the array
    v_hire_date_tab(v_count) := emp_rec.hire_date;
  END LOOP;
END;


-- Using INDEX BY Table Methods
-- This example demonstrates the method COUNT
DECLARE
 -- Define an associative array (INDEX BY BINARY_INTEGER) to store hire dates for employees
  TYPE t_hire_date IS
    TABLE OF employees.hire_date%type INDEX BY BINARY_INTEGER;

 -- Declare a variable of the hire date array type
  v_hire_date_tab   t_hire_date;

 -- Declare a variable to store the count of hire dates in the array
  v_hire_date_count NUMBER(4);

BEGIN
 -- Loop through each employee record and populate the hire date array
  FOR emp_rec IN (
    SELECT
      employee_id,
      hire_date
    FROM
      employees
  ) LOOP
    v_hire_date_tab(emp_rec.employee_id -- emp id as index
    ) := emp_rec.hire_date; -- insert values into array 
  END LOOP;

 -- Get the count of hire dates in the array
  v_hire_date_count := v_hire_date_tab.count;

 -- Print the count of hire dates to the console
  dbms_output.put_line('Number of Hire Dates: '
                       || v_hire_date_count);
END;


-- This example declares an INDEX BY table to store complete rows from the EMPLOYEES table:
DECLARE
  TYPE t_emp_rec IS
    TABLE OF employees%rowtype INDEX BY BINARY_INTEGER;
  v_employees_tab t_emprec;
...


-- This example is similar to the earlier INDEX BY table example, but stores the entire EMPLOYEES row and displays the salary from each row.
DECLARE
  -- Declare a user-defined type for an associative array
  TYPE t_emp_rec IS TABLE OF employees%ROWTYPE
  INDEX BY BINARY_INTEGER;

  -- Declare a variable of the associative array type
  v_emp_rec_tab   t_emp_rec;
BEGIN
  -- Loop through each row in the employees table
  FOR emp_rec IN (SELECT * FROM employees) LOOP
    -- Assign the entire record to the associative array using employee_id as the index
    v_emp_rec_tab(emp_rec.employee_id) := emp_rec;

    -- Print the salary of the current employee from the associative array
    DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_emp_rec_tab(emp_rec.employee_id).employee_id ||
                         ', Salary: ' || v_emp_rec_tab(emp_rec.employee_id).salary);
  END LOOP;
END;


-- ASSIGNMENT 

-- 2. INDEX BY tables of countries in South America:
-- A. Write and execute an anonymous block that declares and populates an INDEX BY table of countries in South America (region_id = 5). The table should use country_id as a primary key, and should store the country names as the element values. The data should be stored in the table in ascending sequence of country_id. The block should not display any output. Save your code.

-- Declare a type for a collection of country names indexed by binary integers
DECLARE
  TYPE type_country_name IS TABLE OF countries.country_name%TYPE INDEX BY BINARY_INTEGER;
  
  -- Declare a variable of the collection type
  v_country_name_tab  type_country_name;
BEGIN
  -- Loop through countries with region_id = 5 and order by country_id
  FOR countries_rec IN (
    SELECT country_id, country_name
    FROM countries
    WHERE region_id = 5
    ORDER BY country_id
  ) LOOP
    -- Assign each country name to the collection using the country_id as the index
    v_country_name_tab(countries_rec.country_id) := countries_rec.country_name;
  END LOOP;
  
  -- The v_country_name_tab collection now contains country names indexed by country_id
END;


-- B. Modify the block so that after populating the INDEX BY table, it uses a FOR loop to display the contents of the INDEX BY table. You will need to use the FIRST, LAST, and EXISTS table methods. Execute the block and check the displayed results. Save your code.

DECLARE
  TYPE type_country_name IS TABLE OF countries.country_name%TYPE INDEX BY BINARY_INTEGER;
  
  -- Declare a variable of the collection type
  v_country_name_tab  type_country_name;
BEGIN
  -- Loop through countries with region_id = 5 and order by country_id
  FOR countries_rec IN (
    SELECT country_id, country_name
    FROM countries
    WHERE region_id = 5
    ORDER BY country_id
  ) LOOP
    -- Assign each country name to the collection using the country_id as the index
    v_country_name_tab(countries_rec.country_id) := countries_rec.country_name;
  END LOOP;

  -- Loop through the collection and print the values
  FOR i IN v_country_name_tab.FIRST .. v_country_name_tab.LAST LOOP
    IF v_country_name_tab.EXISTS(i) THEN
      DBMS_OUTPUT.PUT_LINE(i || ': ' || v_country_name_tab(i));
    END IF;
  END LOOP;
END;


-- C. Modify the block again so that instead of displaying all the contents of the table, it displays only the first and last elements and the number of elements in the INDEX BY table. Execute the block and check the displayed results.

-- answer using cursor 
DECLARE
  -- Declare a collection type for country names indexed by binary integers
  TYPE type_country_names IS TABLE OF countries.country_name%TYPE INDEX BY BINARY_INTEGER;
  
  -- Declare a variable of the collection type
  v_country_names   type_country_names;
  
  -- Declare a cursor to select country_id and country_name for a specific region
  CURSOR country_curs IS
    SELECT country_id, country_name
    FROM countries
    WHERE region_id = 5
    ORDER BY country_id;
    
  -- Declare a record variable to hold the fetched data from the cursor
  v_country_rec   country_curs%ROWTYPE;
BEGIN
  -- Open the cursor to begin fetching data
  OPEN country_curs;
  
  -- Start a loop to fetch and process each record from the cursor
  LOOP
    -- Fetch the current record into the v_country_rec variable
    FETCH country_curs INTO v_country_rec;
    
    -- Exit the loop if no more records are found
    EXIT WHEN country_curs%NOTFOUND;
    
    -- Assign the country name to the collection using country_id as the index
    v_country_names(v_country_rec.country_id) := v_country_rec.country_name;
  END LOOP;

  -- Close the cursor as it's no longer needed
  CLOSE country_curs;

  -- Output the first country in the collection along with its index
  DBMS_OUTPUT.PUT_LINE('First Country: ' || v_country_names.FIRST || ' ' || v_country_names(v_country_names.FIRST));
  
  -- Output the last country in the collection along with its index
  DBMS_OUTPUT.PUT_LINE('Last Country: ' || v_country_names.LAST || ' ' || v_country_names(v_country_names.LAST));
  
  -- Output the total number of countries in the collection
  DBMS_OUTPUT.PUT_LINE('Country total number is: ' || v_country_names.COUNT);
END;


-- same as answer above but no explicit cursor 
DECLARE
  -- Declare a collection type for country names indexed by binary integers
  TYPE type_country_names IS TABLE OF countries.country_name%TYPE INDEX BY BINARY_INTEGER;

  -- Declare a variable of the collection type
  v_country_names type_country_names;

BEGIN
  -- Loop through countries with region_id = 5 and order by country_id
  FOR countries_rec IN (
    SELECT country_id, country_name
    FROM countries
    WHERE region_id = 5
    ORDER BY country_id
  ) 
  LOOP
    -- Assign each country name to the collection using the country_id as the index
    v_country_names(countries_rec.country_id) := countries_rec.country_name;
  END LOOP;

  -- Output the first country in the collection along with its index
  DBMS_OUTPUT.PUT_LINE('First Country: ' || v_country_names.FIRST || ' ' || v_country_names(v_country_names.FIRST));
  
  -- Output the last country in the collection along with its index
  DBMS_OUTPUT.PUT_LINE('Last Country: ' || v_country_names.LAST || ' ' || v_country_names(v_country_names.LAST));
  
  -- Output the total number of countries in the collection
  DBMS_OUTPUT.PUT_LINE('Country total number is: ' || v_country_names.COUNT);
END;


-- 3. INDEX BY tables of records:
-- A. Write and execute an anonymous block that declares and populates an INDEX BY table of records containing employee data. The table of records should use the employee id as a primary key, and each element should contain an employee’s last name, job id, and salary. The data should be stored in the INDEX BY table of records in ascending sequence of employee id. The block should not display any output.
-- Hint: declare a cursor to fetch the employee data, then declare the INDEX BY table as cursor- name%ROWTYPE. Save your code.

DECLARE
  -- Declare a cursor to select employee data in ascending order of employee_id
  CURSOR emp_curs IS
    SELECT employee_id, last_name, job_id, salary
    FROM employees
    ORDER BY employee_id;

  -- Declare a record variable to hold fetched employee data
  v_emp_rec   emp_curs%ROWTYPE;

  -- Declare an associative array of employee data indexed by binary integers
  TYPE t_emp_data IS TABLE OF emp_curs%ROWTYPE INDEX BY BINARY_INTEGER;

  -- Declare a variable of the associative array type
  v_emp_data  t_emp_data;
BEGIN
  -- Open the cursor to begin fetching data
  OPEN emp_curs;

  -- Loop through the cursor and populate the associative array
  LOOP
    -- Fetch the current record into the v_emp_rec variable
    FETCH emp_curs INTO v_emp_rec;

    -- Exit the loop if no more records are found
    EXIT WHEN emp_curs%NOTFOUND;

    -- Assign the employee record to the associative array using employee_id as the index
    v_emp_data(v_emp_rec.employee_id) := v_emp_rec;
  END LOOP;

  -- Close the cursor as it's no longer needed
  CLOSE emp_curs;
END;



-- B. Modify the block so that after populating the table of records, it uses a FOR loop to display to display the contents. You will need to use the FIRST, LAST and EXISTS table methods. Execute the block and check the displayed results. Save your code.

DECLARE
  -- Declare a cursor to select employee data in ascending order of employee_id
  CURSOR emp_curs IS
    SELECT employee_id, last_name, job_id, salary
    FROM employees
    ORDER BY employee_id;

  -- Declare a record variable to hold fetched employee data
  v_emp_rec     emp_curs%ROWTYPE;

  -- Declare an associative array of employee data indexed by binary integers
  TYPE t_emp_data IS TABLE OF emp_curs%ROWTYPE INDEX BY BINARY_INTEGER;

  -- Declare a variable of the associative array type
  v_emp_data    t_emp_data;
BEGIN
  -- Open the cursor to begin fetching data
  OPEN emp_curs;

  -- Loop through the cursor and populate the associative array
  LOOP
    -- Fetch the current record into the v_emp_rec variable
    FETCH emp_curs INTO v_emp_rec;

    -- Exit the loop if no more records are found
    EXIT WHEN emp_curs%NOTFOUND;

    -- Assign the employee record to the associative array using employee_id as the index
    v_emp_data(v_emp_rec.employee_id) := v_emp_rec;
  END LOOP;

  -- Close the cursor as it's no longer needed
  CLOSE emp_curs;

  -- Loop through the associative array and display employee data
  FOR i IN v_emp_data.FIRST .. v_emp_data.LAST LOOP
    IF v_emp_data.EXISTS(i) THEN
      -- Display employee information using DBMS_OUTPUT
      DBMS_OUTPUT.PUT_LINE(v_emp_data(i).employee_id || ' ' || v_emp_data(i).last_name || ' ' ||
                           v_emp_data(i).job_id || ' ' || v_emp_data(i).salary);
    END IF;
  END LOOP;
END;
