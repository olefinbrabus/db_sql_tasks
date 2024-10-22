-- 1 Загальна кількість фільмів у кожній категорії
SELECT c.name AS category, COUNT(f.film_id) AS film_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

-- 2 Середня тривалість фільмів у кожній категорії
SELECT c.name AS category, ROUND(AVG(f.length)) AS avg_length
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

-- 3 Мінімальна та максимальна тривалість фільмів
SELECT f.title, f.length
FROM film f
WHERE f.length = (SELECT MIN(length) FROM film)
   OR f.length = (SELECT MAX(length) FROM film);

-- 4 Загальна кількість клієнтів
SELECT COUNT(customer_id) AS total_customers
FROM customer;

-- 5 Сума платежів по кожному клієнту
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, SUM(p.amount) AS total_payments
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

-- 6 П’ять клієнтів з найбільшою сумою платежів
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, SUM(p.amount) AS total_payments
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_payments DESC
LIMIT 5;

-- 7 Загальна кількість орендованих фільмів кожним клієнтом
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, COUNT(r.rental_id) AS total_rentals
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

-- 8 Середній вік фільмів у базі даних:
SELECT AVG(EXTRACT(YEAR FROM CURRENT_DATE) - f.release_year) AS avg_film_age
FROM film f;

-- 9 Кількість фільмів, орендованих за певний період
SELECT COUNT(r.rental_id) AS total_rentals
FROM rental r
WHERE r.rental_period && tsrange('2002-01-01', '2015-06-24', '[]');

-- 10 Сума платежів по кожному місяцю
SELECT
    CASE EXTRACT(MONTH FROM p.payment_date)
        WHEN 1 THEN 'Січень'
        WHEN 2 THEN 'Лютий'
        WHEN 3 THEN 'Березень'
        WHEN 4 THEN 'Квітень'
        WHEN 5 THEN 'Травень'
        WHEN 6 THEN 'Червень'
        WHEN 7 THEN 'Липень'
        WHEN 8 THEN 'Серпень'
        WHEN 9 THEN 'Вересень'
        WHEN 10 THEN 'Жовтень'
        WHEN 11 THEN 'Листопад'
        WHEN 12 THEN 'Грудень'
    END AS month,
    SUM(p.amount) AS total_payments
FROM payment p
GROUP BY EXTRACT(MONTH FROM p.payment_date)
ORDER BY EXTRACT(MONTH FROM p.payment_date);

-- 11 Максимальна сума платежу, здійснена клієнтом
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, MAX(p.amount) AS max_payment
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY max_payment DESC;

-- 12 Середня сума платежів для кожного клієнта
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, ROUND(AVG(p.amount)) AS avg_payment
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

-- 13 Кількість фільмів у кожному рейтингу
SELECT f.rating, COUNT(f.film_id) AS film_count
FROM film f
GROUP BY f.rating;

-- 14 Середня сума платежів по кожному магазину
SELECT s.store_id, ROUND(AVG(p.amount)) AS avg_payment
FROM store s
JOIN customer c ON s.store_id = c.store_id
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY s.store_id;