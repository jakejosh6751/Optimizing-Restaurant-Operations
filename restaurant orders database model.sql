
-- 1. Create Database and Tables
-- 2. Load Data into Tables from csv files
-- 3. Clean Data
-- 4. Extract Data for Analysis
--======================================================

-- 1. Create Database and Tables

-- RestaurantOrders Database
create database RestaurantOrders;
go
use RestaurantOrders;
go

-- menu_items Table
create table menu_items (
	menu_item_id int primary key,
	item_name nvarchar(50) not null,
	category nvarchar(50) not null,
	price float not null
	);
go

-- order_details Table
create table order_details (
	order_details_id int primary key,
	order_id int not null,
	order_date date,
	order_time time(0),
	item_id int,
	foreign key (item_id) references menu_items(menu_item_id)
	);
go

-- 2. Load Data into Tables from csv files

-- insert data into menu_items table
bulk insert menu_items
from 'C:\Users\jake\Desktop\restaurant orders analysis\Restaurant+Orders+CSV\menu_items.csv'
with (
	fieldterminator = ',',
	rowterminator = '\n',
	firstrow = 2
	);
go

-- insert data into order_details table
/* Attribute "item_id" has mixed data type (integer and strings); "NULL" is used in place of BLANKS.
The "Find and Replace" feature in Excel is used to remove "NULL", leaving the affected cells blank and file is saved as csv */
bulk insert order_details
from 'C:\Users\jake\Desktop\restaurant orders analysis\Restaurant+Orders+CSV\order_details_edited.csv'
with (
	fieldterminator = ',',
	rowterminator = '\n',
	firstrow = 2
	);
go

-- 3. Clean Data

-- missing values
select count(*)
from order_details
where item_id is null;		-- 137 values in the item_id column are missing

-- delete rows with missing values
delete
from order_details
where item_id is null;		-- final number of entries is 12,097

-- duplicate entries
with cte as (
	select
		order_details_id, order_id, order_date, order_time, item_id,
	row_number() over(partition by
		order_details_id, order_id, order_date, order_time, item_id
	order by
		order_details_id, order_id, order_date, order_time, item_id) as row_num
	from order_details
	)
	select count(*) from cte where row_num > 1;			-- no duplicates

-- no structural errors, invalid data, outliers, inconsistent data or data type problems

-- 4. Extract Data for Analysis
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
