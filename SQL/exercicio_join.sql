/* 
  Utilizando o banco de dados da W3C
  https://www.w3schools.com/sql/trysql.asp?filename=trysql_asc
*/

/* Unir as tabelas 'Products' e 'Categories' */
SELECT * 
FROM products AS p
JOIN categories AS c ON p.categoryID = c.categoryID;

/* Unir as tabelas 'Orders' e 'Shippers' */
SELECT * 
FROM orders AS o
JOIN shippers AS s ON o.shipperID = s.shipperID;

/* Mostrar a quantidade disponível do produto 'Chocolade' */
SELECT p.productName, o.quantity 
FROM products AS p 
JOIN orderDetails AS o ON p.productID = o.productID 
WHERE p.productName = 'Chocolade';

/* Mostrar quantos pedidos possuem o Shipper = United Package */
SELECT o.orderId, s.shipperName
FROM orders AS o
JOIN shippers AS s ON o.shipperId = s.shipperId 
WHERE s.shipperName = "United Package";

/* Mostrar todos os clientes que tem 'go' no nome e seus pedidos (orders) */
SELECT c.customerId, c.customerName, o.orderId, o.orderDate
FROM customers AS c 
JOIN orders AS o ON c.customerId = o.customerId
WHERE customerName LIKE '%go%';

/* Unir as tabelas 'Customers', 'Orders' e 'Shippers' */ 
SELECT c.customerId, c.customerName, o.orderId, o.orderDate, s.shipperName
FROM customers AS c
JOIN orders AS o ON c.customerId = o.customerId
JOIN shippers AS s ON s.shipperId = o.shipperId; 

/* Unir as tabelas 'Customers', 'Orders' e 'Employees' e mostrar os clientes cujos pedidos estão ligados aos empregados que possuem "ing" no sobrenome */
SELECT c.customerName, o.orderId, e.lastName
FROM customers AS c
JOIN orders AS o ON c.customerId = o.customerId
JOIN employees AS e ON o.employeeId = e.employeeId
WHERE e.lastName LIKE '%ing%';

/* Utilizar o mesmo conceito do 'SELECT' anterior, porém mostrar somente o empregado com ID = 5 */
SELECT c.customerName, o.orderId, e.employeeId
FROM customers AS c
JOIN orders AS o ON c.customerId = o.customerId
JOIN employees AS e ON o.employeeId = e.employeeId
WHERE e.employeeId = 5;
