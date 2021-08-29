
-- Pratice Joins
-- #1
SELECT * 
FROM invoice i
JOIN invoice_line il
ON il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99; 

-- #2
SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice i
JOIN customer c
ON c.customer_id = i.customer_id;

-- #3
SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e
ON c.support_rep_id = e.employee_id;

-- #4
SELECT a.title, ar.name
FROM album a
JOIN artist ar
ON a.artist_id = ar.artist_id;

-- #5
SELECT pt.track_id
FROM playlist_track pt
JOIN playlist p
ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Music';

-- #6
SELECT t.name
FROM track t
JOIN playlist_track pt
ON t.track_id = pt.track_id
WHERE pt.playlist_id = 5;

-- #7
SELECT t.name AS track, p.name AS playlist
FROM track t
JOIN playlist_track pt
ON t.track_id = pt.track_id
JOIN playlist p
ON p.playlist_id = pt.playlist_track_id;

-- #8
SELECT t.name AS track, a.title
FROM track t
JOIN album a ON t.album_id = a.album_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';



-- Practice nested queries
-- #1
SELECT * 
FROM invoice 
WHERE invoice_id IN (SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99;

-- #2
SELECT * 
FROM playlist_track 
WHERE playlist_id IN (SELECT playlist_id FROM playlist WHERE name = 'Music');

-- #3
SELECT name 
FROM track 
WHERE track_id IN (SELECT track_id FROM playlist_track WHERE playlist_id = 5);

-- #4
SELECT * 
FROM track 
WHERE genre_id IN (SELECT genre_id FROM genre WHERE name = 'Comedy');

-- #5
SELECT * 
FROM track 
WHERE album_id IN (SELECT album_id FROM album WHERE title = 'Fireball');

-- #6
SELECT * 
FROM track 
WHERE album_id IN (
  SELECT album_id FROM album WHERE artist_id IN (
    SELECT artist_id FROM artist WHERE name = 'Queen'
  )
);



-- Practice updating Rows
-- #1
UPDATE customer
SET fax = null
WHERE fax IS NOT null;

-- SELECT * FROM customer
-- WHERE fax IS NOT null;

-- #2
UPDATE customer
SET company = 'Self'
WHERE company IS null;

-- #3
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';

-- SELECT * FROM customer
-- WHERE first_name = 'Julia' AND last_name = 'Barnett';

-- #4
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

-- #5
UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = ( SELECT genre_id FROM genre WHERE name = 'Metal') 
AND composer IS null;

-- #6
Refreshed



-- Group by
-- #1
SELECT count(*), genre.name
FROM track
JOIN genre ON genre.genre_id = track.genre_id
GROUP BY genre.name;

-- #2
SELECT count(*), genre.name
FROM track
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name IN ('Pop', 'Rock')
GROUP BY genre.name;

-- #3
SELECT ar.name, count(*) 
FROM artist ar
JOIN album al ON al.artist_id = ar.artist_id
GROUP BY ar.name;



-- Use Distinct
-- #1
SELECT DISTINCT composer 
FROM track

-- #2
SELECT DISTINCT billing_postal_code 
FROM invoice;

-- #3
SELECT DISTINCT company 
FROM customer;



-- Delete Rows
-- #1 
copied and ran

-- #2
DELETE FROM practice_delete
WHERE type = 'bronze';

-- #3
DELETE FROM practice_delete
WHERE type = 'silver';

-- #4
DELETE FROM practice_delete
WHERE value = 150;



-- eCommerce Simulation
-- Create 3 tables following the criteria in the summary.
CREATE TABLE users ( 
  id SERIAL PRIMARY KEY, 
  name VARCHAR(100), 
  email VARCHAR(100) 
);

CREATE TABLE products ( 
  id SERIAL PRIMARY KEY, 
  name VARCHAR(100), 
  price DECIMAL 
);

CREATE TABLE orders ( 
  id SERIAL PRIMARY KEY, 
  order_num INTEGER, --  cannot be unique because there may be multiple products per order
  product_id INTEGER REFERENCES products(id)  
);

-- Add some data to fill up each table.
INSERT INTO users
( name, email ) 
VALUES 
('bob', 'bob@bob.com'),
('bob2', 'bob2@bob.com'),
('bob3', 'bob3@bob.com');

INSERT INTO products
( name, price ) 
VALUES 
('camera', 1),
('camera2', 2),
('camera3', 3);


INSERT INTO orders
( order_num, product_id ) 
VALUES 
(55, 1),
(55, 2),
(66, 3);

-- Get all products for the first order.
SELECT o.order_num, p.name FROM orders o
JOIN products p
ON p.id = o.product_id
WHERE o.order_num = 
(SELECT min(order_num)FROM orders); --min order is first order

-- Get all orders.
SELECT o.order_num, p.name AS product_name, p.price FROM orders o
JOIN products p
ON p.id = o.product_id;

-- Get the total cost of an order ( sum the price of all products on an order ).
SELECT sum(p.price) FROM orders o
JOIN products p
ON p.id = o.product_id
WHERE o.order_num = 55;

SELECT o.order_num, sum(p.price) FROM orders o
JOIN products p
ON p.id = o.product_id
WHERE o.order_num = 55
GROUP BY o.order_num;   -- need a group by to include the order # in the result

-- Add a foreign key reference from orders to users.
ALTER TABLE orders
ADD COLUMN user_id INTEGER REFERENCES users(id);

-- Update the orders table to link a user to each order.
UPDATE orders 
SET	 user_id = 1
WHERE order_num = 55;

UPDATE orders 
SET	 user_id = 2
WHERE order_num = 66;

-- Get all orders for a user.
SELECT * FROM orders o
JOIN users u ON o.user_id = u.id
WHERE o.user_id = 1;

-- Get how many orders each user has.
SELECT u.name, count(DISTINCT o.order_num) 
FROM orders o
JOIN users u ON o.user_id = u.id
GROUP BY u.name;