use supply_db ;


/*Question : Golf related products

List all products in categories related to golf. Display the Product_Id, Product_Name in the output. Sort the output in the order of product id.
Hint: You can identify a Golf category by the name of the category that contains golf.

*/

select Product_Name, Product_Id 
from product_info join category on product_info.Category_Id=category.Id
where category.Name like "%golf%"
order by Product_Id;

-- **********************************************************************************************************************************

/*
Question : Most sold golf products

Find the top 10 most sold products (based on sales) in categories related to golf. Display the Product_Name and Sales column in the output. Sort the output in the descending order of sales.
Hint: You can identify a Golf category by the name of the category that contains golf.

HINT:
Use orders, ordered_items, product_info, and category tables from the Supply chain dataset.
*/

SELECT Product_Name, SUM(Sales) AS Sales
FROM product_info JOIN category ON product_info.Category_Id = category.Id
JOIN ordered_items ON product_info.Product_Id = ordered_items.Item_id
WHERE Name LIKE "%golf%"
GROUP BY Product_Name
ORDER BY Sales DESC
LIMIT 10;

-- **********************************************************************************************************************************

/*
Question: Segment wise orders

Find the number of orders by each customer segment for orders. Sort the result from the highest to the lowest 
number of orders.The output table should have the following information:
-Customer_segment
-Orders
*/

select Segment as customer_segment, count(Order_Id) as Orders 
from customer_info as c join orders as o on c.Id=o.Customer_Id
group by Segment
order by Orders desc;


-- **********************************************************************************************************************************
/*
Question : Percentage of order split

Description: Find the percentage of split of orders by each customer segment for orders that took six days 
to ship (based on Real_Shipping_Days). Sort the result from the highest to the lowest percentage of split orders,
rounding off to one decimal place. The output table should have the following information:
-Customer_segment
-Percentage_order_split

HINT:
Use the orders and customer_info tables from the Supply chain dataset.


*/

SELECT Segment as customer_segment,
ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM orders WHERE Real_Shipping_Days = 6), 1) 
AS percentage_order_split
FROM customer_info join orders on customer_info.Id=orders.Customer_Id
WHERE Real_Shipping_Days = 6
GROUP BY Customer_segment
ORDER BY Percentage_order_split DESC;

-- **********************************************************************************************************************************
