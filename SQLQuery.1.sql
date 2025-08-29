select COUNT(*)
from menu_items

select *
from menu_items


select *
from order_details


select COUNT(*)
from order_details

/*Objective 1
Explore the items table
Your first objective is to better understand the items table by finding the number of rows in the table, the least and most expensive items, and the item prices within each category.*/

--1-View the menu_items table and

Select * 
from menu_items

--2- write a query to find the number of items on the menu
Select COUNT(*) 
from menu_items

--2.What are the least and most expensive items on the menu?
Select top 1 *
from menu_items
order by price desc ---- Most expensive

Select top 1 *
from menu_items
order by price Asc  ---- Least expensive

select  MAX(price) as max,MIN(price)as min
from menu_items

/* Alternative method
SELECT 
    item_name, 
    price,
    CASE 
        WHEN price = (SELECT MIN(price) FROM menu_items) THEN 'MIN'
        WHEN price = (SELECT MAX(price) FROM menu_items) THEN 'MAX'
    END AS status
FROM menu_items
WHERE price = (SELECT MIN(price) FROM menu_items)
   OR price = (SELECT MAX(price) FROM menu_items);
   */


--3.How many Italian dishes are on the menu? 
Select COUNT (*) Count_Dishes
from menu_items
where category='Italian'
  
--4.What are the least and most expensive Italian dishes on the menu?
Select Top 1 item_name,category,price
from menu_items
where category='Italian' 
order by price Asc         ---- Least expensive

Select Top 1 item_name,category,price
from menu_items
where category='Italian' 
order by price desc   ----    Most expensive


/*Alternative method
SELECT item_name, category, price
FROM menu_items
WHERE category = 'Italian' 
  AND (price = (SELECT MAX(price) FROM menu_items WHERE category = 'Italian')
       OR price = (SELECT MIN(price) FROM menu_items WHERE category = 'Italian'));*/


--5.How many dishes are in each category?

select category,COUNT(item_name) as Dishes
from menu_items
group by category

select *
from menu_items

--6. What is the average dish price within each category?
select category,avg(price) as Avgprice
from menu_items
group by category


---------------------------------------------------------------------------------------------------------------------------------------------------------

/**Objective 2
Explore the orders table
Your second objective is to better understand the orders table by finding the date range, the number of items within each order, and the orders with the highest number of items.***\
*/
Task

--1.View the order_details table. 
select * 
from order_details

--2.What is the date range of the table?
select MIN(order_date) as start_date,MAX(order_date) as End_date
from order_details

--2.How many orders were made within this date range? 
Select COUNT(DISTINCT order_id)
from order_details


--3.How many items were ordered within this date range?
Select COUNT(item_id)
from order_details

--4.Which orders had the most number of items?
select order_id,COUNT(item_id) as Num
from order_details
group by order_id
order by Num desc

--5.How many orders had more than 12 items?

select order_id,COUNT(item_id) as Num
from order_details
group by order_id
having COUNT(item_id)>12
order by Num desc

-----------------------------------------------------------------------------------------------------------------------------------------------------------

/*Objective 3
Analyze customer behavior
Your final objective is to combine the items and orders tables, find the least and most ordered categories, and dive into the details of the highest spend orders.*\
*/
--Task

--1.Combine the menu_items and order_details tables into a single table */

select * from order_details
select * from menu_items

Select * 
from 
order_details od
left join	menu_items mi
on od.item_id=mi.menu_item_id




--2.What were the least and most ordered items? What categories were they in?

Select item_name ,COUNT(order_details_id) as Num_Purchase
from 
order_details od
left join	menu_items mi
on od.item_id=mi.menu_item_id
group by item_name
order by Num_Purchase desc  ------ most ordered items

Select item_name ,COUNT(order_details_id) as Num_Purchase
from 
order_details od
left join	menu_items mi
on od.item_id=mi.menu_item_id
group by item_name
order by Num_Purchase Asc------ Least ordered item


Select item_name ,category,COUNT(order_details_id) as Num_Purchase
from 
order_details od
left join	menu_items mi
on od.item_id=mi.menu_item_id
group by item_name, category
order by Num_Purchase Asc------ Least order ietem/What categories were they in


--3.What were the top 5 orders that spent the most money?

Select top 5 order_id,sum(price)as spent
from 
order_details od
left join	menu_items mi
on od.item_id=mi.menu_item_id
group by order_id
order by spent desc

--4.View the details of the highest spend order. Which specific items were purchased?

Select *
from 
order_details od
left join	menu_items mi
on od.item_id=mi.menu_item_id
where order_id=(Select top 1 order_id
from 
order_details od
left join	menu_items mi
on od.item_id=mi.menu_item_id
group by order_id
order by sum(price)desc)

--4b.Which specific items were purchased?


Select category,COUNT(item_id) as num_items
from 
order_details od
left join	menu_items mi
on od.item_id=mi.menu_item_id
where order_id=(Select top 1 order_id
from 
order_details od
left join	menu_items mi
on od.item_id=mi.menu_item_id
group by order_id
order by sum(price)desc)
group by category



--5. View the details of the top 5 highest spend orders


Select order_id,category,COUNT(item_id) as num_items
from 
order_details od
left join	menu_items mi
on od.item_id=mi.menu_item_id
where order_id in (Select top 5 order_id              --also we can hardcode with (440,2075,1957,330,2675- top 5 orders that spent the most money)
                   from 
                   order_details od
                   left join	menu_items mi
                   on od.item_id=mi.menu_item_id
                   group by order_id
                   order by sum(price)desc)
group by category,order_id
------------------------------------------------------------------------------------------------------------------------------------------------




