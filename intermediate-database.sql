
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
-- #2
-- #3
-- #4
-- #5
-- #6
-- #7
-- #8



-- eCommerce Simulation
-- #1
-- #2
-- #3
-- #4
-- #5
-- #6
-- #7
-- #8