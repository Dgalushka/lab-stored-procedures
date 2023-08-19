use sakila;

-- 1. simple stored procedure

DELIMITER // 

create procedure customers_that_rented_actionmovies ()

begin
	select first_name, last_name, email
	from customer
	join rental on customer.customer_id = rental.customer_id
	join inventory on rental.inventory_id = inventory.inventory_id
	join film on film.film_id = inventory.film_id
	join film_category on film_category.film_id = film.film_id
	join category on category.category_id = film_category.category_id
	where category.name = "Action"
    group by first_name, last_name, email;
end //
DELIMITER ;

call customers_that_rented_actionmovies;

-- 2. making the first stored procedure more dynamic.

DELIMITER // 
CREATE PROCEDURE customers_rented_select_category (IN category CHAR(10))
BEGIN
	SELECT first_name, last_name, email
	FROM customer
	JOIN rental ON customer.customer_id = rental.customer_id
	JOIN inventory ON rental.inventory_id = inventory.inventory_id
	JOIN film ON film.film_id = inventory.film_id
	JOIN film_category ON film_category.film_id = film.film_id
	JOIN category ON category.category_id = film_category.category_id
	JOIN category.name = category
    GROUP BY first_name, last_name, email;
END // 
DELIMITER ;

CALL customers_rented_select_category("classics");

-- 3. number_of_releases_by_category

DELIMITER //
CREATE PROCEDURE number_of_releases_by_category(IN input INT)
BEGIN
	SELECT name category_name, COUNT(DISTINCT film_id) number_of_movies 
	FROM sakila.category 
	JOIN sakila.film_category USING(category_id)
    GROUP BY name
    HAVING COUNT(DISTINCT film_id) > input
	ORDER BY COUNT(DISTINCT film_id) DESC;
END //
DELIMITER ;

call number_of_releases_by_category (70);






