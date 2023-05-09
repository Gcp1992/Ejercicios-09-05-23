--Subconsultas

-- Obtener los productos cuyo precio unitario sea mayor al precio promedio de la tabla de productos
SELECT product_id, product_name, supplier_id, category_id, unit_price
FROM public.products
WHERE unit_price > (
    SELECT AVG(unit_price) 
    FROM public.products
)

-- Obtener los productos cuya cantidad en stock sea menor al promedio de cantidad en stock de toda la tabla de productos.
SELECT product_id, product_name, supplier_id, category_id, units_in_stock
FROM public.products
WHERE units_in_stock < (
    SELECT AVG(units_in_stock) 
    FROM public.products
)

-- Obtener los productos cuya cantidad en Inventario (UnitsInStock) sea menor a la cantidad mínima del detalle de ordenes (Order Details)
SELECT product_id, product_name, supplier_id, category_id, units_in_stock
FROM public.products
WHERE units_in_stock < (
	SELECT MIN (quantity) FROM public.order_details
)

--OBTENER LOS PRODUCTOS CUYA CATEGORIA SEA IGUAL A LAS CATEGORIAS DE LOS PRODUCTOS CON PROVEEDOR 1.
SELECT * FROM public.products
WHERE category_id IN (
  SELECT category_id
  FROM products
  WHERE supplier_id = 1
)


-- Subconsultas correlacionadas 

--Obtener el número de empleado y el apellido para aquellos empleados que tengan menos de 100 ordenes.
SELECT employee_id, last_name FROM employees
WHERE (
  SELECT COUNT(employee_id)
  FROM public.orders
  WHERE employee_id = employees.employee_id
) < 100

--Obtener la clave de cliente y el nombre de la empresa para aquellos clientes que tengan más de 20 ordenes
SELECT customer_id, company_name
FROM public.customers
WHERE (
  SELECT COUNT(customer_id)
  FROM orders
  WHERE customer_id = customers.customer_id
) > 20

--Obtener el productoid, el nombre del producto, el proveedor de la tabla de productos para aquellos productos que se hayan vendido menos de 100 unidades (Consultarlo en la tabla de Orders details).
SELECT product_id, product_name, supplier_id
FROM public.products
WHERE product_id IN (
  SELECT product_id
  FROM public.order_details
  WHERE product_id = products.product_id
  GROUP BY product_id
  HAVING SUM(quantity) < 100
)

--Obtener los datos del empleado IDEmpleado y nombre completo De aquellos que tengan mas de 100 ordenes
SELECT employee_id, CONCAT(first_name, ' ', last_name) AS nombre_completo
FROM public.employees
WHERE employee_id IN (
  SELECT employee_id
  FROM public.orders
  WHERE employee_id = employees.employee_id
  GROUP BY employee_id
  HAVING COUNT(order_id) > 100
)

--Obtener los datos de Producto ProductId, ProductName, UnitsinStock, UnitPrice (Tabla Products) de los productos que la sumatoria de la cantidad (Quantity) de orders details sea mayor a 450
SELECT product_id, product_name, units_in_stock, unit_price 
FROM products AS p 
WHERE (SELECT SUM(od.quantity) 
FROM order_details AS od 
WHERE p.product_id = od.product_id) > 450;

--Obtener la clave de cliente y el nombre de la empresa para aquellos clientes que tengan más de 20 ordenes.
SELECT customer_id, company_name 
FROM customers AS c 
WHERE (
	SELECT COUNT(o.order_id) FROM orders AS o 
	WHERE c.customer_id = o.customer_id) > 20;

--insert

--Insertar un registro en la tabla de Categorias, únicamente se quiere insertar la información del CategoryName y la descripción los Papelería y papelería escolar
INSERT INTO public.categories (category_id,category_name, description)
VALUES (9,'PaperEscolar', 'papelería');

--Dar de alta un producto con Productname, SupplierId, CategoryId, UnitPrice, UnitsInStock Como esta tabla tiene dos clave foraneas hay que ver los datos a dar de alta
INSERT INTO public.products (product_id, product_name, supplier_id , category_id, unit_price, units_in_stock, discontinued)
VALUES (78, 'Pala de pádel', 1, 2, 10.99, 50, 1);

--Dar de alta un empleado con LastName, FistName, Title, BrithDate
INSERT INTO employees (employee_id, last_name, first_name , title, birth_date)
VALUES (10, 'de la Cruz', 'Gonzalo', 'CEO', '25-09-1995');

--Dar de alta una orden, CustomerId, Employeeid, Orderdate, ShipVia Como esta tabla tiene dos clave foraneas hay que ver los datos a dar de alta
INSERT INTO public.orders (order_id, customer_id, employee_id, order_date, ship_via)
VALUES (831, 'VINET', 3, '2020-05-09', 4);

--Dar de alta un Order details, con todos los datos
INSERT INTO public.order_details (order_id, product_id, unit_price, quantity, discount)
VALUES (11077,78,12.99,88,0.1);

--update

-- Cambiar el CategoryName a Verduras de la categoria 10
UPDATE public.categories
SET category_name = 'Verduras'
WHERE category_id = 10;
-- Actualizar los precios de la tabla de Productos para incrementarlos un 10%
UPDATE public.products
SET unit_price = unit_price * 1.1;

--ACTUALIZAR EL PRODUCTNAME DEL PRODUCTO 80 A ZANAHORIA ECOLOGICA
UPDATE public.products
SET product_name = 'ZANAHORIA ECOLOGICA'
WHERE product_id=80;

--ACTUALIZAR EL FIRSTNAME DEL EMPLOYEE 10 A ROSARIO 
UPDATE employees
SET first_name = 'Rosario'
WHERE employee_id = 10;

--ACTUALIZAR EL ORDERS DETAILS DE LA 11079 PARA QUE SU CANTIDAD SEA 10
UPDATE public.order_details
SET quantity=10
WHERE order_id=10079;
--Delete

--diferencia entre delete y truncate
--BORRAR EL EMPLEADO 10
DELETE FROM public.employees WHERE employee_id=10;