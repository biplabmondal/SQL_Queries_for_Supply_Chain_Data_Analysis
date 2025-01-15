use supply_db ;

/*  Question: Month-wise NIKE sales

	Description:
		Find the combined month-wise sales and quantities sold for all the Nike products. 
        The months should be formatted as ‘YYYY-MM’ (for example, ‘2019-01’ for January 2019). 
        Sort the output based on the month column (from the oldest to newest). The output should have following columns :
			-Month
			-Quantities_sold
			-Sales
		HINT:
			Use orders, ordered_items, and product_info tables from the Supply chain dataset.
*/		

select DATE_FORMAT(Order_Date, '%Y-%m') as Month, sum(Quantity) as Quantities_Sold, 
sum(Sales) as Sales
from product_info as p join ordered_items as od on p.Product_Id=od.Item_Id
join orders as o on od.Order_Id=o.Order_Id
where Product_Name like "%Nike%"
group by Month;





-- **********************************************************************************************************************************
/*

Question : Costliest products

Description: What are the top five costliest products in the catalogue? Provide the following information/details:
-Product_Id
-Product_Name
-Category_Name
-Department_Name
-Product_Price

Sort the result in the descending order of the Product_Price.

HINT:
Use product_info, category, and department tables from the Supply chain dataset.


*/

select Product_Id, Product_Name, c.Name as Category_Name, d.Name as Department_Name, Product_Price 
from product_info as p join category as c on p.Category_Id=c.Id
join department as d on p.Department_Id=d.Id
order by Product_Price desc
limit 5;


-- **********************************************************************************************************************************

/*

Question : Cash customers

Description: Identify the top 10 most ordered items based on sales from all the ‘CASH’ type orders. 
Provide the Product Name, Sales, and Distinct Order count for these items. Sort the table in descending
 order of Order counts and for the cases where the order count is the same, sort based on sales (highest to
 lowest) within that group.
 
HINT: Use orders, ordered_items, and product_info tables from the Supply chain dataset.


*/

select Product_Name, sum(Sales) as Sales, count(Distinct o.Order_ID) as "Distinct Order count"
from ordered_items as od join product_info as p on od.Item_Id=p.Product_Id
join orders as o on od.Order_Id=o.Order_Id
where o.Type LIKE "%CASH%"
group by Product_Name
order by count(Distinct o.Order_ID) desc, Sales Desc
limit 10
;


-- **********************************************************************************************************************************
/*
Question : Customers from texas

Obtain all the details from the Orders table (all columns) for customer orders in the state of Texas (TX),
whose street address contains the word ‘Plaza’ but not the word ‘Mountain’. The output should be sorted by the Order_Id.

HINT: Use orders and customer_info tables from the Supply chain dataset.

*/

select o.* from orders as o join customer_info as c on o.Customer_Id=c.Id
where State="TX" and Street like "%Plaza%" and Street not like "%Mountain%"
order by Order_Id 
;

-- **********************************************************************************************************************************
/*
 
Question: Home office

For all the orders of the customers belonging to “Home Office” Segment and have ordered items belonging to
“Apparel” or “Outdoors” departments. Compute the total count of such orders. The final output should contain the 
following columns:
-Order_Count

*/

select count(o.Order_Id) as Order_Count 
from orders as o 
join customer_info as c on o.Customer_Id=c.Id
join ordered_items as od on o.Order_Id=od.Order_Id
join product_info as p on od.Item_Id=p.Product_Id
join department as d on p.Department_Id=d.Id 
where c.Segment="Home Office" and (d.Name="Apparel" or d.Name="Outdoors")
group by Segment;

-- **********************************************************************************************************************************
/*

Question : Within state ranking
 
For all the orders of the customers belonging to “Home Office” Segment and have ordered items belonging
to “Apparel” or “Outdoors ” departments. Compute the count of orders for all combinations of Order_State and Order_City. 
Rank each Order_City within each Order State based on the descending order of their order count (use dense_rank). 
The states should be ordered alphabetically, and Order_Cities within each state should be ordered based on their rank. 
If there is a clash in the city ranking, in such cases, it must be ordered alphabetically based on the city name. 
The final output should contain the following columns:
-Order_State
-Order_City
-Order_Count
-City_rank

HINT: Use orders, ordered_items, product_info, customer_info, and department tables from the Supply chain dataset.

*/

WITH OrderCounts AS (
    SELECT 
        o.Order_State,
        o.Order_City,
        COUNT(o.Order_Id) AS Order_Count,
        DENSE_RANK() OVER (PARTITION BY o.Order_State ORDER BY COUNT(o.Order_Id) DESC, o.Order_City) AS City_Rank
    FROM 
        orders AS o 
    JOIN 
        customer_info AS c ON o.Customer_Id = c.Id
    JOIN 
        ordered_items AS od ON o.Order_Id = od.Order_Id
    JOIN 
        product_info AS p ON od.Item_Id = p.Product_Id
    JOIN 
        department AS d ON p.Department_Id = d.Id 
    WHERE 
        c.Segment = "Home Office" 
        AND (d.Name = "Apparel" OR d.Name = "Outdoors")
    GROUP BY 
        o.Order_State, o.Order_City
)
SELECT 
    Order_State,
    Order_City,
    Order_Count,
    City_Rank
FROM 
    OrderCounts
ORDER BY 
    Order_State, City_Rank, Order_City;


-- **********************************************************************************************************************************
/*
Question : Underestimated orders

Rank (using row_number so that irrespective of the duplicates, so you obtain a unique ranking) the 
shipping mode for each year, based on the number of orders when the shipping days were underestimated 
(i.e., Scheduled_Shipping_Days < Real_Shipping_Days). The shipping mode with the highest orders that meet 
the required criteria should appear first. Consider only ‘COMPLETE’ and ‘CLOSED’ orders and those belonging to 
the customer segment: ‘Consumer’. The final output should contain the following columns:
-Shipping_Mode,
-Shipping_Underestimated_Order_Count,
-Shipping_Mode_Rank

HINT: Use orders and customer_info tables from the Supply chain dataset.


*/

WITH UnderestimatedOrders AS (
 SELECT
  o.Shipping_Mode,
  COUNT(*) AS Shipping_Underestimated_Order_Count,
  ROW_NUMBER() OVER (PARTITION BY YEAR(o.Order_Date) ORDER BY COUNT(*) DESC) AS Shipping_Mode_Rank,
  YEAR(o.Order_Date) AS Order_Year
 FROM
  orders AS o
 JOIN
  customer_info AS c ON o.Customer_Id = c.Id
 WHERE
  o.Order_Status IN ('COMPLETE', 'CLOSED')
  AND c.Segment = 'Consumer'
  AND o.Scheduled_Shipping_Days < o.Real_Shipping_Days
 GROUP BY
  Order_Year, o.Shipping_Mode
)
SELECT
 Shipping_Mode,
 Shipping_Underestimated_Order_Count,
 Shipping_Mode_Rank
FROM
 UnderestimatedOrders
ORDER BY
 Order_Year, Shipping_Mode_Rank;
  


-- **********************************************************************************************************************************




