SELECT *      -- Select all
FROM renting; -- From table renting

SELECT movie_id,  -- Select all columns needed to compute the average rating per movie
       rating
FROM renting;

SELECT *
FROM renting
WHERE date_renting BETWEEN '2018-04-01' AND '2018-08-31'; -- from beginning April 2018 to end August 2018

SELECT *
FROM renting
WHERE date_renting BETWEEN '2018-04-01' AND '2018-08-31'
ORDER BY date_renting DESC; -- Order by recency in decreasing order

SELECT *
FROM movies
WHERE genre <> 'Drama'; -- All genres except drama

SELECT *
FROM movies
WHERE title IN ('Showtime', 'Love Actually', 'The Fighter'); -- Select all movies with the given titles

SELECT *
FROM movies
ORDER BY renting_price; -- Order the movies by increasing renting price

SELECT *
FROM renting
WHERE date_renting BETWEEN '2018-01-01' AND '2018-12-31' -- Renting in 2018
AND rating IS NOT NULL; -- Rating exists

SELECT COUNT(*) -- Count the total number of customers
FROM customers
WHERE date_of_birth BETWEEN '1980-01-01' AND '1989-12-31'; -- Select customers born between 1980-01-01 and 1989-12-31

SELECT COUNT(*) -- Count the total number of customers
FROM customers
WHERE country = 'Germany'; -- Select all customers from Germany

SELECT COUNT(DISTINCT country) -- Count the number of countries
FROM customers;

SELECT MIN(rating) AS min_rating, -- Calculate the minimum rating and use alias min_rating
		MAX(rating) AS max_rating, -- Calculate the maximum rating and use alias max_rating
		AVG(rating) AS avg_rating, -- Calculate the average rating and use alias avg_rating
		COUNT(rating) AS number_ratings -- Count the number of ratings and use alias number_ratings
FROM renting
WHERE movie_id = 25; -- Select all records of the movie with ID 25

SELECT * -- Select all records of movie rentals since January 1st 2019
FROM renting
WHERE date_renting >= '2019-01-01'; 

SELECT 
	COUNT(*), -- Count the total number of rented movies
	AVG(rating) -- Add the average rating
FROM renting
WHERE date_renting >= '2019-01-01';

SELECT 
	COUNT(*) AS number_renting, -- Give it the column name number_renting
	AVG(rating) AS average_rating  -- Give it the column name average_rating
FROM renting
WHERE date_renting >= '2019-01-01';

SELECT 
	COUNT(*) AS number_renting,
	AVG(rating) AS average_rating, 
    COUNT(rating) AS number_ratings -- Add the total number of ratings here.
FROM renting
WHERE date_renting >= '2019-01-01';

SELECT country, -- For each country report the earliest date when an account was created
	MIN(date_account_start) AS first_account
FROM customers
GROUP BY country
ORDER BY first_account;

SELECT movie_id, 
       AVG(rating) -- Calculate average rating per movie
FROM renting
GROUP BY movie_id;

SELECT movie_id, 
       AVG(rating) AS avg_rating, -- Use as alias avg_rating
       COUNT(rating) AS number_rating, -- Add column for number of ratings with alias number_rating
       COUNT(*) AS number_renting -- Add column for number of movie rentals with alias number_renting
FROM renting
GROUP BY movie_id;

SELECT movie_id, 
       AVG(rating) AS avg_rating,
       COUNT(rating) AS number_ratings,
       COUNT(*) AS number_renting
FROM renting
GROUP BY movie_id
ORDER BY avg_rating DESC; -- Order by average rating in decreasing order

SELECT customer_id,  -- Report the customer_id
       AVG(rating), -- Report the average rating per customer
       COUNT(rating), -- Report the number of ratings per customer
       COUNT(*) -- Report the number of movie rentals per customer
FROM renting
GROUP BY customer_id
HAVING COUNT(*) > 7 -- Select only customers with more than 7 movie rentals
ORDER BY AVG(rating); -- Order by the average rating in ascending order

SELECT * -- Join renting with customers
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id;

SELECT *
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
WHERE c.country='Belgium'; -- Select only records from customers coming from Belgium

SELECT AVG(r.rating) -- Average ratings of customers from Belgium
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
WHERE c.country='Belgium';

SELECT *
FROM renting AS r
LEFT JOIN movies AS m -- Choose the correct join statment
ON r.movie_id = m.movie_id;

SELECT 
	SUM(m.renting_price), -- Get the revenue from movie rentals
	COUNT(*), -- Count the number of rentals
	COUNT(DISTINCT r.customer_id) -- Count the number of customers
FROM renting AS r
LEFT JOIN movies AS m
ON r.movie_id = m.movie_id;

SELECT 
	SUM(m.renting_price), 
	COUNT(*), 
	COUNT(DISTINCT r.customer_id)
FROM renting AS r
LEFT JOIN movies AS m
ON r.movie_id = m.movie_id
-- Only look at movie rentals in 2018
WHERE date_renting BETWEEN '2018-01-01' AND '2018-12-31';

SELECT a.name, -- Create a list of movie titles and actor names
       m.title
FROM actsin AS ai
LEFT JOIN movies AS m
ON m.movie_id = ai.movie_id
LEFT JOIN actors AS a
ON a.actor_id = ai.actor_id;

SELECT m.title,  -- Use a join to get the movie title and price for each movie rental
       m.renting_price
FROM renting AS r
LEFT JOIN movies AS m
ON r.movie_id=m.movie_id;

SELECT rm.title, -- Report the income from movie rentals for each movie 
       SUM(rm.renting_price) AS income_movie
FROM
       (SELECT m.title, 
               m.renting_price
       FROM renting AS r
       LEFT JOIN movies AS m
       ON r.movie_id=m.movie_id) AS rm
GROUP BY rm.title
ORDER BY income_movie DESC; -- Order the result by decreasing income

SELECT a.gender, -- Report for male and female actors from the USA 
       MIN(a.year_of_birth), -- The year of birth of the oldest actor
       MAX(a.year_of_birth) -- The year of birth of the youngest actor
FROM
    (SELECT * -- Use a subsequent SELECT to get all information about actors from the USA
    FROM actors
    WHERE nationality = 'USA') AS a -- Give the table the name a
GROUP BY a.gender;

SELECT *
FROM renting AS r
LEFT JOIN customers AS c
ON c.customer_id = r.customer_id  -- Add customer information
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id;   -- Add movie information

SELECT *
FROM renting AS r
LEFT JOIN customers AS c
ON c.customer_id = r.customer_id
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE c.date_of_birth BETWEEN '1970-01-01' AND '1979-12-31'; -- Select customers born in the 70s

SELECT m.title, 
COUNT(*), -- Report number of views per movie
AVG(r.rating) -- Add the average rating for each movie
FROM renting AS r
LEFT JOIN customers AS c
ON c.customer_id = r.customer_id
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE c.date_of_birth BETWEEN '1970-01-01' AND '1979-12-31'
GROUP BY m.title;

SELECT m.title, 
COUNT(*),
AVG(r.rating) 
FROM renting AS r
LEFT JOIN customers AS c
ON c.customer_id = r.customer_id
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE c.date_of_birth BETWEEN '1970-01-01' AND '1979-12-31'
GROUP BY m.title
HAVING COUNT(*) > 1  -- Remove movies with only one rental
ORDER BY AVG(r.rating) DESC; -- Order with highest rating first

SELECT *
FROM renting as r
LEFT JOIN customers AS c         -- Augment table renting with information about customers
ON r.customer_id = c.customer_id 
LEFT JOIN actsin as ai           -- Join the table renting with the table actsin
ON r.movie_id = ai.movie_id
LEFT JOIN actors as a            -- Augment table renting with information about actors
ON ai.actor_id = a.actor_id;

SELECT a.name,  c.gender,
       COUNT(*) AS number_views, 
       AVG(r.rating) AS avg_rating
FROM renting as r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
LEFT JOIN actsin as ai
ON r.movie_id = ai.movie_id
LEFT JOIN actors as a
ON ai.actor_id = a.actor_id

GROUP BY a.name, c.gender -- For each actor, separately for male and female customers
HAVING AVG(r.rating) IS NOT NULL 
  AND COUNT(*) > 5 -- Report only actors with more than 5 movie rentals
ORDER BY avg_rating DESC, number_views DESC;

SELECT a.name,  c.gender,
       COUNT(*) AS number_views, 
       AVG(r.rating) AS avg_rating
FROM renting as r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
LEFT JOIN actsin as ai
ON r.movie_id = ai.movie_id
LEFT JOIN actors as a
ON ai.actor_id = a.actor_id
WHERE c.country = 'Spain' -- Select only customers from Spain
GROUP BY a.name, c.gender
HAVING AVG(r.rating) IS NOT NULL 
  AND COUNT(*) > 5 
ORDER BY avg_rating DESC, number_views DESC;

SELECT *
FROM renting AS r -- Augment the table renting with information about customers
LEFT JOIN customers AS c
ON c.customer_id = r.customer_id
LEFT JOIN movies AS m -- Augment the table renting with information about movies
ON r.movie_id = m.movie_id
WHERE date_renting >= '2019-01-01'; -- Select only records about rentals since beginning of 2019

SELECT 
	c.country,                      -- For each country report
	COUNT(*) AS number_renting,   -- The number of movie rentals
	AVG(r.rating) AS average_rating,  -- The average rating
	SUM(m.renting_price) AS revenue  -- The revenue from movie rentals
FROM renting AS r
LEFT JOIN customers AS c
ON c.customer_id = r.customer_id
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE date_renting >= '2019-01-01'
GROUP BY c.country;

SELECT movie_id -- Select movie IDs with more than 5 views
FROM renting
GROUP BY movie_id
HAVING COUNT(*) > 5

SELECT *
FROM movies
WHERE movie_id IN  -- Select movie IDs from the inner query
	(SELECT movie_id
	FROM renting
	GROUP BY movie_id
	HAVING COUNT(*) > 5)

SELECT *
FROM customers
WHERE customer_id IN -- Select all customers with more than 10 movie rentals
	(SELECT customer_id
	FROM renting
	GROUP BY customer_id
	HAVING COUNT(*) > 10);

SELECT AVG(rating) -- Calculate the total average rating
FROM renting;

SELECT movie_id,  -- Select movie IDs and calculate the average rating 
       AVG(rating)
FROM renting
GROUP BY movie_id
HAVING AVG(rating) >   -- Of movies with rating above average
	(SELECT AVG(rating)
	FROM renting);

SELECT title -- Report the movie titles of all movies with average rating higher than the total average
FROM movies
WHERE movie_id IN
	(SELECT movie_id
	 FROM renting
     GROUP BY movie_id
     HAVING AVG(rating) > 
		(SELECT AVG(rating)
		 FROM renting));

-- Count movie rentals of customer 45
SELECT COUNT(*)
FROM renting as r
WHERE r.customer_id = 45;

-- Select customers with less than 5 movie rentals
SELECT *
FROM customers as c
WHERE 5 > 
	(SELECT count(*)
	FROM renting as r
	WHERE r.customer_id=c.customer_id);

-- Calculate the minimum rating of customer with ID 7
SELECT MIN(rating)
FROM renting
WHERE customer_id = 7;

SELECT *
FROM customers AS c
WHERE 4 >  -- Select all customers with a minimum rating smaller than 4
	(SELECT MIN(rating)
	FROM renting AS r
	WHERE r.customer_id = c.customer_id);

SELECT *
FROM movies AS m
WHERE 5 < -- Select all movies with more than 5 ratings
	(SELECT COUNT(rating)
	FROM renting AS r
	WHERE r.movie_id = m.movie_id);

SELECT *
FROM movies AS m
WHERE 8 <  -- Select all movies with an average rating higher than 8
	(SELECT AVG(rating)
	FROM renting AS r
	WHERE r.movie_id = m.movie_id);

-- Select all records of movie rentals from customer with ID 115
SELECT *
FROM renting
WHERE customer_id = 115;

SELECT *
FROM renting
WHERE rating IS NOT NULL -- Exclude those with null ratings
AND customer_id = 115;

SELECT *
FROM renting
WHERE rating IS NOT NULL -- Exclude null ratings
AND customer_id = 1; -- Select all ratings from customer with ID 1

SELECT *
FROM customers AS c -- Select all customers with at least one rating
WHERE EXISTS
	(SELECT *
	FROM renting AS r
	WHERE rating IS NOT NULL 
	AND r.customer_id = c.customer_id);

SELECT *  -- Select the records from the table `actsin` of all actors who play in a Comedy
FROM actsin AS ai
LEFT JOIN movies AS m
ON ai.movie_id = m.movie_id
WHERE m.genre = 'Comedy';

SELECT *  -- Select the records from the table `actsin` of all actors who play in a Comedy
FROM actsin AS ai
LEFT JOIN movies AS m
ON ai.movie_id = m.movie_id
WHERE m.genre = 'Comedy';

SELECT *
FROM actsin AS ai
LEFT JOIN movies AS m
ON m.movie_id = ai.movie_id
WHERE m.genre = 'Comedy'
AND ai.actor_id = 1; -- Select only the actor with ID 1

SELECT *
FROM actors AS a
WHERE EXISTS
	(SELECT *
	 FROM actsin AS ai
	 LEFT JOIN movies AS m
	 ON m.movie_id = ai.movie_id
	 WHERE m.genre = 'Comedy'
	 AND ai.actor_id = a.actor_id);

SELECT a.nationality,  -- Report the nationality and number of actors for each nationality
COUNT(*) 
FROM actors AS a
WHERE EXISTS
	(SELECT ai.actor_id
	 FROM actsin AS ai
	 LEFT JOIN movies AS m
	 ON m.movie_id = ai.movie_id
	 WHERE m.genre = 'Comedy'
	 AND ai.actor_id = a.actor_id)
GROUP BY a.nationality;

SELECT name,   -- Report the name, nationality and the year of birth
       nationality, 
       year_of_birth
FROM actors
WHERE nationality <> 'USA'; -- Of all actors who are not from the USA

SELECT name, 
       nationality, 
       year_of_birth
FROM actors
WHERE year_of_birth > 1990; -- Born after 1990

SELECT name, 
       nationality, 
       year_of_birth
FROM actors
WHERE nationality <> 'USA'
UNION -- Select all actors who are not from the USA and all actors who are born after 1990
SELECT name, 
       nationality, 
       year_of_birth
FROM actors
WHERE year_of_birth > 1990;

SELECT name, 
       nationality, 
       year_of_birth
FROM actors
WHERE nationality <> 'USA'
INTERSECT -- Select all actors who are not from the USA and who are also born after 1990
SELECT name, 
       nationality, 
       year_of_birth
FROM actors
WHERE year_of_birth > 1990;

SELECT movie_id -- Select the IDs of all dramas
FROM movies
WHERE genre = 'Drama';

SELECT movie_id -- Select the IDs of all movies with average rating higher than 9
FROM renting
GROUP BY movie_id
HAVING AVG(rating) > 9;

SELECT movie_id
FROM movies
WHERE genre = 'Drama'
INTERSECT  -- Select the IDs of all dramas with average rating higher than 9
SELECT movie_id
FROM renting
GROUP BY movie_id
HAVING AVG(rating)>9;

SELECT *
FROM movies
WHERE movie_id IN -- Select all movies of genre drama with average rating higher than 9
   (SELECT movie_id
    FROM movies
    WHERE genre = 'Drama'
    INTERSECT
    SELECT movie_id
    FROM renting
    GROUP BY movie_id
    HAVING AVG(rating)>9);

SELECT gender,  -- Extract information of a pivot table of gender and country for the number of customers
	   country,
	   COUNT(*)
FROM customers
GROUP BY CUBE (gender, country)
ORDER BY country;

SELECT year_of_releas,
       genre,
	   COUNT(*)
FROM movies
GROUP BY CUBE (year_of_releas, genre)
ORDER BY year_of_releas;

-- Augment the records of movie rentals with information about movies and customers
SELECT *
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id;

-- Calculate the average rating for each country
SELECT 
	c.country, 
	AVG(r.rating)
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
GROUP BY c.country;

SELECT 
	c.country, 
	m.genre, 
	AVG(r.rating) AS avg_rating -- Calculate the average rating 
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
GROUP BY CUBE (c.country, m.genre); -- For all aggregation levels of country and genre

-- Count the total number of customers, the number of customers for each country, and the number of female and male customers for each country
SELECT country,
       gender,
	   COUNT(*)
FROM customers
GROUP BY ROLLUP (country, gender)
ORDER BY country, gender; -- Order the result by country and gender

	-- Join the tables
	SELECT *
	FROM renting AS r
	LEFT JOIN movies AS m
	ON m.movie_id = r.movie_id
	LEFT JOIN customers AS c
	ON r.customer_id = c.customer_id;

SELECT 
	c.country, -- Select country
	m.genre, -- Select genre
    AVG(r.rating), -- Average ratings
	COUNT(*) -- Count number of movie rentals
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
GROUP BY c.country, m.genre -- Aggregate for each country and each genre
ORDER BY c.country, m.genre;

-- Group by each county and genre with OLAP extension
SELECT 
	c.country, 
	m.genre, 
	AVG(r.rating) AS avg_rating, 
	COUNT(*) AS num_rating
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
GROUP BY ROLLUP (c.country, m.genre)
ORDER BY c.country, m.genre;

SELECT 
	nationality, -- Select nationality of the actors
    gender, -- Select gender of the actors
    COUNT(*) -- Count the number of actors
FROM actors
GROUP BY GROUPING SETS ((nationality), (gender), ()); -- Use the correct GROUPING SETS operation

SELECT 
	c.country, -- Select country, gender and rating
	c.gender,
	r.rating
FROM renting AS r
LEFT JOIN customers AS c -- Use the correct join
ON r.customer_id = c.customer_id;

SELECT 
	c.country, 
    c.gender,
	AVG(r.rating) -- Calculate average rating
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
GROUP BY country, gender  -- Order and group by country and gender
ORDER BY country, gender;

SELECT 
	c.country, 
    c.gender,
	AVG(r.rating)
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
GROUP BY GROUPING SETS ((country, gender)); -- Group by country and gender with GROUPING SETS

SELECT 
	c.country, 
    c.gender,
	AVG(r.rating)
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
-- Report all info from a Pivot table for country and gender
GROUP BY GROUPING SETS ((country, gender), (country), (gender), ());

SELECT *
FROM renting AS r
LEFT JOIN movies AS m -- Augment the table with information about movies
ON r.movie_id = m.movie_id;

SELECT *
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE r.movie_id IN ( -- Select records of movies with at least 4 ratings
	SELECT movie_id
	FROM renting
	GROUP BY movie_id
	HAVING COUNT(rating) >= 4)
AND r.date_renting >= '2018-04-01'; -- Select records of movie rentals since 2018-04-01

SELECT m.genre, -- For each genre, calculate:
	   AVG(r.rating) AS avg_rating, -- The average rating and use the alias avg_rating
	   COUNT(r.rating) AS n_rating, -- The number of ratings and use the alias n_rating
	   COUNT(*) AS n_rentals,     -- The number of movie rentals and use the alias n_rentals
	   COUNT(DISTINCT m.movie_id) AS n_movies -- The number of distinct movies and use the alias n_movies
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE r.movie_id IN ( 
	SELECT movie_id
	FROM renting
	GROUP BY movie_id
	HAVING COUNT(rating) >= 3)
AND r.date_renting >= '2018-01-01'
GROUP BY m.genre;

SELECT genre,
	   AVG(rating) AS avg_rating,
	   COUNT(rating) AS n_rating,
       COUNT(*) AS n_rentals,     
	   COUNT(DISTINCT m.movie_id) AS n_movies 
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE r.movie_id IN ( 
	SELECT movie_id
	FROM renting
	GROUP BY movie_id
	HAVING COUNT(rating) >= 3)
AND r.date_renting >= '2018-01-01'
GROUP BY genre
ORDER BY avg_rating DESC; -- Order the table by decreasing average rating

-- Join the tables
SELECT *
FROM renting AS r
LEFT JOIN actsin AS ai
ON ai.movie_id = r.movie_id
LEFT JOIN actors AS a
ON ai.actor_id = a.actor_id;

SELECT a.nationality,
       a.gender,
	   AVG(r.rating) AS avg_rating, -- The average rating
	   COUNT(r.rating) AS n_rating, -- The number of ratings
	   COUNT(*) AS n_rentals, -- The number of movie rentals
	   COUNT(DISTINCT a.actor_id) AS n_actors -- The number of actors
FROM renting AS r
LEFT JOIN actsin AS ai
ON ai.movie_id = r.movie_id
LEFT JOIN actors AS a
ON ai.actor_id = a.actor_id
WHERE r.movie_id IN ( 
	SELECT movie_id
	FROM renting
	GROUP BY movie_id
	HAVING COUNT(rating) >=4 )
AND r.date_renting >= '2018-04-01'
GROUP BY a.nationality, a.gender;

SELECT a.nationality,
       a.gender,
	   AVG(r.rating) AS avg_rating,
	   COUNT(r.rating) AS n_rating,
	   COUNT(*) AS n_rentals,
	   COUNT(DISTINCT a.actor_id) AS n_actors
FROM renting AS r
LEFT JOIN actsin AS ai
ON ai.movie_id = r.movie_id
LEFT JOIN actors AS a
ON ai.actor_id = a.actor_id
WHERE r.movie_id IN ( 
	SELECT movie_id
	FROM renting
	GROUP BY movie_id
	HAVING COUNT(rating) >= 4)
AND r.date_renting >= '2018-04-01'
GROUP BY CUBE (a.nationality, a.gender); -- Provide results for all aggregation levels represented in a pivot table















