--ASSIGNMENT 6
--PROBLEMS 27-53

--PROBLEM 27
SELECT	*
FROM	lgdepartment
ORDER BY dept_name

--PROBLEM 28 
--Write a query to display the SKU (stock keeping unit), description, type, base, cat-egory,
-- and price for all products that have a PROD_BASE of Water and a PROD_CATEGORY of Sealer 
SELECT	prod_sku, prod_descript, prod_type, prod_base, prod_category, prod_price
FROM	lgproduct
WHERE	prod_base = 'Water' AND prod_category = 'Sealer'

--PROBLEM 29
--Write a query to display the first name, last name, and email address of employees hired from January 1, 2005, 
--to December 31, 2014. Sort the output by last name and then by first name.
SELECT	emp_fname, emp_lname, emp_email
FROM	lgemployee
WHERE	emp_hiredate BETWEEN '2005-01-01' AND '2014-12-31'
ORDER BY emp_lname, emp_fname

--PROBLEM 30
--Write a query to display the first name, last name, phone number, title, and depart-ment 
--number of employees who work in department 300 or have the title “CLERK I.” Sort the output by last name and then by first name 
SELECT	emp_fname, emp_lname, emp_phone, emp_title, dept_num
FROM	lgemployee
WHERE	emp_title = 'CLERK I' OR dept_num = '300'
ORDER BY emp_lname, emp_fname

--PROBLEM 31
--Write a query to display the employee number, last name, first name, salary “from” date,
--Salary end date, and salary amount for employees 83731, 83745, and 84039. Sort the output by employee number and salary “from” date
SELECT	E.emp_num,E.emp_lname,E.emp_fname, S.sal_from, S.sal_end, S.sal_amount
FROM	lgemployee E INNER JOIN lgsalary_history S ON E.emp_num = S.emp_num
WHERE	E.emp_num IN ('83731','83745','84039')
ORDER BY E.emp_num, S.sal_from

--PROBLEM 32
--Write a query to display the first name, last name, street, city, state, and zip code of any
--customer who purchased a Foresters Best brand top coat between July 15, 2015, and July 31, 2015.
--If a customer purchased more than one such product, display the customer’s information only once in the output.
--Sort the output by state, last name, and then first name 
SELECT	C.cust_fname, C.cust_lname, C.cust_street, C.cust_city, C.cust_state, C.cust_zip
FROM	lgcustomer C INNER JOIN lginvoice I ON I.cust_code = C.cust_code
		INNER JOIN lgline L ON L.inv_num = I.inv_num
		INNER JOIN lgproduct P ON L.prod_sku = P.prod_sku
		INNER JOIN lgbrand B ON B.brand_id = P.brand_id
WHERE	B.brand_name = 'Foresters Best' 
		AND P.prod_category = 'Top coat'
		AND I.inv_date BETWEEN '2015-07-15' AND '2015-07-31'
GROUP BY C.cust_fname, C.cust_lname, C.cust_street, C.cust_city, C.cust_state, C.cust_zip	
ORDER BY C.cust_state, C.cust_lname, C.cust_fname

--PROBLEM 33
--Write a query to display the employee number, last name, email address, title, and department name of each employee whose job
--title ends in the word “ASSOCIATE.” Sort the output by department name and employee title 
SELECT	E.emp_num, E.emp_lname, E.emp_email, E.emp_title, D.dept_name
FROM	lgemployee E INNER JOIN lgdepartment D ON E.dept_num = D.dept_num
WHERE	emp_title LIKE '%ASSOCIATE'
ORDER BY D.dept_name, E.emp_title

--PROBLEM 34
--Write a query to display a brand name and the number of products of that brand
--that are in the database. Sort the output by the brand name 
SELECT	B.brand_name, COUNT(*) AS 'NUM_PRODUCTS'
FROM	lgproduct P INNER JOIN lgbrand B ON P.brand_id = B.brand_id
GROUP BY B.brand_name

--PROBLEM 35
--Write a query to display the number of products in each category that have a water base, sorted by category
SELECT	prod_category, COUNT(*) AS 'NUM_PRODUCTS'
FROM	lgproduct
WHERE	prod_base = 'WATER'
GROUP BY prod_category

--PROBLEM 36
--Write a query to display the number of products within each base and type combi-nation, sorted by base and then by type
SELECT	prod_base, prod_type, COUNT(*) AS 'NUM_PRODUCTS'
FROM	lgproduct
GROUP BY prod_base, prod_type

--PROBLEM 37
--Write a query to display the total inventory—that is, the sum of all products on hand for each brand ID.
--Sort the output by brand ID in descending order 
SELECT	B.brand_id, SUM(P.prod_qoh) AS 'TOTAL_INVENTORY'
FROM	lgbrand B INNER JOIN lgproduct P ON B.brand_id = P.brand_id
GROUP BY B.brand_id 
ORDER BY B.brand_id DESC

--PROBLEM 38
--Write a query to display the brand ID, brand name, and average price of products of each brand.
--Sort the output by brand name. Results are shown with the average price rounded to two decimal places
SELECT	B.brand_id, B.brand_name, ROUND(AVG(P.prod_price),2) AS 'AVG_PRICE'
FROM	lgbrand B INNER JOIN lgproduct P ON P.brand_id = B.brand_id
GROUP BY B.brand_name, B.brand_id
ORDER BY B.brand_name

--PROBLEM 39
--Write a query to display the department number and most recent employee hire date for each department. Sort the output by department number 
SELECT	D.dept_num, MAX(E.emp_hiredate) AS 'MOST_RECENT'
FROM	lgdepartment D INNER JOIN lgemployee E ON E.dept_num = D.dept_num
GROUP BY D.dept_num
ORDER BY D.dept_num

--PROBLEM 40
--Write a query to display the employee number, first name, last name, and largest salary amount for 
--each employee in department 200. Sort the output by largest sal-ary in descending order
SELECT	E.emp_num, E.emp_fname, E.emp_lname, MAX(S.sal_amount) AS 'LARGEST_SALARY'
FROM	lgemployee E INNER JOIN lgsalary_history S ON S.emp_num = E.emp_num
WHERE	E.dept_num = '200'
GROUP BY E.emp_num, E.emp_fname, E.emp_lname
ORDER  BY LARGEST_SALARY DESC

--PROBLEM 41
--Write a query to display the customer code, first name, last name, and sum of all invoice totals 
--for customers with cumulative invoice totals greater than $1,500. Sort the output by the sum of invoice totals in descending order 
SELECT	C.cust_code, C.cust_fname, C.cust_lname, SUM(I.inv_total) AS 'TOTAL_INVOICES'
FROM	lgcustomer C INNER JOIN lginvoice I ON I.cust_code = C.cust_code
GROUP BY C.cust_code, C.cust_fname, C.cust_lname
HAVING	SUM(I.inv_total) > 1500
ORDER BY TOTAL_INVOICES DESC

--PROBLEM 42
--Write a query to display the department number, department name, department phone number, employee number, 
--and last name of each department manager. Sort the output by department name 
SELECT	D.dept_num, D.dept_name, D.dept_phone, E.emp_num, E.emp_lname
FROM	lgdepartment D INNER JOIN lgemployee E ON E.emp_num = D.emp_num
ORDER BY D.dept_name

--PROBLEM 43
--Write a query to display the vendor ID, vendor name, brand name, and number of products of each brand 
--supplied by each vendor. Sort the output by vendor name and then by brand name 
SELECT	v.vend_id, V.vend_name, B.brand_name, COUNT(P.prod_sku) AS NUM_PRODUCTS
FROM	lgvendor V INNER JOIN lgsupplies S ON V.vend_id = s.vend_id
		INNER JOIN lgproduct P ON S.prod_sku = P.prod_sku
		INNER JOIN lgbrand B ON B.brand_id = P.brand_id
GROUP BY V.vend_id, V.vend_name, b.brand_name
ORDER BY V.vend_name, B.brand_name

--PROBLEM 44
--Write a query to display the employee number, last name, first name, and sum of invoice totals for 
--all employees who completed an invoice. Sort the output by employee last name and then by first name
SELECT	E.emp_num, E.emp_lname, E.emp_fname, SUM(I.inv_total) AS 'TOTAL_INVOICES'
FROM	lgemployee E INNER JOIN lginvoice I ON E.emp_num = I.employee_id
GROUP BY E.emp_num, E.emp_lname, E.emp_fname
ORDER BY E.emp_lname, E.emp_fname

--PROBLEM 45
--Write a query to display the largest average product price of any brand
SELECT	ROUND(AVG(prod_price),2) AS 'LARGEST_AVERAGE'
FROM	lgproduct
GROUP BY brand_id
HAVING	AVG(prod_price) = (SELECT	TOP 1 AVG(prod_price)
						   FROM		lgproduct
						   GROUP BY brand_id
						   ORDER BY AVG(prod_price) DESC)

--PROBLEM 46
--Write a query to display the brand ID, brand name, brand type, and average price of products 
--for the brand that has the largest average product price 
SELECT	B.brand_id, B.brand_name, B.brand_type, ROUND(AVG(P.prod_price),2) AS 'AVG_PRICE'
FROM	lgbrand B INNER JOIN lgproduct P ON B.brand_id = P.brand_id
GROUP BY B.brand_id, B.brand_name, B.brand_type
HAVING	AVG(P.prod_price) = (SELECT	TOP 1 AVG(P.prod_price)
						     FROM		lgbrand B INNER JOIN lgproduct P ON B.brand_id = P.brand_id
						     GROUP BY B.brand_id, B.brand_name, B.brand_type
						     ORDER BY AVG(prod_price) DESC)

--PROBLEM 47
--Write a query to display the manager name, department name, department phone number, employee name, customer name, 
--invoice date, and invoice total for the department manager of the employee who made a sale to a customer whose last name is Hagan on May 18, 2015
SELECT	M.emp_lname AS 'MANAGER LNAME', M.emp_fname AS 'MANAGER FNAME', D.dept_name, D.dept_phone, E.emp_lname, E.emp_fname, C.cust_lname, C.cust_fname, I.inv_date, I.inv_total
FROM	lgdepartment D INNER JOIN lgemployee E ON D.dept_num = E.dept_num
		INNER JOIN lgemployee M ON D.emp_num = M.emp_num
		INNER JOIN lginvoice I ON I.employee_id = E.emp_num
		INNER JOIN lgcustomer C ON C.cust_code = I.cust_code
WHERE	C.cust_lname = 'Hagan' AND I.inv_date = '2015-05-18'

--PROBLEM 48
--Write a query to display the current salary for each employee in department 300. Assume that only current employees are kept in the system,
--and therefore the most current salary for each employee is the entry in the salary history with a NULL end date. Sort the output in descending order by salary amount
SELECT	E.emp_num, E.emp_lname, E.emp_fname, S.sal_amount
FROM	lgemployee E INNER JOIN lgsalary_history S ON S.emp_num = E.emp_num
WHERE	S.sal_end IS NULL AND E.dept_num = '300'
ORDER BY S.sal_amount DESC

--PROBLEM 49
--Write a query to display the starting salary for each employee. The starting salary would be the entry in 
--the salary history with the oldest salary start date for each employee. Sort the output by employee number 
SELECT	E.emp_num, E.emp_lname, E.emp_fname, S.sal_amount
FROM	lgemployee E INNER JOIN lgsalary_history S ON S.emp_num = E.emp_num
WHERE	sal_from = (SELECT MIN(sal_from)
					FROM   lgemployee E INNER JOIN lgsalary_history SA ON SA.emp_num = E.emp_num
					 )
ORDER BY E.emp_num

--PROBLEM 50
--Write a query to display the invoice number, line numbers, product SKUs, product descriptions, and brand ID 
--for sales of sealer and top coat products of the same brand on the same invoice. Sort the results by invoice 
--number in ascending order, first line number in ascending order, and then by second line number in descending order
SELECT	L.inv_num, L.line_num, P.prod_sku, P.prod_descript, L2.line_num, P.brand_id
FROM	(LGLINE L JOIN LGPRODUCT P ON L.PROD_SKU = P.PROD_SKU) JOIN (LGLINE L2 JOIN LGPRODUCT P2 ON L2.PROD_SKU = P2.PROD_SKU) ON L.INV_NUM = L2.INV_NUM 
WHERE	P.brand_id = P2.brand_id
		AND P.prod_category = 'SEALER'
		AND P2.prod_category = 'TOP COAT'
ORDER BY L.inv_num ASC, L.line_num ASC, L2.line_num DESC

--PROBLEM 51
--The Binder Prime Company wants to recognize the employee who sold the most of its products during a specified period. 
--Write a query to display the employee number, employee first name, employee last name, email address, and total units 
--sold for the employee who sold the most Binder Prime brand products between November 1, 2015, and December 5, 2015. 
--If there is a tie for most units sold, sort the output by employee last name
SELECT	E.emp_num, E.emp_fname, E.emp_lname, E.emp_email, SUM(L.line_qty) AS 'TOTAL_UNITS'
FROM	lgemployee E INNER JOIN lginvoice I ON E.emp_num = I.employee_id
		INNER JOIN lgline L ON L.inv_num = I.inv_num
		INNER JOIN lgproduct P ON P.prod_sku = L.prod_sku
		INNER JOIN lgbrand B ON P.brand_id = B.brand_id
WHERE	B.brand_name = 'BINDER PRIME' 
		AND I.inv_date BETWEEN '11-01-15' AND '12-05-15'
GROUP BY E.emp_num, E.emp_fname, E.emp_lname, E.emp_email
HAVING SUM(L.line_qty) = (SELECT MAX(TOTAL_UNITS)
						  FROM( SELECT E.emp_num, E.emp_fname, E.emp_lname, E.emp_email,SUM(L.line_qty) AS 'TOTAL_UNITS'
								FROM lgemployee E INNER JOIN lginvoice I ON E.emp_num = I.employee_id
								INNER JOIN lgline L ON L.inv_num = I.inv_num
								INNER JOIN lgproduct P ON P.prod_sku = L.prod_sku
								INNER JOIN lgbrand B ON P.brand_id = B.brand_id
						  WHERE	B.brand_name = 'BINDER PRIME' 
								AND I.inv_date BETWEEN '11-01-15' AND '12-05-15'
						  GROUP BY E.emp_num, E.emp_fname, E.emp_lname, E.emp_email) A)
ORDER BY E.emp_lname 

--PROBLEM 52
--Write a query to display the customer code, first name, and last name of all custom-ers who have 
--had at least one invoice completed by employee 83649 and at least one invoice completed by employee 83677. 
--Sort the output by customer last name and then first name 
SELECT DISTINCT C.cust_code, C.cust_fname, C.cust_lname	
FROM	lgcustomer C INNER JOIN lginvoice I ON I.cust_code = C.cust_code 
		INNER JOIN lginvoice IV ON IV.cust_code = C.cust_code 
WHERE	IV.employee_id = '83677' AND I.employee_id = '83649'

--PROBLEM 53
--LargeCo is planning a new promotion in Alabama (AL) and wants to know about the largest purchases made by 
--customers in that state. Write a query to display the customer code, customer first name, last name, full 
--address, invoice date, and invoice total of the largest purchase made by each customer in Alabama. Be certain
--to include any customers in Alabama who have never made a purchase; their invoice dates should be NULL and the 
--invoice totals should display as 0. Sort the results by customer last name and then first name 
SELECT	C.cust_code, C.cust_fname, C.cust_lname, C.cust_street, C.cust_city, C.cust_state, C.cust_zip, I.inv_date, I.inv_total AS "Largest Invoice"
FROM	lgcustomer C INNER JOIN lginvoice I ON I.cust_code = C.cust_code
WHERE	C.cust_state = 'AL'
		AND I.inv_total = (SELECT Max(inv_total)
						   FROM lginvoice I2
						   WHERE i2.cust_code = c.cust_code)
						   
SELECT	c.cust_code, cust_fname, cust_lname, cust_street, cust_city, cust_state, cust_zip, inv_date, inv_total AS "Largest Invoice"
FROM	lgcustomer c join lginvoice i ON c.cust_code = i.cust_code
WHERE	c.cust_state = 'AL' AND i.inv_total = (SELECT Max(inv_total) FROM lginvoice i2 WHERE i2.cust_code = c.cust_code)
UNION
SELECT	cust_code, cust_fname, cust_lname, cust_street, cust_city, cust_state, cust_zip, NULL, 0
FROM	lgcustomer
WHERE	cust_state = 'AL' AND cust_code NOT IN (SELECT cust_code FROM lginvoice)
ORDER BY cust_lname, cust_fname;
