-- Напишіть SQL-запит, який виведе назву фільму, тривалість і категорію для кожного фільму.
SELECT
    f.title AS film_title,
    f.length AS film_length,
    c.name AS category_name
FROM
    film f
JOIN
    film_category fc ON f.film_id = fc.film_id
JOIN
    category c ON fc.category_id = c.category_id

-- Напишіть запит, який виведе список фільмів, орендованих клієнтом з іменем "John Smith", разом з датами оренди.
SELECT
    f.title AS film_title,
    r.rental_period AS rental_period
FROM
    rental r
JOIN
    customer c ON r.customer_id = c.customer_id
JOIN
    inventory i ON r.inventory_id = i.inventory_id
JOIN
    film f ON i.film_id = f.film_id
WHERE
    c.first_name = 'ROBERTO'
    AND c.last_name = 'VU';

-- Напишіть запит, який виведе топ-5 найпопулярніших фільмів на основі кількості оренд.
SELECT
    f.title AS film_title,
    COUNT(r.rental_id) AS rental_count
FROM
    rental r
JOIN
    inventory i ON r.inventory_id = i.inventory_id
JOIN
    film f ON i.film_id = f.film_id
GROUP BY
    f.title
ORDER BY
    rental_count DESC
LIMIT 5;

-- Додайте новий запис у таблицю клієнтів. Ім'я клієнта — "Alice Cooper", адреса — "123 Main St", місто — "San Francisco".
INSERT INTO city
    (city, country_id, last_update)
VALUES
    (
        'San Francisco',
        (SELECT country_id
         FROM country
         WHERE country = 'United States'),
        NOW()
    );

INSERT INTO address
    (address, address2, district, city_id, postal_code, phone, last_update)
VALUES
    (
        '123 Main St',
        '',
        'District 1',
        (SELECT city_id
         FROM city
         WHERE city = 'San Francisco'),
        '1234',
        '345-232',
        NOW()
    );

INSERT INTO customer
    (store_id, first_name, last_name, email, address_id, activebool, create_date, last_update)
VALUES
    (
        1,
        'ALICE',
        'COOPER',
        'email@mail',
        (SELECT address_id
         FROM address
         WHERE address = '123 Main St'
         LIMIT 1),
        TRUE,
        NOW(),
        NOW()
    );

--  Оновіть адресу клієнта "Alice Cooper" на "456 Elm St".

UPDATE address
SET
    address = '456 Elm St',
    last_update = NOW()
WHERE
    address_id = (SELECT address_id
                  FROM customer
                  WHERE first_name = 'Alice' AND last_name = 'Cooper');

-- Видаліть запис про клієнта "Alice Cooper" з бази даних.
DELETE FROM address
WHERE address_id = (SELECT address_id
                     FROM customer
                     WHERE first_name = 'Alice' AND last_name = 'Cooper');

DELETE FROM customer
WHERE first_name = 'Alice' AND last_name = 'Cooper';