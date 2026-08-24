# 🍕 Pizza Sales SQL Data Analysis & Business Intelligence

**Author:** Adarsh Vardhan  
**Tools Used:** MySQL, Relational Database Modeling, Advanced SQL Analytics  

## 📌 Project Objective
The goal of this project was to analyze a full year of sales transactions from a pizza restaurant to uncover operational bottlenecks, optimize menu offerings, and perform financial modeling. Using a custom-built relational database, I implemented a complete progression of SQL queries—ranging from foundational aggregations to expert-level market basket analysis and dynamic pricing simulations—to extract data-driven business insights.

## 🗄️ Database Schema
The project is built on a normalized relational database consisting of four interconnected tables:
* **`orders`**: Contains order IDs, dates, and timestamps for every transaction.
* **`order_details`**: Relational mapping table linking orders to specific pizzas and quantities.
* **`pizzas`**: Contains individual pizza variants, sizes, and pricing.
* **`pizza_types`**: Contains overarching product categories, names, and ingredient lists.

## 📋 Comprehensive Query Breakdown & Tasks Solved

### 🟢 Basic Tier
1. **Total Orders:** Retrieved the total number of orders placed (21,350 unique orders).
2. **Total Revenue:** Calculated the total revenue generated from all pizza sales ($817,860.05).
3. **Highest-Priced Pizza:** Identified the most expensive item on the menu (*The Greek Pizza* at $35.95).
4. **Most Common Size:** Determined that size **L** (Large) is the most frequently ordered pizza size.
5. **Top 5 Pizza Types:** Listed the top 5 most ordered pizza types by volume (led by *The Classic Deluxe*).

### 🟡 Intermediate Tier
6. **Category-wise Quantities:** Found the total quantity ordered across each pizza category (Classic leading with 14,888 units).
7. **Order Distribution by Hour:** Extracted order timestamps to uncover peak operational hours (massive spikes at 12:00 PM and 1:00 PM).
8. **Category Distribution:** Counted the distinct number of pizza types available per category.
9. **Average Daily Orders:** Used a subquery framework to calculate the average volume of pizzas ordered per day (~138 pizzas/day).
10. **Top Revenue Items:** Determined the top 3 best-selling pizzas strictly by revenue generation (*Thai Chicken*, *Barbecue Chicken*, and *California Chicken*).

### 🔴 Advanced & Expert Tier
11. **Revenue Percentage Contribution:** Calculated each category's exact financial contribution relative to grand total revenue using subquery aggregations.
12. **Cumulative Revenue Over Time:** Utilized window functions (`SUM() OVER (ORDER BY date)`) to track running daily revenue growth.
13. **Category Rankings (Window Functions):** Deployed `RANK() OVER (PARTITION BY category ...)` to isolate the top 3 revenue-generating pizzas *within each specific category*.
14. **Market Basket Analysis (Self-Joins):** Engineered a multi-table self-join with strict inequality filters (`od1.pizza_id < od2.pizza_id`) to map co-purchased product pairs (e.g., *Hawaiian* and *Thai Chicken* bought together 319 times) for combo-deal optimization.
15. **Dynamic Pricing Simulation (Control Flow):** Modeled a hypothetical 15% off afternoon "Happy Hour" using conditional `CASE WHEN` logic embedded inside aggregations, projecting annual revenue shifts.

## 💻 Technical SQL Skills Demonstrated
* **Multi-Table Joins:** Connecting up to 4 normalized tables simultaneously using inner joins.
* **Window Functions:** Utilizing `RANK()`, `PARTITION BY`, and cumulative running sums (`SUM() OVER`).
* **Self-Joins & Inequality Constraints:** Handling complex row-to-row matching within the same table.
* **Conditional Control Flow:** Using `CASE WHEN` expressions for "what-if" financial simulations.
* **Subqueries & CTEs:** Breaking complex calculations down into modular, maintainable logic blocks.

