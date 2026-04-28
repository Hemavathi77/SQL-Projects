create database ola_rides;
use ola_rides;

CREATE TABLE ola (
  ride_date VARCHAR(32),
  booking_id VARCHAR(32),
  booking_status VARCHAR(16),
  customer_id VARCHAR(16),
  vehicle_type VARCHAR(32),
  pickup_location VARCHAR(64),
  drop_location VARCHAR(64),
  v_tat INT,
  c_tat INT,
  canceled_by_customer VARCHAR(32),
  canceled_by_driver VARCHAR(64),
  incomplete_ride VARCHAR(8),
  incomplete_reason VARCHAR(64),
  booking_value DECIMAL(10,2),
  payment_method VARCHAR(24),
  ride_distance DECIMAL(10,2),
  driver_ratings DECIMAL(3,2),
  customer_rating DECIMAL(3,2),
  vehicle_images VARCHAR(255),
  hours INT);


select * from ola_rides.ola;


--1. Retrieve all successful bookings
SELECT *FROM ola WHERE Booking_Status = 'Success';



--2. Find the average ride distance for each vehicle type 
SELECT Vehicle_Type, AVG(Ride_Distance) AS avg_ride_distance FROM ola
GROUP BY Vehicle_Type ORDER BY Vehicle_Type;



--3. Get the total number of cancelled rides by customers
SELECT COUNT(*) AS cancelled_by_customer_count FROM ola WHERE Canceled_by_Customer <> 'Not canceled by Customer';



--4. List the top 5 customers who booked the highest number of rides
SELECT Customer_ID, COUNT(*) AS total_rides FROM ola GROUP BY Customer_ID ORDER BY total_rides DESC LIMIT 5;



--5. Get the number of rides cancelled by drivers due to personal and car-related issues
SELECT 
SUM(CASE WHEN Canceled_by_Driver = 'Personal issue' THEN 1 ELSE 0 END) AS personal_issue,
SUM(CASE WHEN Canceled_by_Driver = 'Car related issue' THEN 1 ELSE 0 END) AS car_related_issue
FROM ola;



--6.Find the maximum and minimum driver ratings for Prime Sedan bookings
SELECT 
MAX(Driver_Ratings) AS max_driver_rating,
MIN(Driver_Ratings) AS min_driver_rating
FROM ola WHERE Vehicle_Type = 'Prime Sedan'AND Driver_Ratings IS NOT NULL;



--7. Retrieve all rides where payment was made using UPI
SELECT * FROM ola WHERE Payment_Method = 'UPI';



--8.Find the average customer rating per vehicle type
SELECT Vehicle_Type, AVG(Customer_Rating) AS avg_customer_rating FROM ola GROUP BY Vehicle_Type
ORDER BY Vehicle_Type;



--9.Calculate the total booking value of rides completed successfully
SELECT SUM(Booking_Value) AS total_success_booking_value FROM ola WHERE Booking_Status = 'Success';


--10. List all incomplete rides along with the reason

SELECT
  Booking_ID,Customer_ID,Vehicle_Type,Pickup_Location,Drop_Location,Incomplete_Ride,Incomplete_Reason
FROM ola WHERE Incomplete_Ride = 'Yes';
