# 🌯 Analyzing ROLLFIESTA: A Food Ordering Startup 🌯

RollFiesta is a well-known food delivery company that primarily operates in India. It was established in 2020 and initially started as a quick-service restaurant chain specializing in wraps and fast food items. As the demand for convenient food options grew, it transformed into an online food delivery platform.

The company gained popularity by introducing the concept of "wraps on wheels" and allowed foodies to create their own custom Rolls and Wraps. RollFiesta focused on delivering tasty and affordable meals with efficient delivery services.

By utilizing technology, they streamlined the ordering process, enabling customers to conveniently place their orders through a user-friendly mobile app or website.

RollFiesta experienced significant growth and secured funding from various investors, which allowed it to expand its operations across multiple cities in India.

RollFiesta focuses on providing a seamless and enjoyable dining experience for its customers.

## 🗃️ Database Structure: 🗃️

### The database consists of 6 tables as shown below.

![image](https://github.com/prithush92/Analyzing-a-food-ordering-startup/assets/126896351/9cdc9a50-a79a-4327-9aeb-82129a614b32)

### 📋 Column names and their datatypes for each table are shown below. 📋
<hr>

```1. Customer_Orders: Contains information about orders placed by the customers including order data and ingredients of the order.```

![image](https://github.com/prithush92/Analyzing-a-food-ordering-startup/assets/126896351/b42a3ee9-c5b7-4af8-b794-a87e98b5176f)

```2. Driver: Contains driver_id and registration_date of the driver.```

![image](https://github.com/prithush92/Analyzing-a-food-ordering-startup/assets/126896351/c02c4a7c-d127-4ae1-ba8a-5564c128d100)

```3. Driver_Order: Contains details about the orders such as pickup_time, delivery_duration, delivery_distance, etc```

![image](https://github.com/prithush92/Analyzing-a-food-ordering-startup/assets/126896351/0d7d2979-4189-4ca4-9bf6-62dd87105b36)


```4. Ingredients: Contains list of available ingredients```

![image](https://github.com/prithush92/Analyzing-a-food-ordering-startup/assets/126896351/0f39282e-729d-4eb1-8c9d-fde8be85fa11)


```5. Rolls: Defines the Rolls as either Veg or Non-Veg```

![image](https://github.com/prithush92/Analyzing-a-food-ordering-startup/assets/126896351/c8edc3a6-47ea-4104-a41f-089be41bc56a)


```6. Rolls_Recipes: Defines the ingredient_ids for both Veg and Non-Veg Rolls```

![image](https://github.com/prithush92/Analyzing-a-food-ordering-startup/assets/126896351/b3cdd329-a803-432d-91d5-e224170a5c2d)

<hr>

## ❓ The following Queries were run as per the client's request:

### Roll Metrics
```
1. How many rolls were ordered?
2. How many unique customer orders were made?
3. How many successful orders were delivered by each driver?
4. How many of each type of roll was delivered?
5. How many veg and non-veg rolls were ordered by each customer?
6. What was the maximum number of rolls delivered in a single order?
7. For each customer, how many delivered rolls had at least one change, and how many had no change?
8. How many rolls were delivered that had both exclusions and extras?
9. What was the total number of rolls ordered for each hour of the day?
10. What was the number of orders for each day of the week?
```

### Driver and Customer Experience
```
11. What was the average time in minutes it took for each driver to arrive at the HQ to pick up the order?
12. Is there any relationship between the number of rolls and how long the order takes to prepare?
13. What was the average distance traveled for each customer?
14. What was the longest and shortest delivery time among all the orders?
15. What was the average speed for each driver for each delivery, and do you notice any trend for these values?
16. What is the successful percentage for each driver?
```

<hr>

## ✨Key Points and Insights:✨
➢ Understanding the popularity and demand for different types of rolls is
crucial for menu planning and inventory management.

➢ Monitoring driver performance and efficiency in successfully delivering
orders is essential for maintaining customer satisfaction.

➢ Analyzing customer preferences for veg and non-veg rolls helps tailor
offerings and target specific segments.

➢ Identifying peak hours and busy days allows for resource allocation and
operational optimization.

➢ Assessing delivery times, distances, and driver speeds helps improve
efficiency and customer experience.
