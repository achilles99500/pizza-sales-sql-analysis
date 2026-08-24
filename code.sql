CREATE DATABASE pizza_sales;
USE pizza_sales;

-- Retrieve the total number of orders placed
SELECT COUNT(order_id) AS total_orders 
FROM orders;

-- Calculate the total revenue generated from pizza sales
SELECT ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM order_details od
JOIN pizzas p 
  ON od.pizza_id = p.pizza_id;
  
-- Identify the highest-priced pizza
SELECT pt.name, p.price 
FROM pizzas p
JOIN pizza_types pt 
  ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;
  
-- Identify the most common pizza size ordered
SELECT p.size, COUNT(od.order_details_id) AS order_count
FROM order_details od
JOIN pizzas p 
  ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY order_count DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities
SELECT pt.name, SUM(od.quantity) AS total_quantity
FROM pizza_types pt
JOIN pizzas p 
  ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od 
  ON p.pizza_id = od.pizza_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered
SELECT pt.category, SUM(od.quantity) AS total_quantity
FROM pizza_types pt
JOIN pizzas p 
  ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od 
  ON p.pizza_id = od.pizza_id
GROUP BY pt.category
ORDER BY total_quantity DESC;

-- Determine the distribution of orders by hour of the day
SELECT HOUR(time) AS hour_of_day, COUNT(order_id) AS order_count
FROM orders
GROUP BY HOUR(time)
ORDER BY hour_of_day;

-- Join relevant tables to find the category-wise distribution of pizzas
SELECT category, COUNT(pizza_type_id) AS pizza_count
FROM pizza_types
GROUP BY category
ORDER BY pizza_count DESC;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT ROUND(AVG(daily_quantity), 0) AS avg_pizzas_per_day
FROM (
    SELECT o.date, SUM(od.quantity) AS daily_quantity
    FROM orders o
    JOIN order_details od 
      ON o.order_id = od.order_id
    GROUP BY o.date
) AS daily_orders;

-- Determine the top 3 most ordered pizza types based on revenue.
SELECT pt.name, ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM pizza_types pt
JOIN pizzas p 
  ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od 
  ON p.pizza_id = od.pizza_id
GROUP BY pt.name
ORDER BY total_revenue DESC
LIMIT 3;

-- Calculate the percentage contribution of each pizza category to total revenue.
SELECT pt.category, 
       ROUND(SUM(od.quantity * p.price) / (SELECT SUM(od2.quantity * p2.price) 
                                           FROM order_details od2 
                                           JOIN pizzas p2 ON od2.pizza_id = p2.pizza_id) * 100, 2) AS revenue_percentage
FROM pizza_types pt
JOIN pizzas p 
  ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od 
  ON p.pizza_id = od.pizza_id
GROUP BY pt.category
ORDER BY revenue_percentage DESC;

-- Analyze the cumulative revenue generated over time
WITH DailyRevenue AS (
    SELECT o.date, ROUND(SUM(od.quantity * p.price), 2) AS daily_revenue
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN pizzas p ON od.pizza_id = p.pizza_id
    GROUP BY o.date
)
SELECT date, 
       daily_revenue, 
       ROUND(SUM(daily_revenue) OVER (ORDER BY date), 2) AS cumulative_revenue
FROM DailyRevenue;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
WITH CategoryRevenue AS (
    SELECT pt.category, pt.name, SUM(od.quantity * p.price) AS revenue
    FROM pizza_types pt
    JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
    JOIN order_details od ON p.pizza_id = od.pizza_id
    GROUP BY pt.category, pt.name
),
RankedPizzas AS (
    SELECT category, name, ROUND(revenue, 2) AS revenue,
           RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS rank_num
    FROM CategoryRevenue
)
SELECT category, name, revenue
FROM RankedPizzas
WHERE rank_num <= 3;