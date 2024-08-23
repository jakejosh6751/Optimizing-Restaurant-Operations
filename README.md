# Optimizing-Restaurant-Operations:
## Analyzing Order Patterns to Enhance Efficiency and Boost Sales

### Project Overview:
This project carefully examines restaurant order data to identify key trends and insights. Through comprehensive exploratory data analysis, we uncover the slow and fast periods to optimize kitchen operations and improve preparation times. Additionally, we identify the most profitable and frequently ordered menu items, providing a clear picture of customer preferences. The highlight of this analysis is determining which categories of international cuisines should be added to the menu based on current performance, aiming to enhance customer satisfaction and drive sales.

The data set used in this analysis from "Maven Analytics" has two tables with a quarter's worth of orders from a fictitious restaurant serving international cuisine, including the date and time of each order, the items ordered, and additional details on the type, name and price of the items.

### Database Modeling:
A database is created for cases where the analysis is a continuous process to simplify data management and analysis pipeline by connecting to Power BI for visualization.

See database modeling script (SQL Server):
[restaurant orders database model.sql](https://github.com/jakejosh6751/Optimizing-Restaurant-Operations/blob/main/restaurant%20orders%20database%20design.sql)

### Data Extraction:
Data is fetched into Power BI from SQL Server using the "import" connectivity mode. The following SQL statement is used;
```sql
select
	--o.item_id,
	--m.menu_item_id,
	order_id,
	m.item_name,
	m.category,
	m.price,
	o.order_date,
	cast(datepart(hour, o.order_time) as varchar(2)) + ':00:00' as order_hour
from order_details o
	left join menu_items m
		on o.item_id = m.menu_item_id;
```
Before loading data, the data type for "order_hour" is adjusted to 'time'. It is initially assigned 'text' in power bi because of the format used in the SQL query statement.

### Data Pre-processing:
* Date Table

A calendar table is created in Power BI with the following script to support charts with date data;
```dax
dim_date = 
ADDCOLUMNS(
 CALENDAR(DATE(2023,1,1),DATE(2023,12,31)),
    "Year", YEAR([Date]),
    "Month", FORMAT([Date],"mmm"),
    "month num", MONTH([Date]),
    "Quarter", FORMAT([Date], "\QQ"),
    "Weekday", FORMAT([Date],"ddd"),
    "weekday num", WEEKDAY([Date]),
    "Week num", WEEKNUM([Date]),
    "DayOfMonth", day([Date])
)
```
* Measure

The "Total Orders" Measure is created to ensure number formatting with the comma (,);
```dax
Total Orders = COUNTROWS('restaurant_orders')
```
* Calculated Column

A new column is added to the original table
"restaurant_orders" with the following script to enable hourly display with the am/pm format in graphs;
```dax
order_hour am/pm = FORMAT(restaurant_orders[order_hour], "h am/pm")
```

### Data Exploration:
The following questions were explored;
1. What were the top 5 and bottom 5 ordered items? What categories were they in?
2. Were there certain times or days that had more or less orders?
3. Which cuisines should we focus on developing more menu items for base on the data?

### Report:
![restaurant orders report_1.jpg](https://github.com/jakejosh6751/Optimizing-Restaurant-Operations/blob/main/restaurant%20orders%20report_1.jpg)
[Explore interactive Power BI report here](https://app.powerbi.com/groups/me/reports/e82e0178-1c60-452d-a3f6-de0cfbff85ab/ReportSection?experience=power-bi)

### Insight and Recommendations:
![restaurant orders report_2.jpg](https://github.com/jakejosh6751/Optimizing-Restaurant-Operations/blob/main/restaurant%20orders%20report_2.jpg)

