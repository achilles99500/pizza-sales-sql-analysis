
# 🍕 Pizza Sales SQL Data Analysis

Author: Adarsh Vardhan  
Tools Used: MySQL, Data Modeling, Database Architecture  

## 📌 Project Objective
The goal of this project was to analyze a year's worth of sales data from a fictional pizza restaurant to discover operational bottlenecks, optimize inventory, and identify the most profitable menu items. I built a relational database from scratch and utilized advanced SQL techniques to extract actionable business insights.

## 🗄️ Database Schema
The analysis was performed on a normalized relational database containing four tables:
* **`orders`**: Contains the order ID, date, and time.
* **`order_details`**: Maps the order ID to specific pizzas and quantities.
* **`pizzas`**: Contains the pizza ID, size, and price.
* **`pizza_types`**: Contains the pizza name, category, and ingredients.

## 🚀 Key Business Insights
* **Peak Operational Hours:** The highest volume of orders occurs at 12:00 PM and 1:00 PM, suggesting a need for increased staffing during lunch rushes.
* **Top Revenue Drivers:** Despite the "Classic Deluxe" being the most frequently ordered pizza, the **Thai Chicken Pizza** generated the highest overall revenue ($43,434.25), indicating that premium pricing strategies are effective for specialty items.
* **Category Performance:** The "Classic" category contributes to 26.91% of total revenue, making it the most profitable category overall.
* **Order Volume:** The restaurant processed exactly 21,350 unique orders over the course of the year, averaging approximately 138 pizzas sold per day.

## 💻 Advanced SQL Techniques Demonstrated
In this project, I utilized several advanced SQL functions to manipulate and analyze the data:
* **Multi-Table Joins:** Used `INNER JOIN` across up to 3-4 tables simultaneously to connect sales metrics with product dimensions.
* **Window Functions:** Utilized `SUM() OVER()` to calculate rolling cumulative revenue over time, and `RANK() OVER (PARTITION BY ...)` to determine the top 3 best-selling pizzas strictly within their respective categories.
* **Subqueries & CTEs:** Leveraged Common Table Expressions (`WITH` clauses) to create temporary result sets for complex multi-step percentage calculations.

