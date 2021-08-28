
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
-- #2
-- #3
-- #4
-- #5
-- #6
-- #7
-- #8