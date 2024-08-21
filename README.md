# Optimizing-Restaurant-Operations:
## Analyzing Order Patterns to Enhance Efficiency and Boost Sales

### Project Overview:
This project carefully examines restaurant order data to identify key trends and insights. Through comprehensive exploratory data analysis, we uncover the slow and fast periods to optimize kitchen operations and improve preparation times. Additionally, we identify the most profitable and frequently ordered menu items, providing a clear picture of customer preferences. The highlight of this analysis is determining which categories of international cuisines should be added to the menu based on current performance, aiming to enhance customer satisfaction and drive sales.

The data set used in this analysis from "Maven Analytics" has two tables with a quarter's worth of orders from a fictitious restaurant serving international cuisine, including the date and time of each order, the items ordered, and additional details on the type, name and price of the items.

### Database Modeling:
A database is created for cases where the analysis is a continuous process to simplify data management and analysis pipeline by connecting to Power BI for visualization.

See database modeling script (SQL Server):
[restaurant orders analytics.sql](https://github.com/jakejosh6751/Optimizing-Restaurant-Operations/blob/main/restaurant%20orders%20analytics.sql)

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

### Data Preprocessing:
* data types
* dax
* calculated columns
* date table

### Data Exploration (questions & chart type):

### Report:
![restaurant orders report_1.jpg](https://github.com/jakejosh6751/Optimizing-Restaurant-Operations/blob/main/restaurant%20orders%20report_1.jpg)
[Interactive Power BI report]()

### Insight and Recommendations:
![restaurant orders report_2.jpg](https://github.com/jakejosh6751/Optimizing-Restaurant-Operations/blob/main/restaurant%20orders%20report_2.jpg)

