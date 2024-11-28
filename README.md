Inventory Management System: Superstore Inventory Analysis

Description:
Developed a comprehensive inventory management system for a multi-branch superstore using SQL to streamline inventory tracking, reporting, and analysis. The project focused on ensuring efficient stock control, identifying trends, and enabling data-driven decision-making for supply chain and operational processes.

Key Features and Highlights:

Database Design:
Designed a normalized database structure to manage inventory for multiple branches, including tables for items, suppliers, stock levels, and branch locations.
Implemented relationships to enable multi-branch analysis and supplier tracking.
Core Functionalities:
Low Stock Alerts: Automated detection of items below the reorder level.
Expired Items Flagging: Dynamically updated item status to "Expired" based on expiry dates.
Monthly Inventory Trends: Generated monthly trend reports to analyze inventory additions by branch.
Category-Wise Summaries: Produced summaries for total stock and average prices for each category.
Branch Performance Analysis: Ranked branches based on total inventory value and calculated the percentage of low stock items.
Supplier Analysis: Identified items supplied by multiple suppliers and their associated suppliers.

SQL Techniques Used:
Complex queries involving GROUP BY, JOINs, and Common Table Expressions (CTEs).
Aggregate functions (SUM, AVG, MAX, MIN) to generate detailed reports.
Subqueries and window functions like DENSE_RANK() to rank branches and identify key metrics.
Data manipulation using CASE statements to dynamically calculate flags and percentages.
Advanced Reporting:
Created insightful reports, such as category-wise stock summaries, trend analysis for inventory additions, and branch-specific inventory value breakdowns.
Business Impact:
Improved decision-making with real-time low stock alerts and expiry notifications.
Enabled better supplier management by identifying items with multiple suppliers.
Helped streamline restocking operations by analyzing monthly trends and stock efficiency.

Technologies Used:
SQL (MySQL Workbench) for database creation, data manipulation, and querying.
Microsoft Excel (for visualization and reporting integration).

Key Outcomes:
Enhanced inventory tracking and management for a multi-branch system.
Reduced wastage by proactively flagging expired or low stock items.
Improved operational efficiency through detailed trend and performance analyses.